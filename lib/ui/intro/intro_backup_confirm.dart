// Flutter imports:
// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/dimens.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/model/vault.dart';
import 'package:archethic_wallet/service_locator.dart';
import 'package:archethic_wallet/styles.dart';
import 'package:archethic_wallet/ui/widgets/buttons.dart';
import 'package:archethic_wallet/ui/widgets/icon_widget.dart';
import 'package:archethic_wallet/ui/widgets/pin_screen.dart';

class IntroBackupConfirm extends StatefulWidget {
  @override
  _IntroBackupConfirmState createState() => _IntroBackupConfirmState();
}

class _IntroBackupConfirmState extends State<IntroBackupConfirm> {
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
                            context, 'assets/icons/writing.png', 90, 90),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(
                          start: smallScreen(context) ? 30 : 40,
                          end: smallScreen(context) ? 30 : 40,
                          top: 10,
                        ),
                        alignment: const AlignmentDirectional(-1, 0),
                        child: AutoSizeText(
                          AppLocalization.of(context)!.ackBackedUp,
                          maxLines: 4,
                          stepGranularity: 0.5,
                          style: AppStyles.textStyleSize28W700Primary(context),
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            start: smallScreen(context) ? 30 : 40,
                            end: smallScreen(context) ? 30 : 40,
                            top: 15.0),
                        child: AutoSizeText(
                          AppLocalization.of(context)!.secretWarning,
                          style: AppStyles.textStyleSize16W600Primary(context),
                          maxLines: 5,
                          stepGranularity: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        AppButton.buildAppButton(
                            context,
                            AppButtonType.PRIMARY,
                            AppLocalization.of(context)!.yes,
                            Dimens.BUTTON_TOP_DIMENS, onPressed: () async {
                          final String pin = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return const PinScreen(
                              PinOverlayType.NEW_PIN,
                            );
                          }));
                          if (pin.length > 5) {
                            _pinEnteredCallback(pin);
                          }
                        }),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        AppButton.buildAppButton(
                            context,
                            AppButtonType.PRIMARY,
                            AppLocalization.of(context)!.no,
                            Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                          Navigator.of(context).pop();
                        }),
                      ],
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

  Future<void> _pinEnteredCallback(String pin) async {
    await sl.get<Vault>().writePin(pin);
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/home',
      (Route<dynamic> route) => false,
    );
  }
}
