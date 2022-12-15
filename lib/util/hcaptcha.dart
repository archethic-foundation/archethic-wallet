library hcaptcha;

import 'dart:async';

import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

String? _siteKey;

class HCaptcha {
  static void init({
    String? siteKey,
  }) {
    _siteKey = siteKey;
  }

  static Future<String?> show(BuildContext context) async {
    if (_siteKey == null) {
      throw Exception(
        'hCaptcha not yet initialized. Initialize it with siteKey or initialUrl',
      );
    }

    return Navigator.of(context).push<String>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const HCaptchaScreen(),
      ),
    );
  }
}

class HCaptchaScreen extends ConsumerStatefulWidget {
  const HCaptchaScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HCaptchaScreenState();
}

class _HCaptchaScreenState extends ConsumerState<HCaptchaScreen> {
  WebViewController? webViewController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  String get data => '''
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" content="IE=edge">
    <script src="https://hcaptcha.com/1/api.js" async defer></script>
  </head>
  <body style='background-color: transparent;'>
    <form action="?" method="POST">
      <div class="h-captcha" 
        data-sitekey="$_siteKey"
        data-callback="captchaCallback"></div>
    </form>
    <script>
      function captchaCallback(response) {
        if (typeof Captcha!=="undefined") {
          Captcha.postMessage(response);
        }
      }
    </script>
  </body>
</html>''';

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              theme.background3Small!,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(
                        start: smallScreen(context) ? 15 : 20,
                      ),
                      height: 50,
                      width: 50,
                      child: CloseButton(
                        key: const Key('back'),
                        color: theme.text,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: WebView(
                        onPageStarted: (url) {
                          setState(() {
                            isLoading = true;
                          });
                        },
                        onPageFinished: (url) {
                          setState(() {
                            isLoading = false;
                          });
                        },
                        onWebViewCreated: (controller) {
                          webViewController = controller;
                          controller.loadHtmlString(
                            data,
                            baseUrl: 'https://archethic.net',
                          );
                        },
                        zoomEnabled: false,
                        javascriptMode: JavascriptMode.unrestricted,
                        backgroundColor: Colors.transparent,
                        javascriptChannels: <JavascriptChannel>{
                          JavascriptChannel(
                            name: 'Captcha',
                            onMessageReceived: (JavascriptMessage message) {
                              // message contains the 'h-captcha-response' token.
                              // Send it to your server in the login or other
                              // data for verification via /siteverify
                              // see: https://docs.hcaptcha.com/#server
                              // print(message.message);
                              Navigator.of(context).pop(message.message);
                            },
                          )
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _LoadingScreen(
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingScreen extends ConsumerWidget {
  const _LoadingScreen({
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(
                    start: smallScreen(context) ? 15 : 20,
                  ),
                  height: 50,
                  width: 50,
                  child: CloseButton(
                    key: const Key('back'),
                    color: theme.text,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          theme.background3Small!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: theme.text,
                        strokeWidth: 1,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}
