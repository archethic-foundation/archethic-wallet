// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IntroBackupSafetyPage extends StatefulWidget {
  const IntroBackupSafetyPage({Key? key}) : super(key: key);

  @override
  _IntroBackupSafetyState createState() => _IntroBackupSafetyState();
}

class _IntroBackupSafetyState extends State<IntroBackupSafetyPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              StateContainer.of(context).curTheme.backgroundDark!,
              StateContainer.of(context).curTheme.background!
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
                top: MediaQuery.of(context).size.height * 0.075),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsetsDirectional.only(
                                  start: smallScreen(context) ? 15 : 20),
                              height: 50,
                              width: 50,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: FaIcon(FontAwesomeIcons.chevronLeft,
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .primary,
                                      size: 24)),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(
                            start: smallScreen(context) ? 30 : 40,
                            top: 15,
                          ),
                          child: buildIconWidget(
                            context,
                            'packages/aeuniverse/assets/icons/warning.png',
                            90,
                            90,
                            color: StateContainer.of(context).curTheme.warning,
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(
                            start: smallScreen(context) ? 30 : 40,
                            end: smallScreen(context) ? 30 : 40,
                            top: 10,
                          ),
                          alignment: const AlignmentDirectional(-1, 0),
                          child: AutoSizeText(
                            AppLocalization.of(context)!.warning,
                            style:
                                AppStyles.textStyleSize28W700Warning(context),
                            stepGranularity: 0.1,
                            maxLines: 1,
                            minFontSize: 12,
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(
                              start: smallScreen(context) ? 30 : 40,
                              end: smallScreen(context) ? 30 : 40,
                              top: 15.0),
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              AutoSizeText(
                                AppLocalization.of(context)!.backupSafetyLabel1,
                                style: AppStyles.textStyleSize20W700Primary(
                                    context),
                              ),
                              Divider(
                                height: 30,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                              ),
                              AutoSizeText(
                                AppLocalization.of(context)!.backupSafetyLabel2,
                                style: AppStyles.textStyleSize20W700Primary(
                                    context),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              AutoSizeText(
                                AppLocalization.of(context)!.backupSafetyLabel3,
                                style: AppStyles.textStyleSize16W600Primary(
                                    context),
                                textAlign: TextAlign.justify,
                              ),
                              Divider(
                                height: 30,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                              ),
                              AutoSizeText(
                                AppLocalization.of(context)!.backupSafetyLabel4,
                                style: AppStyles.textStyleSize20W700Primary(
                                    context),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              AutoSizeText(
                                AppLocalization.of(context)!.backupSafetyLabel5,
                                style: AppStyles.textStyleSize16W600Primary(
                                    context),
                                textAlign: TextAlign.justify,
                              ),
                              Divider(
                                height: 30,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary60,
                              ),
                              AutoSizeText(
                                AppLocalization.of(context)!.backupSafetyLabel6,
                                style: AppStyles.textStyleSize20W700Primary(
                                    context),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              AutoSizeText(
                                AppLocalization.of(context)!.backupSafetyLabel7,
                                style: AppStyles.textStyleSize16W600Primary(
                                    context),
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
                        AppButtonType.primary,
                        AppLocalization.of(context)!.understandButton,
                        Dimens.buttonBottomDimens, onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/intro_backup',
                      );
                    }),
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
