import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeedLanguageSwitch extends ConsumerWidget {
  const SeedLanguageSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final language = ref.watch(
      SettingsProviders.settings.select(
        (settings) => settings.languageSeed,
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              localizations.languageEnglish,
              style: language == 'en'
                  ? Theme.of(context).textTheme.bodySmallWithOpacity.copyWith(
                        fontWeight: FontWeightTelegraf.fontWeightSemibold,
                      )
                  : Theme.of(context).textTheme.bodySmallWithOpacity,
            ),
            Container(
              padding: const EdgeInsets.only(left: 2),
              height: 30,
              child: Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: language == 'fr',
                  onChanged: (isFrench) async {
                    await ref
                        .read(
                          SettingsProviders.settings.notifier,
                        )
                        .setLanguageSeed(isFrench ? 'fr' : 'en');
                  },
                  inactiveTrackColor: Colors.white.withOpacity(0.2),
                  activeTrackColor: Colors.white.withOpacity(0.2),
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                ),
              ),
            ),
            Text(
              localizations.languageFrancais,
              style: language == 'fr'
                  ? Theme.of(context).textTheme.bodySmallWithOpacity.copyWith(
                        fontWeight: FontWeightTelegraf.fontWeightSemibold,
                      )
                  : Theme.of(context).textTheme.bodySmallWithOpacity,
            )
          ],
        ),
      ],
    );
  }
}
