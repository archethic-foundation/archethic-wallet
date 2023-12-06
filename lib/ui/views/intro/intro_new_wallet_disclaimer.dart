/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/intro/intro_backup_seed.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class IntroNewWalletDisclaimer extends ConsumerWidget {
  const IntroNewWalletDisclaimer({super.key, this.name});
  final String? name;

  static const routerPage = '/intro_backup_safety';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ArchethicTheme.backgroundSmall,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              ArchethicTheme.backgroundDark,
              ArchethicTheme.background,
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
            ),
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsetsDirectional.only(
                            start: smallScreen(context) ? 15 : 20,
                          ),
                          height: 50,
                          width: 50,
                          child: BackButton(
                            key: const Key('back'),
                            color: ArchethicTheme.text,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ArchethicScrollbar(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Symbols.warning_amber,
                                  color: Colors.red,
                                  size: 24,
                                  weight: IconSize.weightM,
                                  opticalSize: IconSize.opticalSizeM,
                                  grade: IconSize.gradeM,
                                ),
                                const SizedBox(width: 8),
                                AutoSizeText(
                                  localizations.warning,
                                  style: ArchethicThemeStyles
                                      .textStyleSize24W700PrimaryRed,
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsetsDirectional.only(
                                start: 20,
                                end: 20,
                                top: 15,
                              ),
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AutoSizeText(
                                    localizations.backupSafetyLabel1,
                                    style: ArchethicThemeStyles
                                        .textStyleSize14W600Primary,
                                  ),
                                  Divider(
                                    height: 20,
                                    color: ArchethicTheme.text60,
                                  ),
                                  AutoSizeText(
                                    localizations.backupSafetyLabel2,
                                    style: ArchethicThemeStyles
                                        .textStyleSize14W600Primary,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AutoSizeText(
                                    localizations.backupSafetyLabel3,
                                    style: ArchethicThemeStyles
                                        .textStyleSize12W100Primary,
                                    textAlign: TextAlign.justify,
                                  ),
                                  Divider(
                                    height: 20,
                                    color: ArchethicTheme.text60,
                                  ),
                                  AutoSizeText(
                                    localizations.backupSafetyLabel4,
                                    style: ArchethicThemeStyles
                                        .textStyleSize14W600Primary,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AutoSizeText(
                                    localizations.backupSafetyLabel5,
                                    style: ArchethicThemeStyles
                                        .textStyleSize12W100Primary,
                                    textAlign: TextAlign.justify,
                                  ),
                                  Divider(
                                    height: 20,
                                    color: ArchethicTheme.text60,
                                  ),
                                  AutoSizeText(
                                    localizations.backupSafetyLabel6,
                                    style: ArchethicThemeStyles
                                        .textStyleSize14W600Primary,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AutoSizeText(
                                    localizations.backupSafetyLabel7,
                                    style: ArchethicThemeStyles
                                        .textStyleSize12W100Primary,
                                    textAlign: TextAlign.justify,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppButtonTinyConnectivity(
                          localizations.understandButton,
                          Dimens.buttonBottomDimens,
                          key: const Key('understandButton'),
                          onPressed: () {
                            context.go(
                              IntroBackupSeedPage.routerPage,
                              extra: name,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                if (connectivityStatusProvider ==
                    ConnectivityStatus.isDisconnected)
                  const IconNetworkWarning(
                    alignment: Alignment.topRight,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
