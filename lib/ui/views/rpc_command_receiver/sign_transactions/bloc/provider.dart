import 'package:aewallet/domain/rpc/command.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider.freezed.dart';

@freezed
class SignTransactionsConfirmationFormState
    with _$SignTransactionsConfirmationFormState {
  const factory SignTransactionsConfirmationFormState({
    required RPCAuthenticatedCommand<SignTransactionRequest>
        signTransactionCommand,
  }) = _SignTransactionsConfirmationFormState;
  const SignTransactionsConfirmationFormState._();
}

class SignTransactionsConfirmationFormNotifier
    extends AutoDisposeFamilyAsyncNotifier<
        SignTransactionsConfirmationFormState,
        RPCAuthenticatedCommand<SignTransactionRequest>> {
  @override
  Future<SignTransactionsConfirmationFormState> build(
    RPCAuthenticatedCommand<SignTransactionRequest> arg,
  ) async {
    return SignTransactionsConfirmationFormState(
      signTransactionCommand: arg,
    );
  }
}

class SignTransactionsConfirmationProviders {
  static final form = AsyncNotifierProvider.autoDispose.family<
      SignTransactionsConfirmationFormNotifier,
      SignTransactionsConfirmationFormState,
      RPCAuthenticatedCommand<SignTransactionRequest>>(
    SignTransactionsConfirmationFormNotifier.new,
  );
}
