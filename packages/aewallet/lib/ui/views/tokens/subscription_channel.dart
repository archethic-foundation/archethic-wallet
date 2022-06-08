// Dart imports:
import 'dart:async';

// Package imports:
import 'package:gql_link/gql_link.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

// Project imports:
import 'package:aewallet/ui/views/tokens/phoenix_link.dart';

class SubscriptionChannel {
  PhoenixSocket? socket;
  PhoenixChannel? channel;
  GraphQLClient? client;

  final StreamController<Map> _onMessageController = StreamController<Map>();
  Stream<Map> get onMessage => _onMessageController.stream;

  Future<void> connect() async {
    final HttpLink phoenixHttpLink = HttpLink(
      'http://localhost:4000/socket/websocket',
    );

    final phoenixChannel = await PhoenixLink.createChannel(
        websocketUri: 'ws://localhost:4000/socket/websocket');
    final phoenixLink = PhoenixLink(
      channel: phoenixChannel,
    );

    var link = Link.split(
        (request) => request.isSubscription, phoenixLink, phoenixHttpLink);
    client = GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );
  }

  Push addSubscriptionTransactionConfirmed(String address) {
    return channel!.push('doc', {
      "query":
          'subscription { transactionConfirmed(address: "$address") { nbConfirmations } }'
    });
  }

  Future<Message> onPushReply(Push push) async {
    final Completer<Message> completer = Completer<Message>();
    final Message result = await channel!.onPushReply(push.replyEvent);
    completer.complete(result);
    return completer.future;
  }

  void close() {
    _onMessageController.close();
    socket!.close();
  }
}
