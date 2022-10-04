// Dart imports:
import 'dart:async';
import 'dart:developer';

// Project imports:
import 'package:aewallet/util/confirmations/subscription_channel.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
// Package imports:
import 'package:gql/language.dart' as lang;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http show post;

/// SPDX-License-Identifier: AGPL-3.0-or-later

class TransactionSender {
  TransactionSender({
    this.endpoint,
    this.onSent,
    this.onConfirmation,
    this.onFullConfirmation,
    this.onRequiredConfirmation,
    this.onError,
    this.onTimeout,
    this.confirmationNotifier,
    this.errorNotifier,
    this.absintheSocket,
    this.timeout,
    this.nbConfirmationReceived = 0,
  });

  TransactionSender.init({
    this.endpoint,
    this.onSent,
    this.onConfirmation,
    this.onFullConfirmation,
    this.onRequiredConfirmation,
    this.onError,
    this.onTimeout,
    this.confirmationNotifier,
    this.errorNotifier,
    this.absintheSocket,
    this.timeout,
    this.nbConfirmationReceived = 0,
  }) {
    onSent = List<Function>.empty(growable: true);
    onConfirmation = List<Function>.empty(growable: true);
    onFullConfirmation = List<Function>.empty(growable: true);
    onRequiredConfirmation = List<Function>.empty(growable: true);
    onError = List<Function>.empty(growable: true);
    onTimeout = List<Function>.empty(growable: true);
  }

  final senderContext = 'SENDER';

  /// [endpoint] is the HTTP URL to a Archethic node (acting as welcome node)
  String? endpoint;

  List<Function>? onSent = List<Function>.empty(growable: true);
  List<Function>? onConfirmation = List<Function>.empty(growable: true);
  List<Function>? onFullConfirmation = List<Function>.empty(growable: true);
  List<Function>? onRequiredConfirmation = List<Function>.empty(growable: true);
  List<Function>? onError = List<Function>.empty(growable: true);
  List<Function>? onTimeout = List<Function>.empty(growable: true);
  Stream<Response>? confirmationNotifier;
  Stream<Response>? errorNotifier;
  SubscriptionChannel? absintheSocket;
  int? timeout;
  int nbConfirmationReceived;

  // TODO(reddwarf03): Change String with Enum
  /// Add listener on specific event
  /// @param {String} event Event to subscribe
  /// @param {Function} func Function to call when event triggered
  void on(String event, Function func) {
    switch (event) {
      case 'sent':
        onSent!.add(func as Function());
        break;

      case 'confirmation':
        onConfirmation!.add(func as Function(int, int));
        break;

      case 'requiredConfirmation':
        onRequiredConfirmation!.add(func as Function(int));
        break;

      case 'fullConfirmation':
        onFullConfirmation!.add(func as Function(int));
        break;

      case 'error':
        onError!.add(func as Function(String, String));
        break;

      case 'timeout':
        onTimeout!.add(func as Function(int));
        break;

      default:
        throw 'Event $event is not supported';
    }
  }

  /// Send a transaction to the network
  /// @param {Object} tx Transaction to send
  Future<TransactionStatus> sendTx(
    Transaction transaction,
    String phoenixHttpLink,
    String websocketUri, {
    int confirmationThreshold = 100,
    int sendTxTimeout = 60,
  }) async {
    if (confirmationThreshold < 0 && confirmationThreshold > 100) {
      throw 'confirmationThreshold must be an integer between 0 and 100';
    }

    if (sendTxTimeout <= 0) {
      throw 'sendTxTimeout must be an integer greater than 0';
    }
    final subscriptionChannel = SubscriptionChannel();
    await subscriptionChannel.connect(phoenixHttpLink, websocketUri);

    absintheSocket = subscriptionChannel;

    try {
      confirmationNotifier = waitConfirmations(
        transaction.address!,
        absintheSocket!,
        (nbConf, maxConf) =>
            handleConfirmation(confirmationThreshold, nbConf, maxConf),
      );
      errorNotifier = waitError(
        transaction.address!,
        absintheSocket!,
        handleError,
      );
    } catch (err) {
      for (final function in onError!) {
        function(senderContext, err.toString());
      }
    }

    final completer = Completer<TransactionStatus>();
    final requestHeaders = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var transactionStatus = TransactionStatus();
    log('sendTx: requestHttp.body=${transaction.convertToJSON()}');
    try {
      final responseHttp = await http.post(
        Uri.parse('${endpoint!}/api/transaction'),
        body: transaction.convertToJSON(),
        headers: requestHeaders,
      );
      log('sendTx: responseHttp.body=${responseHttp.body}');
      transactionStatus = transactionStatusFromJson(responseHttp.body);

      completer.complete(transactionStatus);
    } catch (e) {
      log(e.toString());
    }

    return completer.future;
  }

