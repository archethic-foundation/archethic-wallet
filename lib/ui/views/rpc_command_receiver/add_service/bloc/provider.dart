import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command.dart';
import 'package:aewallet/domain/usecases/transaction/send_transaction.dart';
import 'package:aewallet/domain/usecases/usecase.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.freezed.dart';
part 'provider.g.dart';

@freezed
class AddServiceConfirmationFormState with _$AddServiceConfirmationFormState {
  const factory AddServiceConfirmationFormState({
    required RPCSessionOrigin sessionOrigin,
    required SendTransactionRequest signTransactionCommand,
  }) = _AddServiceConfirmationFormState;
  const AddServiceConfirmationFormState._();
}

class AddServiceConfirmationFormNotifier extends AutoDisposeFamilyAsyncNotifier<
    AddServiceConfirmationFormState,
    RPCAuthenticatedCommand<SendTransactionRequest>> {
  @override
  Future<AddServiceConfirmationFormState> build(
    RPCAuthenticatedCommand<SendTransactionRequest> arg,
  ) async {
    return AddServiceConfirmationFormState(
      sessionOrigin: arg.origin,
      signTransactionCommand: arg.data,
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
              data: data.value.signTransactionCommand.data,
              type: data.value.signTransactionCommand.type,
              version: data.value.signTransactionCommand.version,
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
      RPCAuthenticatedCommand<AddServiceRequest>>(
    AddServiceConfirmationFormNotifier.new,
  );
}
