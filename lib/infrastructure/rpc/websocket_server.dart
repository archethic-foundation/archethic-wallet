import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/subscription.dart';
import 'package:aewallet/infrastructure/rpc/add_service/command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_request.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_subscription.dart';
import 'package:aewallet/infrastructure/rpc/get_accounts/command_handler.dart';
import 'package:aewallet/infrastructure/rpc/get_endpoint/command_handler.dart';
import 'package:aewallet/infrastructure/rpc/get_services_from_keychain/command_handler.dart';
import 'package:aewallet/infrastructure/rpc/keychain_derive_address/command_handler.dart';
import 'package:aewallet/infrastructure/rpc/keychain_derive_keypair/command_handler.dart';
import 'package:aewallet/infrastructure/rpc/send_transaction/command_handler.dart';
import 'package:aewallet/infrastructure/rpc/sub_account/command_handler.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:web_socket_channel/io.dart';

/// A [Peer] composition which handles subscription requests
class _SubscribablePeer {
  _SubscribablePeer(this._peer);

  final Peer _peer;

  final Map<String, StreamSubscription> _subscriptions = {};

  void registerMethod(String name, Function callback) =>
      _peer.registerMethod(name, callback);

  void registerSubscriptionMethod(
    String name,
    Future<RPCSubscriptionDTO> Function(dynamic params) subscriptionCallback,
  ) {
    registerMethod(
      name,
      (params) async {
        final result = await subscriptionCallback(params);

        final streamSubscription = result.updates.listen((value) {
          _peer.sendNotification('${name}Value', value);
        });
        _registerSubscription(result.id, streamSubscription);

        return result.toJson();
      },
    );
  }

  void registerUnsubscriptionMethod(
    String name,
  ) {
    registerMethod(
      name,
      (params) async {
        final requestDTO = RPCRequestDTO.fromJson(
          params.value,
        );

        final unsubscribeCommand = RPCUnsubscribeCommandDTO.fromJson(
          requestDTO.payload,
        );
        _removeSubscription(unsubscribeCommand.subscriptionId);
        return {};
      },
    );
  }

  void registerFallback(Function(Parameters parameters) callback) =>
      _peer.registerFallback(callback);

  void _removeSubscription(String subscriptionId) {
    _subscriptions.remove(subscriptionId);
  }

  void _registerSubscription(String subscriptionId, StreamSubscription sub) {
    _subscriptions[subscriptionId] = sub;
  }

  void _cleanupSubscriptions() {
    for (final subscription in _subscriptions.entries) {
      subscription.value.cancel();
    }
    _subscriptions.clear();
  }

  Future listen() async {
    await _peer.listen();
    _cleanupSubscriptions();
  }
}

class ArchethicWebsocketRPCServer {
  ArchethicWebsocketRPCServer({
    required this.commandDispatcher,
  });

  static const logName = 'RPC Server';
  static const host = '127.0.0.1';
  static const port = 12345;

  final CommandDispatcher commandDispatcher;

  static bool get isPlatformCompatible {
    return Platform.isLinux || Platform.isMacOS || Platform.isWindows;
  }

  Future<void> run() async {
    runZonedGuarded(
      () async {
        log('Starting at ws://$host:$port', name: logName);
        final server = await HttpServer.bind(
          host,
          port,
          shared: true,
        );

        server.listen((HttpRequest request) async {
          log('Received request', name: logName);

          final socket = await WebSocketTransformer.upgrade(request);
          final channel = IOWebSocketChannel(socket);

          final server = _SubscribablePeer(Peer(channel.cast<String>()))
            ..registerMethod(
              'sendTransaction',
              (params) => _handle(RPCSendTransactionCommandHandler(), params),
            )
            ..registerMethod(
              'getEndpoint',
              (params) => _handle(RPCGetEndpointCommandHandler(), params),
            )
            ..registerMethod(
              'getAccounts',
              (params) => _handle(RPCGetAccountsCommandHandler(), params),
            )
            ..registerSubscriptionMethod(
              'subscribeAccount',
              (params) => _handleSubscription(
                RPCSubscribeAccountCommandHandler(),
                params,
              ),
            )
            ..registerUnsubscriptionMethod(
              'unsubscribeAccount',
            )
            ..registerMethod(
              'addService',
              (params) => _handle(RPCAddServiceCommandHandler(), params),
            )
            ..registerMethod(
              'getServicesFromKeychain',
              (params) =>
                  _handle(RPCGetServicesFromKeychainCommandHandler(), params),
            )
            ..registerMethod(
              'keychainDeriveKeypair',
              (params) =>
                  _handle(RPCKeychainDeriveKeypairCommandHandler(), params),
            )
            ..registerMethod(
              'keychainDeriveAddress',
              (params) =>
                  _handle(RPCKeychainDeriveAddressCommandHandler(), params),
            );

          await server.listen();
        });
      },
      (error, stack) {
        log(
          'WebSocket server failed',
          error: error,
          stackTrace: stack,
          name: logName,
        );
      },
    );
  }

  Future<Map<String, dynamic>> _handle(
    RPCCommandHandler commandHandler,
    Parameters params,
  ) async {
    final result = await commandHandler.handle(params.value);
    return result.map(
      success: commandHandler.resultFromModel,
      failure: (failure) {
        log(
          'Command failed',
          name: logName,
          error: failure,
        );

        throw RpcException(
          failure.code,
          failure.message ?? 'Command failed',
        );
      },
    );
  }

  Future<RPCSubscriptionDTO> _handleSubscription(
    RPCSubscriptionHandler commandHandler,
    Parameters params,
  ) async {
    final result = await commandHandler.handle(params.value);
    return result.map(
      success: (success) {
        success as RPCSubscription;
        return RPCSubscriptionDTO(
          id: success.id,
          updates: success.updates.map(
            (update) => RPCSubscriptionUpdateDTO(
              subscriptionId: success.id,
              data: commandHandler.notificationFromModel(update),
            ).toJson(),
          ),
        );
      },
      failure: (failure) {
        log(
          'Command failed',
          name: logName,
          error: failure,
        );

        throw RpcException(
          failure.code,
          failure.message ?? 'Command failed',
        );
      },
    );
  }
}

abstract class ExceptionUtil {
  static R guard<R>(
    R Function() call,
    Exception Function(Object) onError,
  ) {
    try {
      return call();
    } catch (e) {
      throw onError(e);
    }
  }
}
