import 'dart:async';
import 'dart:developer';

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
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:deeplink_rpc/deeplink_rpc.dart';

class ArchethicDeeplinkRPCServer extends DeeplinkRpcRequestReceiver {
  ArchethicDeeplinkRPCServer() {
    registerHandler(
      DeeplinkRpcRequestHandler(
        route: const DeeplinkRpcRoute('send_transaction'),
        handle: (request) => _handle(
          rpcSendTransactionReceiverFactory,
          request,
        ),
      ),
    );
    registerHandler(
      DeeplinkRpcRequestHandler(
        route: const DeeplinkRpcRoute('get_endpoint'),
        handle: (request) => _handle(
          rpcGetEndpointCommandReceiverFactory,
          request,
        ),
      ),
    );
    registerHandler(
      DeeplinkRpcRequestHandler(
        route: const DeeplinkRpcRoute('refresh_current_account'),
        handle: (request) => _handle(
          rpcRefreshCurrentAccountCommandReceiverFactory,
          request,
        ),
      ),
    );
    registerHandler(
      DeeplinkRpcRequestHandler(
        route: const DeeplinkRpcRoute('get_current_account'),
        handle: (request) => _handle(
          rpcGetCurrentAccountCommandReceiverFactory,
          request,
        ),
      ),
    );
    registerHandler(
      DeeplinkRpcRequestHandler(
        route: const DeeplinkRpcRoute('get_accounts'),
        handle: (request) => _handle(
          rpcGetAccountsCommandReceiverFactory,
          request,
        ),
      ),
    );
    registerHandler(
      DeeplinkRpcRequestHandler(
        route: const DeeplinkRpcRoute('add_service'),
        handle: (request) => _handle(
          rpcAddServiceReceiverFactory,
          request,
        ),
      ),
    );
    registerHandler(
      DeeplinkRpcRequestHandler(
        route: const DeeplinkRpcRoute('get_services_from_keychain'),
        handle: (request) => _handle(
          rpcGetServicesFromKeychainReceiverFactory,
          request,
        ),
      ),
    );
    registerHandler(
      DeeplinkRpcRequestHandler(
        route: const DeeplinkRpcRoute('keychain_derive_keypair'),
        handle: (request) => _handle(
          rpcKeychainDeriveKeypairReceiverFactory,
          request,
        ),
      ),
    );
    registerHandler(
      DeeplinkRpcRequestHandler(
        route: const DeeplinkRpcRoute('keychain_derive_address'),
        handle: (request) => _handle(
          rpcKeychainDeriveAddressReceiverFactory,
          request,
        ),
      ),
    );
    registerHandler(
      DeeplinkRpcRequestHandler(
        route: const DeeplinkRpcRoute('sign_transactions'),
        handle: (request) => _handle(
          rpcSignTransactionReceiverFactory,
          request,
        ),
      ),
    );
    registerHandler(
      DeeplinkRpcRequestHandler(
        route: const DeeplinkRpcRoute('open_session_handshake'),
        handle: (request) => _handle(
          rpcOpenSessionHandshakeCommandReceiverFactory,
          request,
        ),
      ),
    );
    registerHandler(
      DeeplinkRpcRequestHandler(
        route: const DeeplinkRpcRoute('open_session_challenge'),
        handle: (request) => _handle(
          rpcOpenSessionChallengeCommandReceiverFactory,
          request,
        ),
      ),
    );
  }

  static const logName = 'DeeplinkRpcHandler';

  static Future<Map<String, dynamic>> _handle(
    RPCCommandReceiverFactory commandReceiverFactory,
    DeeplinkRpcRequest request,
  ) async {
    try {
      final commandReceiver =
          await commandReceiverFactory.build(request.params);
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

      throw failure.toDeeplinkRpcFailure();
    }
  }
}
