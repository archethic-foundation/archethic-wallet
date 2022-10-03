// Dart imports:
import 'dart:async';

// Package imports:
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

// Project imports:
import 'package:aewallet/util/confirmations/phoenix_link.dart';

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
    final HttpLink phoenixHttpLink = HttpLink(
      phoenixHttpLinkEndpoint,
    );

    channel =
        await PhoenixLink.createChannel(websocketUri: websocketUriEndpoint);
    final phoenixLink = PhoenixLink(
      channel: channel!,
    );

    var link = Link.split(
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

    Stream<QueryResult> subscription = client!.subscribe(
      SubscriptionOptions(document: subscriptionDocument),
    );
    subscription.listen(function);
  }

  Future<Message> onPushReply(Push push) async {
    final Completer<Message> completer = Completer<Message>();
    final Message result = await channel!.onPushReply(push.replyEvent);
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
