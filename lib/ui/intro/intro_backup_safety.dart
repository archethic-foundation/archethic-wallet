// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/dimens.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/widgets/buttons.dart';
import 'package:archethic_mobile_wallet/ui/widgets/icon_widget.dart';

class IntroBackupSafetyPage extends StatefulWidget {
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
                              context, 'assets/icons/warning.png', 90, 90),
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
                                AppStyles.textStyleSize28W700Primary(context),
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
                              Text(
                                AppLocalization.of(context)!.backupSafetyLabel1,
                                style: AppStyles.textStyleSize16W600Primary(
                                    context),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                AppLocalization.of(context)!.backupSafetyLabel2,
                                style: AppStyles.textStyleSize16W700Primary(
                                    context),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              AutoSizeText(
                                AppLocalization.of(context)!.backupSafetyLabel3,
                                style: AppStyles.textStyleSize16W600Primary(
                                    context),
                                maxLines: 5,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppLocalization.of(context)!.backupSafetyLabel4,
                                style: AppStyles.textStyleSize16W700Primary(
                                    context),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              AutoSizeText(
                                AppLocalization.of(context)!.backupSafetyLabel5,
                                style: AppStyles.textStyleSize16W600Primary(
                                    context),
                                maxLines: 5,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppLocalization.of(context)!.backupSafetyLabel6,
                                style: AppStyles.textStyleSize16W700Primary(
                                    context),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                AppLocalization.of(context)!.backupSafetyLabel7,
                                style: AppStyles.textStyleSize12W600Primary(
                                    context),
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
                        context,
                        AppButtonType.PRIMARY,
                        AppLocalization.of(context)!.understandButton,
                        Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                      Navigator.of(context).pushNamed('/intro_backup',
                          arguments:
                              StateContainer.of(context).encryptedSecret);
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
