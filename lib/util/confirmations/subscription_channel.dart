// Dart imports:
import 'dart:async';

// Project imports:
import 'package:aewallet/util/confirmations/phoenix_link.dart';
// Package imports:
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

class SubscriptionChannel {
  PhoenixSocket? socket;
  PhoenixChannel? channel;
  GraphQLClient? client;

  final StreamController<Map> _onMessageController = StreamController<Map>();
  Stream<Map> get onMessage => _onMessageController.stream;

  Future<void> connect(
    String phoenixHttpLinkEndpoint,
    String websocketUriEndpoint,
  ) async {
    final phoenixHttpLink = HttpLink(
      phoenixHttpLinkEndpoint,
    );

    channel =
        await PhoenixLink.createChannel(websocketUri: websocketUriEndpoint);
    final phoenixLink = PhoenixLink(
      channel: channel!,
    );

    final link = Link.split(
      (request) => request.isSubscription,
      phoenixLink,
      phoenixHttpLink,
    );
    client = GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );
  }

  void addSubscriptionTransactionConfirmed(
    String address,
    Function(QueryResult) function,
  ) {
    final subscriptionDocument = gql(
      'subscription { transactionConfirmed(address: "$address") { nbConfirmations, maxConfirmations } }',
    );

    final subscription = client!.subscribe(
      SubscriptionOptions(document: subscriptionDocument),
    );
    subscription.listen(function);
  }

  Future<Message> onPushReply(Push push) async {
    final completer = Completer<Message>();
    final result = await channel!.onPushReply(push.replyEvent);
    completer.complete(result);
    return completer.future;
  }

  void close() {
    _onMessageController.close();
    if (socket != null) {
      socket!.close();
    }
  }
}
