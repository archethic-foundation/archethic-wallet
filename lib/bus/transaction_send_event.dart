/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:event_taxi/event_taxi.dart';

enum TransactionSendEventType { transfer, token, keychain, keychainAccess }

class TransactionSendEvent implements Event {
  TransactionSendEvent(
      {required this.transactionType,
      this.nbConfirmations,
      this.maxConfirmations,
      this.response,
      this.params,
      this.transactionAddress});

  final TransactionSendEventType? transactionType;
  final int? nbConfirmations;
  final int? maxConfirmations;
  final String? response;
  final Map<String, Object>? params;
  final String? transactionAddress;
}
