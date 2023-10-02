part of 'rpc_receiver.dart';

abstract class RPCCommandReceiverFactory<C, R> {
  const RPCCommandReceiverFactory._();

  factory RPCCommandReceiverFactory.anonymous({
    required RPCDecodeRequest<C> decodeRequest,
    required RPCEncodeResult encodeResult,
  }) = _AnonymousRPCCommandReceiverFactory;

  factory RPCCommandReceiverFactory.authenticated({
    required RPCDecodeRequest<C> decodeRequest,
    required RPCEncodeResult encodeResult,
  }) = _AuthenticatedRPCCommandReceiverFactory;

  Future<RPCCommandReceiver<C, R>> build(Map<String, dynamic> requestData);
}

class _AnonymousRPCCommandReceiverFactory<C, R>
    extends RPCCommandReceiverFactory<C, R> {
  _AnonymousRPCCommandReceiverFactory({
    required this.decodeRequest,
    required this.encodeResult,
  }) : super._();

  final RPCDecodeRequest<C> decodeRequest;
  final RPCEncodeResult encodeResult;

  @override
  Future<RPCCommandReceiver<C, R>> build(
    Map<String, dynamic> requestData,
  ) async {
    final messageCodec = RPCMessageCodec.anonymous();
    return RPCCommandReceiver._(
      messageCodec: messageCodec,
      requestToCommand: (message) => RPCCommand.anonymous(
        data: decodeRequest(message.payload),
      ),
      request: messageCodec.fromJson(requestData),
      encodeResult: encodeResult,
    );
  }
}

class _AuthenticatedRPCCommandReceiverFactory<C, R>
    extends RPCCommandReceiverFactory<C, R> {
  _AuthenticatedRPCCommandReceiverFactory({
    required this.decodeRequest,
    required this.encodeResult,
  }) : super._();

  final RPCDecodeRequest<C> decodeRequest;
  final RPCEncodeResult encodeResult;

  @override
  Future<RPCCommandReceiver<C, R>> build(
    Map<String, dynamic> requestData,
  ) async {
    final session = await sl.get<RPCSessionService>().findSession(
          awc.RPCAuthenticatedMessage.sessionIdFromJson(requestData),
        );

    if (session == null) throw awc.Failure.invalidSession;

    return RPCCommandReceiver._(
      request: awc.RPCAuthenticatedMessage.fromJson(
        session,
        requestData,
      ),
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
      encodeResult: encodeResult,
    );
  }
}

/// [RPCCommandReceiver] is responsible for converting
/// data between RPC channel (deeplink, websocket ...) DTOs
/// and the application domain models.
class RPCCommandReceiver<CommandDataT, SuccessDataT> {
  const RPCCommandReceiver._({
    required this.messageCodec,
    required this.requestToCommand,
    required this.request,
    required this.encodeResult,
  });

  /// Creates new RPCMessages and decodes Json serialized RPCMessages
  final RPCMessageCodec messageCodec;

  /// Transforms received request into a command model.
  final RPCMessageToCommand<CommandDataT> requestToCommand;

  final RPCEncodeResult encodeResult;

  final awc.RPCMessage request;
  // final RPCDecodeMessage decodeMessage;

  Future<Result<SuccessDataT, awc.Failure>> handle() async {
    final logName = 'RPCCommandReceiver [$CommandDataT]';
    log(
      'Received command ${jsonEncode(request.toJson())}',
      name: logName,
    );

    try {
      // 1. Json => RPCMessage (fait en amont)

      // 2. RPCMessage => RPCCommand
      final commandModel = requestToCommand(
        request,
      );

      // 3. Traitement, recupere un objet Result<[R], RPCFailure>
      final result = await sl
          .get<CommandBus>()
          .add<RPCCommand<CommandDataT>, SuccessDataT>(
            commandModel,
          );

      // 4. Transformation du R en Json, puis creation du RPCMessage en aval
      return result;
      // ignore: avoid_catching_errors
    } on TypeError catch (e, stack) {
      log(
        'Invalid data',
        name: logName,
        error: e,
        stackTrace: stack,
      );
      return const Result.failure(awc.Failure.invalidParams);
    }
  }
}