  // TODO(Chralu): implement
  Stream<Response>? waitConfirmations(
    String address,
    SubscriptionChannel absintheSocket,
    Function function,
  ) {
    return null;
    // ast.DocumentNode documentNode = lang.parseString(
    //   'subscription { transactionConfirmed(address: "$address") { nbConfirmations, maxConfirmations } }',
    // );
    // Operation? operation = Operation(operationName: null, document: documentNode);
    // Request request = Request(operation: operation, variables: const {});
    // return absintheSocket.phoenixLink!.request(request);
  }

  Stream<Response> waitError(
    String address,
    SubscriptionChannel absintheSocket,
    Function function,
  ) {
    final documentNode = lang.parseString(
      'subscription { transactionError(address: "$address") { context, reason } }',
    );
    final operation = Operation(document: documentNode);
    final request = Request(operation: operation);
    return absintheSocket.client!.link.request(request);
  }

  void handleConfirmation(
    int confirmationThreshold,
    int nbConfirmations,
    int maxConfirmations,
  ) {
    /// Update nb confirmation received for timeout
    nbConfirmationReceived = nbConfirmations;
/*
  // Unsubscribe to error on first confirmation
  if (nbConfirmations == 1) withAbsintheSocket.cancel(absintheSocket, errorNotifier);

  onConfirmation!.forEach(func => func(nbConfirmations, maxConfirmations));

  if ((maxConfirmations * (confirmationThreshold / 100)) <= nbConfirmations
    && onRequiredConfirmation!.length > 0) {
    onRequiredConfirmation!.forEach(func => func(nbConfirmations))
    onRequiredConfirmation = []
    clearTimeout(this.timeout);
  }

  if (nbConfirmations == maxConfirmations) {
    clearTimeout(this.timeout);

    withAbsintheSocket.cancel(this.absintheSocket, this.confirmationNotifier)

    this.onFullConfirmation.forEach(func => func(maxConfirmations))
  }*/
  }

  void handleError(String context, String reason) {
    /* clearTimeout(timeout);

  // Unsubscribe to all subscriptions
  withAbsintheSocket.cancel(absintheSocket, confirmationNotifier);
  withAbsintheSocket.cancel(absintheSocket, errorNotifier);
*/
    for (final func in onError!) {
      func(context, reason);
    }
  }

  void unsubscribe(String? event) {
    if (event != null) {
      switch (event) {
        case 'sent':
          onSent = List<Function>.empty(growable: true);
          break;

        case 'confirmation':
          onConfirmation = List<Function>.empty(growable: true);
          // absintheSocket!.client;
          // withAbsintheSocket.cancel(
          //     this.absintheSocket, this.confirmationNotifier);
          break;

        case 'requiredConfirmation':
          onRequiredConfirmation = List<Function>.empty(growable: true);
          // withAbsintheSocket.cancel(
          //     this.absintheSocket, this.confirmationNotifier);
          break;

        case 'fullConfirmation':
          onFullConfirmation = List<Function>.empty(growable: true);
          // withAbsintheSocket.cancel(
          //     this.absintheSocket, this.confirmationNotifier);
          break;

        case 'error':
          onError = List<Function>.empty(growable: true);
          // withAbsintheSocket.cancel(this.absintheSocket, this.errorNotifier);
          break;

        case 'timeout':
          onTimeout = List<Function>.empty(growable: true);
          break;

        default:
          throw 'Event $event is not supported';
      }
    } else {
      // absintthe.cancel
      onConfirmation = List<Function>.empty(growable: true);
      onFullConfirmation = List<Function>.empty(growable: true);
      onRequiredConfirmation = List<Function>.empty(growable: true);
      onError = List<Function>.empty(growable: true);
      onTimeout = List<Function>.empty(growable: true);
      onSent = List<Function>.empty(growable: true);
    }
  }
}
