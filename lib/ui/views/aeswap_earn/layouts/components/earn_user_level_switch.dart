import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/settings.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/text/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EarnUserLevelSwitch extends ConsumerWidget {
  const EarnUserLevelSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final earnUserLevel = ref.watch(
      SettingsProviders.settings.select((settings) => settings.earnUserLevel),
    );
    final preferencesNotifier = ref.read(SettingsProviders.settings.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          localizations.earnUserLevelSwitchLabel,
          style: Theme.of(context).textTheme.bodySmallWithOpacity.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (earnUserLevel == EarnUserLevelType.beginner)
              GradientText(
                localizations.earnUserLevelSwitchBeginner,
                style: Theme.of(context).textTheme.bodySmallWithOpacity,
                gradient: ArchethicGradients.gradientArchethic,
              )
            else
              Text(
                localizations.earnUserLevelSwitchBeginner,
                style: Theme.of(context).textTheme.bodySmallWithOpacity,
              ),
            Container(
              padding: const EdgeInsets.only(left: 2),
              height: 30,
              child: Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: earnUserLevel == EarnUserLevelType.advanced,
                  onChanged: (bool isAdvanced) {
                    preferencesNotifier.setEarnUserLevel(
                      isAdvanced
                          ? EarnUserLevelType.advanced
                          : EarnUserLevelType.beginner,
                    );
                  },
                  inactiveTrackColor: Colors.white.withOpacity(0.2),
                  activeTrackColor: Colors.white.withOpacity(0.2),
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                ),
              ),
            ),
            if (earnUserLevel == EarnUserLevelType.advanced)
              GradientText(
                localizations.earnUserLevelSwitchAdvanced,
                style: Theme.of(context).textTheme.bodySmallWithOpacity,
                gradient: ArchethicGradients.gradientArchethic,
              )
            else
              Text(
                localizations.earnUserLevelSwitchAdvanced,
                style: Theme.of(context).textTheme.bodySmallWithOpacity,
              ),
          ],
        ),
      ],
    );
  }
}
