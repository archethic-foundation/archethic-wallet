import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/infrastructure/rpc/add_service/command_handler.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_receiver.dart';
import 'package:aewallet/infrastructure/rpc/get_accounts/command_receiver.dart';
import 'package:aewallet/infrastructure/rpc/get_current_account/command_receiver.dart';
import 'package:aewallet/infrastructure/rpc/get_endpoint/command_receiver.dart';
import 'package:aewallet/infrastructure/rpc/get_services_from_keychain/command_receiver.dart';
import 'package:aewallet/infrastructure/rpc/keychain_derive_address/command_receiver.dart';
import 'package:aewallet/infrastructure/rpc/keychain_derive_keypair/command_receiver.dart';
import 'package:aewallet/infrastructure/rpc/open_session_challenge/command_receiver.dart';
import 'package:aewallet/infrastructure/rpc/open_session_handshake/command_receiver.dart';
import 'package:aewallet/infrastructure/rpc/refresh_current_account/command_receiver.dart';
import 'package:aewallet/infrastructure/rpc/send_transaction/command_receiver.dart';
import 'package:aewallet/infrastructure/rpc/sign_transactions/command_receiver.dart';
import 'package:aewallet/infrastructure/rpc/sub_account/command_receiver.dart';
import 'package:aewallet/infrastructure/rpc/sub_current_account/command_receiver.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/foundation.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:web_socket_channel/io.dart';

/// A [Peer] composition which handles subscription requests
class _SubscribablePeer {
  _SubscribablePeer(this._peer);

  final Peer _peer;

  final Map<String, StreamSubscription> _subscriptions = {};

  Future<void> close() => _peer.close();

  void registerMethod(String name, Function callback) =>
      _peer.registerMethod(name, callback);

  void registerSubscriptionMethod<CommandDataT, NotificationDataT>(
    String name,
    Future<
            (
              RPCSubscriptionReceiver<CommandDataT, NotificationDataT>,
              awc.Subscription<Map<String, dynamic>>
            )>
        Function(
      dynamic params,
    ) subscriptionCallback,
  ) {
    registerMethod(
      name,
      (params) async {
        final (subscriptionReceiver, subscription) =
            await subscriptionCallback(params);

        final streamSubscription = subscription.updates.listen((value) {
          _peer.sendNotification('addSubscriptionNotification', value);
        });
        _registerSubscription(subscription.id, streamSubscription);

        final resultPayload = subscriptionReceiver.encodeResult(subscription);
        return subscriptionReceiver.messageCodec.build(resultPayload).toJson();
      },
    );
  }

