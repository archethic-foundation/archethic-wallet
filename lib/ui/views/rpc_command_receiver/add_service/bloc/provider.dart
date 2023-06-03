import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/send_transaction.dart';
import 'package:aewallet/domain/usecases/transaction/send_transaction.dart';
import 'package:aewallet/domain/usecases/usecase.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.freezed.dart';
part 'provider.g.dart';

@freezed
class AddServiceConfirmationFormState with _$AddServiceConfirmationFormState {
  const factory AddServiceConfirmationFormState({
    required RPCCommand<RPCSendTransactionCommandData> signTransactionCommand,
  }) = _AddServiceConfirmationFormState;
  const AddServiceConfirmationFormState._();
}

class AddServiceConfirmationFormNotifier extends AutoDisposeFamilyAsyncNotifier<
    AddServiceConfirmationFormState,
    RPCCommand<RPCSendTransactionCommandData>> {
  @override
  Future<AddServiceConfirmationFormState> build(
    RPCCommand<RPCSendTransactionCommandData> arg,
  ) async {
    return AddServiceConfirmationFormState(
      signTransactionCommand: arg,
    );
  }

  Future<Result<TransactionConfirmation, TransactionError>> send(
    UseCaseProgressListener onProgress,
  ) async =>
      state.maybeMap(
        orElse: () => const Result.failure(TransactionError.other()),
        data: (data) {
          final useCase = ref.read(_sendTransactionUseCaseProvider);
          final accountSelected =
              ref.watch(AccountProviders.selectedAccount).valueOrNull;
          return useCase
              .run(
            SendTransactionCommand(
              senderAccount: accountSelected!,
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

class AddServiceConfirmationProviders {
  static final form = AsyncNotifierProvider.autoDispose.family<
      AddServiceConfirmationFormNotifier,
      AddServiceConfirmationFormState,
      RPCCommand<RPCSendTransactionCommandData>>(
    AddServiceConfirmationFormNotifier.new,
  );
}
