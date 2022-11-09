/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkChoiceInfos extends ConsumerWidget {
  const NetworkChoiceInfos({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final settings = ref.watch(SettingsProviders.settings);
    final network = NetworksSetting(
      network: settings.networks,
      networkDevEndpoint: ref
          .watch(SettingsProviders.localSettingsRepository)
          .getNetworkDevEndpoint(),
    );

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  right: 15,
                ),
                child: Icon(
                  UiIcons.about,
                  size: 15,
                ),
              ),
              Expanded(
                child: AutoSizeText(
                  localizations.introNewWalletGetFirstInfosNetworkHeader,
                  style: theme.textStyleSize12W100Primary,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${localizations.introNewWalletGetFirstInfosNetworkChoice} ${network.getDisplayName(context)}',
            style: theme.textStyleSize12W400Primary,
          ),
        ],
      ),
    );
  }
}
