import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/send_transaction.dart';
import 'package:aewallet/domain/usecases/transaction/send_transaction.dart';
import 'package:aewallet/domain/usecases/usecase.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.freezed.dart';
part 'provider.g.dart';

@freezed
class SignTransactionConfirmationFormState
    with _$SignTransactionConfirmationFormState {
  const factory SignTransactionConfirmationFormState({
    required RPCCommand<RPCSendTransactionCommandData> signTransactionCommand,
    required Account senderAccount,
  }) = _SignTransactionConfirmationFormState;
  const SignTransactionConfirmationFormState._();
}

class SignTransactionConfirmationFormNotifier
    extends AutoDisposeFamilyAsyncNotifier<SignTransactionConfirmationFormState,
        RPCCommand<RPCSendTransactionCommandData>> {
  @override
  Future<SignTransactionConfirmationFormState> build(
    RPCCommand<RPCSendTransactionCommandData> arg,
  ) async {
    final selectedAccount = await ref.read(
      AccountProviders.selectedAccount.future,
    );
    return SignTransactionConfirmationFormState(
      signTransactionCommand: arg,
      senderAccount: selectedAccount!,
    );
  }

  void setAccount(Account account) {
    state.maybeMap(
      orElse: () => const Result.failure(
        TransactionError.other(reason: 'Form is not loaded yet.'),
      ),
      data: (data) {
        state = AsyncValue.data(
          data.value.copyWith(
            senderAccount: account,
          ),
        );
      },
    );
  }

  Future<Result<TransactionConfirmation, TransactionError>> send(
    UseCaseProgressListener onProgress,
  ) async =>
      state.maybeMap(
        orElse: () => const Result.failure(TransactionError.other()),
        data: (data) {
          final useCase = ref.read(_sendTransactionUseCaseProvider);

          return useCase
              .run(
            SendTransactionCommand(
              senderAccount: data.value.senderAccount,
              data: data.value.signTransactionCommand.data.data,
              type: data.value.signTransactionCommand.data.type,
              version: data.value.signTransactionCommand.data.version,
            ),
            onProgress: onProgress,
          )
              .then((result) {
            return result.map(
              success: Result.success,
              failure: Result.failure,
            );
          });
        },
      );
}

@riverpod
UseCase<SendTransactionCommand,
    Result<TransactionConfirmation, TransactionError>> _sendTransactionUseCase(
  AutoDisposeRef ref,
) =>
    SendTransactionUseCase(
      wallet: ref.watch(SessionProviders.session).loggedIn!.wallet,
      apiService: sl.get<ApiService>(),
      networkSettings: ref.watch(
        SettingsProviders.settings.select((settings) => settings.network),
      ),
    );

class SignTransactionConfirmationProviders {
  static final form = AsyncNotifierProvider.autoDispose.family<
      SignTransactionConfirmationFormNotifier,
      SignTransactionConfirmationFormState,
      RPCCommand<RPCSendTransactionCommandData>>(
    SignTransactionConfirmationFormNotifier.new,
  );
}
