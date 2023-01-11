/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/banner_connectivity.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroNewWalletDisclaimer extends ConsumerWidget {
  const IntroNewWalletDisclaimer({super.key, this.name});
  final String? name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  theme.background1Small!,
                ),
                fit: BoxFit.fitHeight,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[theme.backgroundDark!, theme.background!],
              ),
            ),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  SafeArea(
                minimum: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.035,
                  top: MediaQuery.of(context).size.height * 0.075,
                ),
                child: Column(
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
                            color: theme.text,
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
                                  UiIcons.warning,
                                  color: Colors.red,
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                AutoSizeText(
                                  localizations.warning,
                                  style: theme
                                      .textStyleSize24W700EquinoxPrimaryRed,
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
                                    style: theme.textStyleSize14W600Primary,
                                  ),
                                  Divider(
                                    height: 20,
                                    color: theme.text60,
                                  ),
                                  AutoSizeText(
                                    localizations.backupSafetyLabel2,
                                    style: theme.textStyleSize14W600Primary,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AutoSizeText(
                                    localizations.backupSafetyLabel3,
                                    style: theme.textStyleSize12W100Primary,
                                    textAlign: TextAlign.justify,
                                  ),
                                  Divider(
                                    height: 20,
                                    color: theme.text60,
                                  ),
                                  AutoSizeText(
                                    localizations.backupSafetyLabel4,
                                    style: theme.textStyleSize14W600Primary,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AutoSizeText(
                                    localizations.backupSafetyLabel5,
                                    style: theme.textStyleSize12W100Primary,
                                    textAlign: TextAlign.justify,
                                  ),
                                  Divider(
                                    height: 20,
                                    color: theme.text60,
                                  ),
                                  AutoSizeText(
                                    localizations.backupSafetyLabel6,
                                    style: theme.textStyleSize14W600Primary,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AutoSizeText(
                                    localizations.backupSafetyLabel7,
                                    style: theme.textStyleSize12W100Primary,
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
                        if (connectivityStatusProvider ==
                            ConnectivityStatus.isConnected)
                          AppButtonTiny(
                            AppButtonTinyType.primary,
                            localizations.understandButton,
                            Dimens.buttonBottomDimens,
                            key: const Key('understandButton'),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/intro_backup', arguments: name);
                            },
                          )
                        else
                          AppButtonTiny(
                            AppButtonTinyType.primaryOutline,
                            localizations.understandButton,
                            Dimens.buttonBottomDimens,
                            key: const Key('understandButton'),
                            onPressed: () {},
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const BannerConnectivity(),
      ],
    );
  }
}
