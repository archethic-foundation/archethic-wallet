import 'package:aewallet/application/onramp/moonpay.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MoonpayOnRampSheet extends ConsumerStatefulWidget {
  const MoonpayOnRampSheet({super.key});

  static const String routerPage = '/moonpay_on_ramp';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MoonpayOnRampSheetState();
}

class _MoonpayOnRampSheetState extends ConsumerState<MoonpayOnRampSheet> {
  @override
  Widget build(BuildContext context) {
    final moonpaySettings = ref.watch(moonpaySettingsProvider);
    // final localizations = AppLocalizations.of(context);
    return SheetSkeleton(
      menu: true,
      // resizeToAvoidBottomInset: false,
      appBar: SheetAppBar(
        title: 'Buy with Moonpay',
        widgetLeft: BackButton(
          key: const Key('back'),
          color: ArchethicTheme.text,
          onPressed: () {
            context.pop();
          },
        ),
      ),
      sheetContent: SafeArea(
        child: InAppWebView(
          onWebViewCreated: (controller) async {
            controller.addJavaScriptHandler(
              handlerName: 'onRampDone',
              callback: (event) {
                context.pop();
              },
            );

            await controller.loadData(
              data: _pageContent(
                walletAddress: '0xAD1F4dF14DC3eb4094092CF44b713067431813B8',
                moonpayApiKey: moonpaySettings.apiKey,
              ),
            );
          },
        ),
      ),
    );
  }

  String _pageContent({
    required String walletAddress,
    required String moonpayApiKey,
  }) =>
      '''
<html>
<head>
    <title>MoonPay OnRamp</title>
    <style>
        html,
        body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
        }

        iframe {
            border: none;
            width: 100%;
            height: 100%;
        }
    </style>
    <script defer src="https://static.moonpay.com/web-sdk/v1/moonpay-web-sdk.min.js"></script>
    <script>
        window.addEventListener('load', async () => {
            const moonPay = window.MoonPayWebSdk.init;
            const widget = moonPay?.({
                flow: "buy",
                environment: 'sandbox',
                variant: 'embedded',
                containerNodeSelector: "body",
                params: {
                    apiKey: '$moonpayApiKey',
                    walletAddress: '$walletAddress', 
                    theme: 'dark',
                    baseCurrencyCode: 'eur',
                    baseCurrencyAmount: 100,
                    lockAmount: true,
                    defaultCurrencyCode: 'eth',
                },
                handlers: {
                    async onTransactionCompleted(props) {
                        window.flutter_inappwebview.callHandler('onRampDone');
                    },
                },
            });
            widget?.show();
        });
    </script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>

<body>
</body>
</html>
''';
}
