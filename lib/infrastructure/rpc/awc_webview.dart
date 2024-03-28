import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:aewallet/infrastructure/rpc/awc_json_rpc_server.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:stream_channel/stream_channel.dart';

class AWCWebview extends StatefulWidget {
  const AWCWebview({super.key, required this.uri});

  static const _logName = 'AWCWebview';

  static bool get isAvailable => Platform.isAndroid || Platform.isIOS;

  final Uri uri;

  static Future<bool> get isAWCSupported async {
    return defaultTargetPlatform != TargetPlatform.android ||
        await WebViewFeature.isFeatureSupported(
          WebViewFeature.CREATE_WEB_MESSAGE_CHANNEL,
        );
  }

  @override
  State<AWCWebview> createState() => _AWCWebviewState();
}

class _AWCWebviewState extends State<AWCWebview> {
  AWCJsonRPCServer? peerServer;
  bool _isMessageChannelReady = false;

  @override
  void initState() {
    if (kDebugMode &&
        !kIsWeb &&
        defaultTargetPlatform == TargetPlatform.android) {
      InAppWebViewController.setWebContentsDebuggingEnabled(true);
    }

    super.initState();
  }

  @override
  void dispose() {
    peerServer?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => InAppWebView(
        onLoadStop: (controller, url) async {
          await _initMessageChannelRPC(controller, url);
        },
        onWebViewCreated: (controller) async {
          await controller.loadUrl(
            urlRequest: URLRequest(url: WebUri.uri(widget.uri)),
          );
        },
        onReceivedServerTrustAuthRequest: (controller, challenge) async {
          // TODO(reddwarf03): WARNING: Accepting all certificates is dangerous and should only be used during development.
          return ServerTrustAuthResponse(
            action: ServerTrustAuthResponseAction.PROCEED,
          );
        },
      );

  Future<void> _initMessageChannelRPC(
    InAppWebViewController controller,
    WebUri? uri,
  ) async {
    if (_isMessageChannelReady) return;
    if (!await AWCWebview.isAWCSupported) {
      log('AWC unsupported.', name: AWCWebview._logName);
      return;
    }

    final port1 = await _initMessageChannelPorts(controller);

    final channel = WebMessagePortStreamChannel(port: port1);
    peerServer = AWCJsonRPCServer(channel.cast<String>());
    await peerServer?.listen();
  }

  Future<WebMessagePort> _initMessageChannelPorts(
    InAppWebViewController controller,
  ) async {
    controller.evaluateJavascript(
      source: """
console.log("[AWC] Init webmessage");
var onAWCReady = (awc) => {};
var awcAvailable = true;
var awc;
window.addEventListener('message', function(event) {
    if (event.data == 'capturePort') {
        if (event.ports[0] != null) {
            awc = event.ports[0];
            console.log("[AWC] Init webmessage Done");
            if (onAWCReady !== undefined) {
              onAWCReady(awc);
            }
        }
    }
}, false);
""",
    );
    final webMessageChannel = await controller.createWebMessageChannel();
    final port1 = webMessageChannel!.port1;
    final port2 = webMessageChannel.port2;

    // transfer port2 to the webpage to initialize the communication
    await controller.postWebMessage(
      message: WebMessage(data: 'capturePort', ports: [port2]),
      targetOrigin: WebUri('*'),
    );
    _isMessageChannelReady = true;
    return port1;
  }
}

class WebMessagePortStreamChannel
    with StreamChannelMixin<String>
    implements StreamChannel<String> {
  WebMessagePortStreamChannel({required this.port}) {
    port.setWebMessageCallback((message) {
      if (message == null) return;
      _in.add(message.data);
    });

    _out.stream.listen((event) {
      port.postMessage(WebMessage(data: event));
    });
  }

  final WebMessagePort port;
  final _in = StreamController<String>(sync: true);
  final _out = StreamController<String>(sync: true);

  @override
  StreamSink<String> get sink => _out.sink;

  @override
  Stream<String> get stream => _in.stream;
}
