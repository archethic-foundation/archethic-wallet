import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:aewallet/rpc/dto/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

part 'server.freezed.dart';
part 'server.g.dart';
part 'sign_transaction_handler.dart';

class ArchethicRPCServer {
  static const LOG_NAME = 'RPC Server';
  static const HOST = 'localhost';
  static const PORT = 12345;

  static bool get isPlatformCompatible {
    return Platform.isLinux || Platform.isMacOS || Platform.isWindows;
  }

  Future<void> run() async {
    log('Starting at http://$HOST:$PORT', name: LOG_NAME);
    await shelf_io.serve(
      _router,
      HOST,
      PORT,
    );
  }

  final _router = shelf_router.Router()
    ..post(
      '/send_transaction',
      _sendTransactionHandler,
    );
}
