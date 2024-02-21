import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/session_service.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

part 'rpc_receiver.command.dart';
part 'rpc_receiver.subscription.dart';
part 'rpc_receiver.unsubscription.dart';

typedef RPCMessageToCommand<CommandDataT> = RPCCommand<CommandDataT> Function(
  awc.RPCMessage dto,
);

typedef RPCDecodeRequest<CommandDataT> = CommandDataT Function(
  Map<String, dynamic>,
);
typedef RPCEncodeResult<SuccessDataT> = Map<String, dynamic> Function(
  SuccessDataT model,
);
typedef RPCEncodeNotification<NotificationDataT> = Map<String, dynamic>
    Function(
  NotificationDataT notification,
);

abstract class RPCMessageCodec {
  factory RPCMessageCodec.anonymous() = _ClearMessageCodec;
  factory RPCMessageCodec.authenticated({required awc.Session session}) =
      _EncryptedMessageCodec;

  /// Creates a new [awc.RPCMessage] with a given payload.
  awc.RPCMessage build(Map<String, dynamic> payload);

  /// Creates an [awc.RPCMessage] from a Json encoded data.
  awc.RPCMessage fromJson(Map<String, dynamic> jsonRpcMessage);
}

class _ClearMessageCodec implements RPCMessageCodec {
  @override
  awc.RPCMessage fromJson(Map<String, dynamic> jsonRpcMessage) =>
      awc.RPCAnonymousMessage.fromJson(
        jsonRpcMessage,
      );

  @override
  awc.RPCMessage build(Map<String, dynamic> payload) =>
      awc.RPCMessage.anonymous(
        payload: payload,
      );
}

class _EncryptedMessageCodec implements RPCMessageCodec {
  _EncryptedMessageCodec({required this.session});

  final awc.Session session;

  @override
  awc.RPCMessage fromJson(Map<String, dynamic> jsonRpcMessage) =>
      awc.RPCAuthenticatedMessage.fromJson(
        session,
        jsonRpcMessage,
      );

  @override
  awc.RPCMessage build(Map<String, dynamic> payload) =>
      awc.RPCMessage.authenticated(
        session: session,
        payload: payload,
      );
}
