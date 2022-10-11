/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
// Package imports:
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

    return Scaffold(
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
          builder: (BuildContext context, BoxConstraints constraints) => SafeArea(
            minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
              top: MediaQuery.of(context).size.height * 0.075,
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
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
                        IconWidget(
                          icon: 'assets/icons/warning.png',
                          width: 90,
                          height: 90,
                          color: theme.warning,
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                            top: 10,
                          ),
                          child: AutoSizeText(
                            localizations.warning,
                            style: theme.textStyleSize28W700Warning,
                          ),
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
                                style: theme.textStyleSize16W600Primary,
                              ),
                              Divider(
                                height: 30,
                                color: theme.text60,
                              ),
                              AutoSizeText(
                                localizations.backupSafetyLabel2,
                                style: theme.textStyleSize16W600Primary,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              AutoSizeText(
                                localizations.backupSafetyLabel3,
                                style: theme.textStyleSize14W600Primary,
                                textAlign: TextAlign.justify,
                              ),
                              Divider(
                                height: 30,
                                color: theme.text60,
                              ),
                              AutoSizeText(
                                localizations.backupSafetyLabel4,
                                style: theme.textStyleSize16W600Primary,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              AutoSizeText(
                                localizations.backupSafetyLabel5,
                                style: theme.textStyleSize14W600Primary,
                                textAlign: TextAlign.justify,
                              ),
                              Divider(
                                height: 30,
                                color: theme.text60,
                              ),
                              AutoSizeText(
                                localizations.backupSafetyLabel6,
                                style: theme.textStyleSize16W600Primary,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              AutoSizeText(
                                localizations.backupSafetyLabel7,
                                style: theme.textStyleSize14W600Primary,
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Next Screen Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AppButton.buildAppButton(
                      const Key('understandButton'),
                      context,
                      ref,
                      AppButtonType.primary,
                      localizations.understandButton,
                      Dimens.buttonBottomDimens,
                      onPressed: () {
                        Navigator.of(context).pushNamed('/intro_backup', arguments: name);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
