import 'dart:async';
import 'dart:convert';

import 'package:aewallet/infrastructure/rpc/awc_json_rpc_server.dart';
import 'package:aewallet/util/universal_platform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logging/logging.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:url_launcher/url_launcher.dart';

const evmWalletsSchemes = [
  'metamask',
  'trust',
  'okex',
  'bnc',
  'uniswap',
  'safepalwallet',
  'rainbow',
  'exodus',
  'safe',
];

class AWCWebview extends StatefulWidget {
  const AWCWebview({super.key, required this.uri});

  static final _logger = Logger('AWCWebview');

  static bool get isAvailable => UniversalPlatform.isMobile;

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

class _AWCWebviewState extends State<AWCWebview> with WidgetsBindingObserver {
  AWCJsonRPCServer? _peerServer;
  InAppWebViewController? _controller;
  WebviewMessagePortStreamChannel? _channel;

  @override
  void initState() {
    if (kDebugMode &&
        !kIsWeb &&
        defaultTargetPlatform == TargetPlatform.android) {
      InAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    _peerServer?.close();
    WidgetsBinding.instance.removeObserver(this);
    AWCWebview._logger.info('AWC webview disposed.');

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _restoreMessageChannelRPC(_controller!);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: Colors.black,
        child: InAppWebView(
          initialSettings: InAppWebViewSettings(
            isInspectable: kDebugMode,
            transparentBackground: true,
          ),
          onLoadStop: (controller, url) async {
            _controller = controller;
            await _initMessageChannelRPC(controller);
          },
          onWebViewCreated: (controller) async {
            await controller.loadUrl(
              urlRequest: URLRequest(url: WebUri.uri(widget.uri)),
            );
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            final uri = navigationAction.request.url;
            if (uri == null) {
              return NavigationActionPolicy.ALLOW;
            }

            final isAnEvmWalletDeeplink = evmWalletsSchemes.any(
              (scheme) => uri.scheme.startsWith(scheme),
            );

            if (!isAnEvmWalletDeeplink) {
              return NavigationActionPolicy.ALLOW;
            }

            if (!await canLaunchUrl(uri.uriValue)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Wallet not installed')),
              );
              return NavigationActionPolicy.CANCEL;
            }
            await launchUrl(uri, mode: LaunchMode.externalApplication);

            return NavigationActionPolicy.CANCEL;
          },
          onReceivedServerTrustAuthRequest: (controller, challenge) async {
            // TODO(reddwarf03): WARNING: Accepting all certificates is dangerous and should only be used during development.
            return ServerTrustAuthResponse(
              action: ServerTrustAuthResponseAction.PROCEED,
            );
          },
        ),
      );

  Future<void> _restoreMessageChannelRPC(
    InAppWebViewController controller,
  ) async {
    final isMessageChannelReady = await controller.evaluateJavascript(
      source: "typeof awc !== 'undefined'",
    );
    if (!isMessageChannelReady || _channel == null) {
      AWCWebview._logger.info('AWC never initialized. Abort restoration.');
      return;
    }

    if (!await AWCWebview.isAWCSupported) {
      AWCWebview._logger.info('AWC unsupported.');
      return;
    }

    AWCWebview._logger.info('Restoring AWC.');
    final port1 = await _restoreMessageChannelPorts(controller);

    _channel?.port = port1;
  }

  Future<WebMessagePort> _restoreMessageChannelPorts(
    InAppWebViewController controller,
  ) async {
    final webMessageChannel = await controller.createWebMessageChannel();
    final port1 = webMessageChannel!.port1;
    final port2 = webMessageChannel.port2;

    // transfer port2 to the webpage to initialize the communication
    await controller.postWebMessage(
      message: WebMessage(data: 'restorePort', ports: [port2]),
      targetOrigin: WebUri('*'),
    );
    return port1;
  }

  Future<void> _initMessageChannelRPC(
    InAppWebViewController controller,
  ) async {
    final isMessageChannelReady = await controller.evaluateJavascript(
      source: "typeof awc !== 'undefined'",
    );
    if (isMessageChannelReady) {
      AWCWebview._logger.info('AWC already initialized.');
      return;
    }

    if (!await AWCWebview.isAWCSupported) {
      AWCWebview._logger.info('AWC unsupported.');
      return;
    }

    AWCWebview._logger.info('Initializing AWC.');
    final port1 = await _initMessageChannelPorts(controller);

    final channel = WebviewMessagePortStreamChannel(port: port1);
    final peerServer = AWCJsonRPCServer(channel.cast<String>());
    _channel = channel;
    _peerServer = peerServer;
    await peerServer.listen();
  }

  Future<WebMessagePort> _initMessageChannelPorts(
    InAppWebViewController controller,
  ) async {
    await controller.evaluateJavascript(
      source: """
class RestorableMessagePort {
    #port;
    #onmessage;
    #onmessageerror;
    #onclose;
    set port(port) {
        var previousPort = this.#port;
        this.#port = port;
        this.#port.onmessage = this.#onmessage;
        this.#port.onmessageerror = this.#onmessageerror;
        this.#port.onclose = this.#onclose;
        if (previousPort) {
            previousPort.close();
        }
    }

    close() {
        this.#port.close();
    }

    start() {
        this.#port.start();
    }

    postMessage(message, transfer) {
        this.#port.postMessage(message, transfer);
    }

    get onmessage() {
        return this.#onmessage;
    }
    set onmessage(callback) {
        this.#onmessage = callback;
        this.#port.onmessage = callback;
    }

    get onmessageerror() {
        return this.#onmessageerror;
    }
    set onmessageerror(callback) {
        this.#onmessageerror = callback;
        this.#port.onmessageerror = callback;
    }

    get onclose() {
        return this.#onclose;
    }
    set onclose(callback) {
        this.#onclose = callback;
        this.#port.onclose = callback;
    }
}
console.info("[AWC] Init webmessage");
var onAWCReady = (awc) => {};
var awcAvailable = true;
var awc;
window.addEventListener('message', function(event) {
    if (event.data == 'capturePort') {
        if (event.ports[0] != null) {
            awc = new RestorableMessagePort();
            awc.port = event.ports[0];
            console.info("[AWC] Init webmessage Done");
            if (onAWCReady !== undefined) {
              onAWCReady(awc);
            }
        }
        return;
    }
    if (event.data == 'restorePort') {
        if (event.ports[0] != null) {
          if (!awc) {
            console.error("[AWC] Port not available. Abort restoration.");
            return;
          }
          awc.port = event.ports[0];
          console.info("[AWC] Webmessage restoration Done");
        }
        return;
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
    return port1;
  }
}

class WebviewMessagePortStreamChannel
    with StreamChannelMixin<String>
    implements StreamChannel<String> {
  WebviewMessagePortStreamChannel({required IWebMessagePort port}) {
    logger.info('Wallet Init WebMessage PortStreamchannel');

    this.port = port;
    _out.stream.listen((event) {
      this.port.postMessage(WebMessage(data: event));
      logger.info('Response sent ${jsonEncode(event)}');
    });
  }
  final logger = Logger('AWS-StreamChannel-Webview');

  IWebMessagePort? _port;
  final _in = StreamController<String>(sync: true);
  final _out = StreamController<String>(sync: true);

  IWebMessagePort get port => _port!;
  set port(IWebMessagePort port) {
    _port?.close();
    _port = port;
    port.setWebMessageCallback((message) {
      if (message == null) return;
      logger.info('Message received ${jsonEncode(message.data)}');
      _in.add(message.data);
    });
  }

  @override
  StreamSink<String> get sink => _out.sink;

  @override
  Stream<String> get stream => _in.stream;
}
