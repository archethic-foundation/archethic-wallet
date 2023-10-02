part of 'rpc_receiver.dart';

abstract class RPCUnsubscriptionReceiverFactory {
  const RPCUnsubscriptionReceiverFactory._();

  factory RPCUnsubscriptionReceiverFactory.anonymous() =
      _AnonymousRPCUnsubscriptionReceiverFactory;

  factory RPCUnsubscriptionReceiverFactory.authenticated() =
      _AuthenticatedRPCUnsubscriptionReceiverFactory;

  FutureOr<RPCUnsubscriptionReceiver> build(
    Map<String, dynamic> requestData,
  );
}

class _AuthenticatedRPCUnsubscriptionReceiverFactory
    extends RPCUnsubscriptionReceiverFactory {
  _AuthenticatedRPCUnsubscriptionReceiverFactory() : super._();

  @override
  FutureOr<RPCUnsubscriptionReceiver> build(
    Map<String, dynamic> requestData,
  ) async {
    final session = await sl.get<RPCSessionService>().findSession(
          awc.RPCAuthenticatedMessage.sessionIdFromJson(requestData),
        );

    if (session == null) throw awc.Failure.connectivity;

    final messageCodec = RPCMessageCodec.authenticated(
      session: session,
    );
    return RPCUnsubscriptionReceiver._(
      messageCodec: messageCodec,
      request: messageCodec.build(requestData),
      requestToCommand: (message) => session.map(
        validated: (validatedSession) => RPCCommand.authenticated(
          data: awc.UnsubscribeRequest.fromJson(message.payload),
          origin: validatedSession.origin,
        ),
        waitingForValidation: (waitingForValidationSession) =>
            RPCCommand.anonymous(
          data: awc.UnsubscribeRequest.fromJson(message.payload),
        ),
      ),
    );
  }
}

class _AnonymousRPCUnsubscriptionReceiverFactory
    extends RPCUnsubscriptionReceiverFactory {
  _AnonymousRPCUnsubscriptionReceiverFactory() : super._();

  @override
  FutureOr<RPCUnsubscriptionReceiver> build(
    Map<String, dynamic> requestData,
  ) async {
    final messageFactory = RPCMessageCodec.anonymous();

    return RPCUnsubscriptionReceiver._(
      messageCodec: messageFactory,
      requestToCommand: (rpcMessage) => RPCCommand.anonymous(
        data: awc.UnsubscribeRequest.fromJson(rpcMessage.payload),
      ),
      request: messageFactory.fromJson(requestData),
    );
  }
}

class RPCUnsubscriptionReceiver
    extends RPCCommandReceiver<awc.UnsubscribeRequest, void> {
  RPCUnsubscriptionReceiver._({
    required super.messageCodec,
    required super.request,
    required super.requestToCommand,
  }) : super._(
          encodeResult: (_) => {},
        );
}
