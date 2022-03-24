// Flutter imports:
// ignore_for_file: always_specify_types

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/views/pin_screen.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/util/vault.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IntroBackupConfirm extends StatefulWidget {
  const IntroBackupConfirm({Key? key}) : super(key: key);

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
                            context,
                            'packages/aeuniverse/assets/icons/writing.png',
                            90,
                            90),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                  style: AppStyles.textStyleSize20W700Primary(
                                      context),
                                ),
                              ),
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: smallScreen(context) ? 30 : 40,
                                    end: smallScreen(context) ? 30 : 40,
                                    top: 15.0),
                                child: AutoSizeText(
                                  AppLocalization.of(context)!.secretWarning,
                                  style: AppStyles.textStyleSize24W600Primary(
                                      context),
                                  maxLines: 6,
                                  stepGranularity: 0.5,
                                ),
                              ),
                            ],
                          ),
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
                            const Key('yes'),
                            context,
                            AppButtonType.primary,
                            AppLocalization.of(context)!.yes,
                            Dimens.buttonTopDimens, onPressed: () async {
                          final String pin = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return const PinScreen(
                              PinOverlayType.newPin,
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
                            const Key('no'),
                            context,
                            AppButtonType.primary,
                            AppLocalization.of(context)!.no,
                            Dimens.buttonBottomDimens, onPressed: () {
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
    final Vault _vault = await Vault.getInstance();
    _vault.setPin(pin);
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/home',
      (Route<dynamic> route) => false,
    );
  }
}
