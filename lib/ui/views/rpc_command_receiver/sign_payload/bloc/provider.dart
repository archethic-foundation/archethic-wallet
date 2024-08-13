import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider.freezed.dart';

@freezed
class SignPayloadsConfirmationFormState
    with _$SignPayloadsConfirmationFormState {
  const factory SignPayloadsConfirmationFormState({
    required RPCCommand<SignPayloadRequest> signTransactionCommand,
  }) = _SignPayloadsConfirmationFormState;
  const SignPayloadsConfirmationFormState._();
}

class SignPayloadsConfirmationFormNotifiers
    extends AutoDisposeFamilyAsyncNotifier<SignPayloadsConfirmationFormState,
        RPCCommand<SignPayloadRequest>> {
  @override
  Future<SignPayloadsConfirmationFormState> build(
    RPCCommand<SignPayloadRequest> arg,
  ) async {
    return SignPayloadsConfirmationFormState(
      signTransactionCommand: arg,
    );
  }
}

class SignPayloadsConfirmationProviders {
  static final form = AsyncNotifierProvider.autoDispose.family<
      SignPayloadsConfirmationFormNotifiers,
      SignPayloadsConfirmationFormState,
      RPCCommand<SignPayloadRequest>>(
    SignPayloadsConfirmationFormNotifiers.new,
  );
}
