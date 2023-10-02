part of 'rpc_receiver.dart';

abstract class RPCSubscriptionReceiverFactory<CommandDataT, NotificationDataT> {
  const RPCSubscriptionReceiverFactory._();

  factory RPCSubscriptionReceiverFactory.anonymous({
    required RPCDecodeRequest<CommandDataT> decodeRequest,
    required RPCEncodeNotification<NotificationDataT> encodeNotification,
  }) = _AnonymousRPCSubscriptionReceiverFactory;

  factory RPCSubscriptionReceiverFactory.authenticated({
    required RPCDecodeRequest<CommandDataT> decodeRequest,
    required RPCEncodeNotification<NotificationDataT> encodeNotification,
  }) = _AuthenticatedRPCSubscriptionReceiverFactory;

  FutureOr<RPCSubscriptionReceiver<CommandDataT, NotificationDataT>> build(
    Map<String, dynamic> requestData,
  );
}

class _AuthenticatedRPCSubscriptionReceiverFactory<CommandDataT,
        NotificationDataT>
    extends RPCSubscriptionReceiverFactory<CommandDataT, NotificationDataT> {
  _AuthenticatedRPCSubscriptionReceiverFactory({
    required this.encodeNotification,
    required this.decodeRequest,
  }) : super._();

  final RPCEncodeNotification<NotificationDataT> encodeNotification;
  final RPCDecodeRequest<CommandDataT> decodeRequest;

  @override
  FutureOr<RPCSubscriptionReceiver<CommandDataT, NotificationDataT>> build(
    Map<String, dynamic> requestData,
  ) async {
    final session = await sl.get<RPCSessionService>().findSession(
          awc.RPCAuthenticatedMessage.sessionIdFromJson(requestData),
        );

    if (session == null) throw awc.Failure.connectivity;
    final requestMessage = awc.RPCAuthenticatedMessage.fromJson(
      session,
      requestData,
    );

    return RPCSubscriptionReceiver._(
      request: requestMessage,
      messageCodec: RPCMessageCodec.authenticated(
        session: session,
      ),
      requestToCommand: (message) {
        final commandData = decodeRequest(message.payload);
        return session.map(
          waitingForValidation: (waitingForValidation) => RPCCommand.anonymous(
            data: commandData,
          ),
          validated: (validated) => RPCCommand.authenticated(
            origin: validated.origin,
            data: commandData,
          ),
        );
      },
      encodeResult: (subscription) => awc.SubscribeResponse(
        subscriptionId: subscription.id,
      ).toJson(),
      encodeNotification: encodeNotification,
    );
  }
}

class _AnonymousRPCSubscriptionReceiverFactory<CommandDataT, NotificationDataT>
    extends RPCSubscriptionReceiverFactory<CommandDataT, NotificationDataT> {
  _AnonymousRPCSubscriptionReceiverFactory({
    required this.encodeNotification,
    required this.decodeRequest,
  }) : super._();

  final RPCEncodeNotification<NotificationDataT> encodeNotification;

  final RPCDecodeRequest<CommandDataT> decodeRequest;

  @override
  FutureOr<RPCSubscriptionReceiver<CommandDataT, NotificationDataT>> build(
    Map<String, dynamic> requestData,
  ) async {
    final messageFactory = RPCMessageCodec.anonymous();
    return RPCSubscriptionReceiver._(
      messageCodec: messageFactory,
      request: messageFactory.fromJson(requestData),
      requestToCommand: (message) => RPCCommand.anonymous(
        data: decodeRequest(message.payload),
      ),
      encodeResult: (subscription) => awc.SubscribeResponse(
        subscriptionId: subscription.id,
      ).toJson(),
      encodeNotification: encodeNotification,
    );
  }
}

/// Handles subscription commands.
class RPCSubscriptionReceiver<CommandDataT, NotificationDataT>
    extends RPCCommandReceiver<CommandDataT,
        awc.Subscription<NotificationDataT>> {
  RPCSubscriptionReceiver._({
    required super.requestToCommand,
    required super.messageCodec,
    required super.encodeResult,
    required super.request,
    required this.encodeNotification,
  }) : super._();

  late final Map<String, dynamic> Function(NotificationDataT notification)
      encodeNotification;
}
