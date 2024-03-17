/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DEXSheet extends ConsumerStatefulWidget {
  const DEXSheet({
    super.key,
  });

  static const String routerPage = '/dex';

  @override
  ConsumerState<DEXSheet> createState() => DEXSheetState();
}

class DEXSheetState extends ConsumerState<DEXSheet> {
  late WebViewController? _webViewController;

  @override
  void initState() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel(
        'awc',
        onMessageReceived: (JavaScriptMessage message) async {
          print('message ${message.message}');
          await _webViewController!
              .runJavaScript("window.postMessage('toto', '*');");
          await _webViewController!
              .runJavaScript("window.postMessage('toto', '*');");

          await _webViewController!.runJavaScript('''
const event = new CustomEvent("myCustomEvent", {
    detail: {foo: 1, bar: false}
});
window.dispatchEvent(event);''');
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {
            log('$error');
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('http://localhost:59295/swap'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: WebViewWidget(
        controller: _webViewController!,
      ),
    );
  }
}
