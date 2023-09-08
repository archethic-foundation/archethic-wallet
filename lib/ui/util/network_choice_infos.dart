/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class NetworkChoiceInfos extends ConsumerWidget {
  const NetworkChoiceInfos({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final settings = ref.watch(SettingsProviders.settings);
    final network = settings.network;
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
                  Symbols.info,
                  size: 15,
                  weight: IconSize.weightM,
                  opticalSize: IconSize.opticalSizeM,
                  grade: IconSize.gradeM,
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
          if (network.networkDevEndpoint.isNotEmpty)
            Text(
              network.networkDevEndpoint,
              style: theme.textStyleSize12W400Primary,
            ),
        ],
      ),
    );
  }
}