  void registerUnsubscriptionMethod(
    String name,
    RPCUnsubscriptionReceiverFactory receiverFactory,
  ) {
    registerMethod(
      name,
      (Parameters params) async {
        final commandReceiver = await receiverFactory.build(params.value);

        final message = commandReceiver.messageCodec.fromJson(params.value);
        final unsubscribeCommand =
            commandReceiver.requestToCommand(message).data;

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
  ArchethicWebsocketRPCServer();

  static const logName = 'RPC Server';
  static const host = '127.0.0.1';
  static const port = 12345;

  static bool get isPlatformCompatible {
    return !kIsWeb &&
        (Platform.isLinux || Platform.isMacOS || Platform.isWindows);
  }

  HttpServer? _runningHttpServer;
  final Set<_SubscribablePeer> _openedSockets = {};

  bool get isRunning => _openedSockets.isNotEmpty || _runningHttpServer != null;

  Future<void> run() async {
    runZonedGuarded(
      () async {
        if (isRunning) {
          log('Already running. Cancel `start`', name: logName);
          return;
        }

        log('Starting at ws://$host:$port', name: logName);
        final httpServer = await HttpServer.bind(
          host,
          port,
          shared: true,
        );

        httpServer.listen((HttpRequest request) async {
          log('Received request', name: logName);

          final socket = await WebSocketTransformer.upgrade(request);
          final channel = IOWebSocketChannel(socket);

          final peerServer = _SubscribablePeer(Peer(channel.cast<String>()))
            ..registerMethod(
              'sendTransaction',
              (params) => _handle(rpcSendTransactionReceiverFactory, params),
            )
            ..registerMethod(
              'getEndpoint',
              (params) => _handle(rpcGetEndpointCommandReceiverFactory, params),
            )
            ..registerMethod(
              'refreshCurrentAccount',
              (params) => _handle(
                rpcRefreshCurrentAccountCommandReceiverFactory,
                params,
              ),
            )
            ..registerMethod(
              'getCurrentAccount',
              (params) =>
                  _handle(rpcGetCurrentAccountCommandReceiverFactory, params),
            )
            ..registerMethod(
              'getAccounts',
              (params) => _handle(rpcGetAccountsCommandReceiverFactory, params),
            )
            ..registerSubscriptionMethod(
              'subscribeAccount',
              (params) => _handleSubscription(
                rpcSubscribeAccountCommandReceiver,
                params,
              ),
            )
            ..registerUnsubscriptionMethod(
              'unsubscribeAccount',
              RPCUnsubscriptionReceiverFactory.authenticated(),
            )
            ..registerSubscriptionMethod<awc.SubscribeCurrentAccountRequest,
                awc.SubscribeAccountNotification?>(
              'subscribeCurrentAccount',
              (params) => _handleSubscription<
                  awc.SubscribeCurrentAccountRequest,
                  awc.SubscribeAccountNotification?>(
                rpcSubscribeCurrentAccountCommandReceiver,
                params,
              ),
            )
            ..registerUnsubscriptionMethod(
              'unsubscribeCurrentAccount',
              RPCUnsubscriptionReceiverFactory.authenticated(),
            )
            ..registerMethod(
              'addService',
              (params) => _handle(rpcAddServiceReceiverFactory, params),
            )
            ..registerMethod(
              'getServicesFromKeychain',
              (params) =>
                  _handle(rpcGetServicesFromKeychainReceiverFactory, params),
            )
            ..registerMethod(
              'keychainDeriveKeypair',
              (params) =>
                  _handle(rpcKeychainDeriveKeypairReceiverFactory, params),
            )
            ..registerMethod(
              'keychainDeriveAddress',
              (params) =>
                  _handle(rpcKeychainDeriveAddressReceiverFactory, params),
            )
            ..registerMethod(
              'signTransactions',
              (params) => _handle(rpcSignTransactionReceiverFactory, params),
            )
            ..registerMethod(
              'openSessionHandshake',
              (params) async {
                final result = await _handle(
                  rpcOpenSessionHandshakeCommandReceiverFactory,
                  params,
                );
                return result;
              },
            )
            ..registerMethod(
              'openSessionChallenge',
              (params) => _handle(
                rpcOpenSessionChallengeCommandReceiverFactory,
                params,
              ),
            );

          _openedSockets.add(peerServer);
          await peerServer.listen();
        });
        _runningHttpServer = httpServer;
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

  Future<void> stop() async {
    runZonedGuarded(
      () async {
        if (!isRunning) {
          log('Already stopped. Cancel `stop`', name: logName);
          return;
        }

        log('Closing all websocket connections', name: logName);
        for (final socket in _openedSockets) {
          await socket.close();
        }
        _openedSockets.clear();

        log('Stopping at ws://$host:$port', name: logName);
        await _runningHttpServer?.close();
        _runningHttpServer = null;
        log('Server stopped at ws://$host:$port', name: logName);
      },
      (error, stack) {
        log(
          'WebSocket server failed to stop',
          error: error,
          stackTrace: stack,
          name: logName,
        );
      },
    );
  }

  Future<Map<String, dynamic>> _handle(
    RPCCommandReceiverFactory commandReceiverFactory,
    Parameters params,
  ) async {
    try {
      final commandReceiver = await commandReceiverFactory.build(params.value);
      final success = await commandReceiver.handle().valueOrThrow;

      // 4. Transformation du R en Json, puis creation du RPCMessage
      final resultPayload = commandReceiver.encodeResult(success);
      return commandReceiver.messageCodec.build(resultPayload).toJson();
    } catch (failure) {
      failure as awc.Failure;
      log(
        'Command failed',
        name: logName,
        error: failure,
      );

      throw RpcException(
        failure.code,
        failure.message,
      );
    }
  }

  Future<
      (
        RPCSubscriptionReceiver<CommandDataT,
            NotificationDataT> subscriptionReceiver,
        awc.Subscription<Map<String, dynamic>> subscription
      )> _handleSubscription<CommandDataT, NotificationDataT>(
    RPCSubscriptionReceiverFactory<CommandDataT, NotificationDataT>
        commandReceiverFactory,
    Parameters params,
  ) async {
    try {
      final commandReceiver = await commandReceiverFactory.build(params.value);
      final success = await commandReceiver.handle().valueOrThrow;

      return (
        commandReceiver,
        awc.Subscription(
          id: success.id,
          updates: success.updates
              .map(
                (update) => commandReceiver.messageCodec
                    .build(
                      awc.SubscriptionUpdate(
                        subscriptionId: success.id,
                        data: commandReceiver.encodeNotification(update),
                      ).toJson(),
                    )
                    .toJson(),
              )
              .distinct(),
        ),
      );
    } catch (failure) {
      failure as awc.Failure;
      log(
        'Command failed',
        name: logName,
        error: failure,
      );

      throw RpcException(
        failure.code,
        failure.message,
      );
    }
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
