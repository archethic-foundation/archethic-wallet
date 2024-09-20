/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

class VerifiedTokenIcon extends ConsumerWidget {
  const VerifiedTokenIcon({
    required this.address,
    super.key,
  });

  final String address;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (address == 'UCO') {
      return _icon(context, ref);
    }

    return FutureBuilder<bool>(
      future: ref.read(
        aedappfm.VerifiedTokensProviders.isVerifiedToken(address).future,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            return _icon(context, ref);
          }
        }
        return const SizedBox();
      },
    );
  }

  Widget _icon(
    BuildContext context,
    WidgetRef ref,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);

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
          localizations.verifiedTokenInfo,
        );
      },
      child: Icon(
        Symbols.verified,
        color: ArchethicTheme.activeColorSwitch,
        size: 15,
      ),
    );
  }
}
