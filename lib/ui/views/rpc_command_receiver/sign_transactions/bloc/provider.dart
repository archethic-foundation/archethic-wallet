import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/sign_transactions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider.freezed.dart';

@freezed
class SignTransactionsConfirmationFormState
    with _$SignTransactionsConfirmationFormState {
  const factory SignTransactionsConfirmationFormState({
    required RPCCommand<RPCSignTransactionsCommandData> signTransactionCommand,
  }) = _SignTransactionsConfirmationFormState;
  const SignTransactionsConfirmationFormState._();
}

class SignTransactionsConfirmationFormNotifier
    extends AutoDisposeFamilyAsyncNotifier<
        SignTransactionsConfirmationFormState,
        RPCCommand<RPCSignTransactionsCommandData>> {
  @override
  Future<SignTransactionsConfirmationFormState> build(
    RPCCommand<RPCSignTransactionsCommandData> arg,
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
      RPCCommand<RPCSignTransactionsCommandData>>(
    SignTransactionsConfirmationFormNotifier.new,
  );
}
