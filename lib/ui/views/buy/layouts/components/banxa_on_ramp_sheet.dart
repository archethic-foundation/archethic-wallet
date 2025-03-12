import 'dart:math';

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/widgets/components/web_browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BanxaOnRampSheet extends ConsumerWidget {
  const BanxaOnRampSheet({
    super.key,
    required this.depositAddress,
    required this.tokenId,
    required this.chainId,
  });

  final String depositAddress;
  final String tokenId;
  final String chainId;
  static const String routerPage = '/banxa_on_ramp';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebBrowser(
      uri: Uri.parse(
        'https://checkout.banxa.com/?coinType=$tokenId&blockchain=$chainId&orderType=buy&walletAddress=$depositAddress&backgroundColor=0d0621&primaryColor=2c1763&secondaryColor=5f33e2&textColor=000000&theme=dark&nonce=${Random().nextInt(10000)}',
      ),
      unavailableBuilder: (cause) => OnRampWebviewNotCompatible(cause: cause),
      onLoadStop: (controller, url) {
        controller.injectCSSCode(
          source: '''
                        /* Buy/Sell selection */
                        .form .buy { display: none; };
                      
                        /* Wallet address */
                        #walletAddress { pointer-events: none; }
                      
                        /* Token selection */
                        #autoCompleteSelectcoin  { pointer-events: none; }
                      
                        /* Wallet connect button */
                        .walletConnect-btn { display: none; }
                      
                        /* chain selection */
                        #dropdowndefault-select { pointer-events: none; }
                      ''',
        );
      },
    );
  }
}

class OnRampWebviewNotCompatible extends StatelessWidget {
  const OnRampWebviewNotCompatible({
    super.key,
    required this.cause,
  });

  final WebBrowserUnavailable cause;
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ArchethicTheme.backgroundSmall),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 150,
      ),
      child: Column(
        children: [
          Text(
            localizations.onrampWithFiatIncompatiblePlatformTitle,
            style: textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            localizations.onrampWithFiatIncompatiblePlatformBody,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
