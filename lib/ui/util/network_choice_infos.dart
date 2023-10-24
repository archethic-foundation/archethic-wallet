/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class NetworkChoiceInfos extends ConsumerWidget {
  const NetworkChoiceInfos({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(SettingsProviders.settings);
    final network = settings.network;
    return Container(
      padding: const EdgeInsets.only(right: 10),
      width: 230,
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  width: 0.5,
                ),
                gradient: ArchethicThemeBase.gradientInputFormBackground,
              ),
              child: InkWell(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 30,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            network.getDisplayName(context),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 5),
                          const Icon(Symbols.arrow_drop_down)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }
}
