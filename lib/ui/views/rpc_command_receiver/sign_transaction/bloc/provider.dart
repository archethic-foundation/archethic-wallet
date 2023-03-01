import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/domain/service/rpc/commands/send_transaction.dart';
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
    required RPCSendTransactionCommand signTransactionCommand,
    required Account senderAccount,
  }) = _SignTransactionConfirmationFormState;
  const SignTransactionConfirmationFormState._();
}

class SignTransactionConfirmationFormNotifier
    extends AutoDisposeFamilyAsyncNotifier<SignTransactionConfirmationFormState,
        RPCSendTransactionCommand> {
  @override
  Future<SignTransactionConfirmationFormState> build(
    RPCSendTransactionCommand arg,
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
        orElse: () => const Result.failure(
          TransactionError.other(reason: 'Form is not loaded yet.'),
        ),
        data: (data) {
          final useCase = ref.read(_sendTransactionUseCaseProvider);

          return useCase.run(
            SignTransactionCommand(
              senderAccount: data.value.senderAccount,
              data: data.value.signTransactionCommand.data,
              type: data.value.signTransactionCommand.type,
              version: data.value.signTransactionCommand.version,
            ),
            onProgress: onProgress,
          );
        },
      );
}

@riverpod
UseCase<SignTransactionCommand,
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
      RPCSendTransactionCommand>(
    SignTransactionConfirmationFormNotifier.new,
  );
}
