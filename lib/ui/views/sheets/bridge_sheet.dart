import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class BridgeInfoWidget extends StatelessWidget {
  const BridgeInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 150,
      ),
      child: Column(
        children: [
          Text(AppLocalizations.of(context)!.aeBridgeInfos1,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.aeBridgeInfos2,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              _launchURL('https://bridge.archethic.net');
            },
            child: Text(
              'https://bridge.archethic.net',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    decoration: TextDecoration.underline,
                    color: aedappfm.AppThemeBase.secondaryColor,
                  ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.aeBridgeInfos3,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
