// Dart imports:
import 'dart:async';

// Package imports:
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_link/gql_link.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

/// a link for subscriptions (or also mutations/queries) over phoenix channels
class PhoenixLink extends Link {
  /// the underlying phoenix channel
  final PhoenixChannel channel;

  final RequestSerializer _serializer;
  final ResponseParser _parser;

  /// create a new [PhoenixLink] using an established PhoenixChannel [channel].
  /// You can use the static [createChannel] method to create a [PhoenixChannel]
  /// from a websocket URI and optional parameters (e.g. for authentication)
  PhoenixLink(
      {required PhoenixChannel channel,
      ResponseParser parser = const ResponseParser(),
      RequestSerializer serializer = const RequestSerializer()})
      : channel = channel,
        _serializer = serializer,
        _parser = parser;

  /// create a new phoenix socket from the given websocketUri,
  /// connect to it, and create a channel, and join it
  static Future<PhoenixChannel> createChannel(
      {required String websocketUri, Map<String, String>? params}) async {
    final socket = PhoenixSocket(websocketUri,
        socketOptions: PhoenixSocketOptions(params: params));
    await socket.connect();

    final channel = socket.addChannel(topic: '__absinthe__:control');
    final push = channel.join();
    await push.future;

    return channel;
  }

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    assert(forward == null, '$this does not support a NextLink (got $forward)');
    final payload = _serializer.serializeRequest(request);
    String? phoenixSubscriptionId;
    StreamSubscription<Response>? websocketSubscription;

    StreamController<Response>? streamController;
    final push = channel.push('doc', payload);
    try {
      final pushResponse = await push.future;
      //set the subscription id in order to cancel the subscription later
      phoenixSubscriptionId =
          pushResponse.response['subscriptionId'] as String?;

      if (phoenixSubscriptionId != null) {
        //yield all messages for this subscription
        streamController = StreamController();

        websocketSubscription = channel.socket
            .streamForTopic(phoenixSubscriptionId)
            .map((event) => _parser.parseResponse(
                event.payload!['result'] as Map<String, dynamic>))
            .listen(streamController.add, onError: streamController.addError);
        yield* streamController.stream;
      } else if (pushResponse.isOk) {
        yield _parser
            .parseResponse(pushResponse.response as Map<String, dynamic>);
      } else if (pushResponse.isError) {
        throw _parser.parseError(pushResponse.response as Map<String, dynamic>);
      }
    } finally {
      await websocketSubscription?.cancel();
      await streamController?.close();
      //this will be called once the caller stops listening to the stream
      // (yield* stops if there is no one listening)
      if (phoenixSubscriptionId != null) {
        channel.push('unsubscribe', {'subscriptionId': phoenixSubscriptionId});
      }
    }
  }
}
