/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/certified_tokens.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

class CertifiedTokenIcon extends ConsumerWidget {
  const CertifiedTokenIcon({
    required this.address,
    super.key,
  });

  final String address;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);

    return FutureBuilder<bool>(
      future: ref.read(
        CertifiedTokensProviders.isCertifiedToken(address).future,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            return InkWell(
              onTap: () {
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      preferences.activeVibrations,
                    );
                AppDialogs.showInfoDialog(
                  context,
                  ref,
                  localizations.information,
                  localizations.certifiedTokenInfo,
                );
              },
              child: Icon(
                Symbols.verified,
                color: theme.activeColorSwitch,
                size: 15,
              ),
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
