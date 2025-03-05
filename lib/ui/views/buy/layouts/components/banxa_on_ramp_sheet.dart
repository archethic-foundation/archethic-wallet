import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BanxaOnRampSheet extends ConsumerStatefulWidget {
  const BanxaOnRampSheet({
    super.key,
    required this.depositAddress,
  });

  final String depositAddress;
  static const String routerPage = '/banxa_on_ramp';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BanxaOnRampSheetState();
}

class _BanxaOnRampSheetState extends ConsumerState<BanxaOnRampSheet> {
  @override
  Widget build(BuildContext context) {
    return SheetSkeleton(
      menu: true,
      // resizeToAvoidBottomInset: false,
      appBar: SheetAppBar(
        title: 'Buy with Banxa',
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

            await controller.loadUrl(
              urlRequest: URLRequest(
                url: WebUri.uri(
                  Uri.parse(
                    'https://checkout.banxa.com/?coinType=ETH&blockchain=BSC&orderType=buy&walletAddress=${widget.depositAddress}&backgroundColor=0d0621&primaryColor=2c1763&secondaryColor=5f33e2&textColor=000000&theme=dark',
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
