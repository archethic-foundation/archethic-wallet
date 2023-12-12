/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConnectivityWarning extends ConsumerWidget {
  const ConnectivityWarning({super.key});

  static const routerPage = '/connectivity_warning';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);
    final localizations = AppLocalizations.of(context)!;
    return SafeArea(
      minimum: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.035,
      ),
      child: Column(
        children: <Widget>[
          SheetHeader(title: localizations.information),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      const Icon(Symbols.warning, color: Colors.red),
                      const SizedBox(width: 10),
                      Text(
                        localizations.connectivityWarningHeader,
                        style: ArchethicThemeStyles.textStyleSize14W600Primary,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    localizations.connectivityWarningDesc,
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              AppButtonTiny(
                AppButtonTinyType.primary,
                localizations.understandButton,
                Dimens.buttonBottomDimens,
                key: const Key('Understand'),
                onPressed: () async {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        preferences.activeVibrations,
                      );
                  context.pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
