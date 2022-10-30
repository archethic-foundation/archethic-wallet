/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer' as dev;

// Project imports:
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/domain/repositories/transaction.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

part 'archethic_transaction_sender.dart';
part 'phoenix_link.dart';

abstract class TransactionSenderInterface {
  const TransactionSenderInterface();

  /// Sends a transaction and listens to confirmations.
  ///
  /// Sender auto-closes in the following situations :
  ///     - when transaction is fully confirmed
  ///     - when timeout is reached
  ///     - when transaction fails
  Future<void> send({
    required Transaction transaction,
    Duration timeout = const Duration(seconds: 10),
    required TransactionConfirmationHandler onConfirmation,
    required TransactionErrorHandler onError,
  });

  /// Releases all PhoenixTransactionSender resources.
  void close();
}
