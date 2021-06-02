// @dart=2.9

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:uniris_mobile_wallet/app_icons.dart';
import 'package:uniris_mobile_wallet/model/db/appdb.dart';
import 'package:uniris_mobile_wallet/service_locator.dart';
import 'package:uniris_mobile_wallet/model/vault.dart';
import 'package:uniris_mobile_wallet/styles.dart';
import 'package:uniris_mobile_wallet/ui/util/particles/particles_flutter.dart';
import 'package:uniris_mobile_wallet/ui/widgets/app_text_field.dart';
import 'package:uniris_mobile_wallet/ui/widgets/security.dart';
import 'package:uniris_mobile_wallet/ui/widgets/tap_outside_unfocus.dart';
import 'package:uniris_mobile_wallet/util/app_ffi/apputil.dart';
import 'package:uniris_mobile_wallet/ui/widgets/buttons.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/localization.dart';
import 'package:uniris_mobile_wallet/dimens.dart';
import 'package:uniris_mobile_wallet/util/sharedprefsutil.dart';

class IntroEnterPasswordAccess extends StatefulWidget {
  @override
  _IntroEnterPasswordAccessState createState() =>
      _IntroEnterPasswordAccessState();
}

class _IntroEnterPasswordAccessState extends State<IntroEnterPasswordAccess> {
  FocusNode enterPasswordFocusNode;
  TextEditingController enterPasswordController;

  String passwordError;

  @override
  void initState() {
    super.initState();
    this.enterPasswordFocusNode = FocusNode();
    this.enterPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  StateContainer.of(context).curTheme.backgroundDark,
                  StateContainer.of(context).curTheme.background
                ],
              ),
            ),
            child: CircularParticle(
              awayRadius: 80,
              numberOfParticles: 80,
              speedOfParticles: 0.5,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              onTapAnimation: true,
              particleColor: StateContainer.of(context)
                  .curTheme
                  .primary10
                  .withAlpha(150)
                  .withOpacity(0.2),
              awayAnimationDuration: Duration(milliseconds: 600),
              maxParticleSize: 8,
              isRandSize: true,
              isRandomColor: false,
              awayAnimationCurve: Curves.easeInOutBack,
              enableHover: true,
              hoverColor: StateContainer.of(context).curTheme.primary30,
              hoverRadius: 90,
              connectDots: true,
            ),
          ),
          TapOutsideUnfocus(
            child: Container(
              width: double.infinity,
              child: SafeArea(
                minimum: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.035,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // Back Button
                        Container(
                          margin: EdgeInsetsDirectional.only(
                              start: smallScreen(context) ? 15 : 20),
                          height: 50,
                          width: 50,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Icon(AppIcons.back,
                                  color:
                                      StateContainer.of(context).curTheme.text,
                                  size: 24)),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Column(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            AppIcons.lock,
                            size: 80,
                            color: StateContainer.of(context).curTheme.primary,
                          ),
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.1),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: smallScreen(context) ? 30 : 40,
                              vertical: 20),
                          child: AutoSizeText(
                            AppLocalization.of(context).enterPasswordText,
                            style: AppStyles.textStyleParagraph(context),
                            maxLines: 4,
                            stepGranularity: 0.5,
                          ),
                        ),
                        Expanded(
                            child: KeyboardAvoider(
                                duration: Duration(milliseconds: 0),
                                autoScroll: true,
                                focusPadding: 40,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      // Enter your password Text Field
                                      AppTextField(
                                        topMargin: 10,
                                        padding: EdgeInsetsDirectional.only(
                                            start: 16, end: 16),
                                        focusNode: enterPasswordFocusNode,
                                        controller: enterPasswordController,
                                        textInputAction: TextInputAction.go,
                                        autofocus: true,
                                        onChanged: (String newText) {
                                          if (passwordError != null) {
                                            setState(() {
                                              passwordError = null;
                                            });
                                          }
                                        },
                                        onSubmitted: (value) async {
                                          FocusScope.of(context).unfocus();
                                          await validateAndDecrypt();
                                        },
                                        hintText: AppLocalization.of(context)
                                            .enterPasswordHint,
                                        keyboardType: TextInputType.text,
                                        obscureText: true,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.0,
                                          color: StateContainer.of(context)
                                              .curTheme
                                              .primary,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      // Error Container
                                      Container(
                                        alignment: AlignmentDirectional(0, 0),
                                        margin: EdgeInsets.only(top: 3),
                                        child: Text(
                                            this.passwordError == null
                                                ? ""
                                                : this.passwordError,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .primary,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w600,
                                            )),
                                      ),
                                    ])))
                      ],
                    )),
                    Row(
                      children: <Widget>[
                        AppButton.buildAppButton(
                            context,
                            AppButtonType.PRIMARY,
                            AppLocalization.of(context).connectWallet,
                            Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () async {
                          await validateAndDecrypt();
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> validateAndDecrypt() async {
    try {
      String _seed =
          "05A2525C9C4FDDC02BA97554980A0CFFADA2AEB0650E3EAD05796275F05DDA85";
      await sl.get<Vault>().setSeed(_seed);
      await sl.get<DBHelper>().dropAccounts();
      await AppUtil().loginAccount(_seed, context);
      StateContainer.of(context).requestUpdate();
      String pin = await Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return PinScreen(
          PinOverlayType.NEW_PIN,
        );
      }));
      if (pin != null && pin.length > 5) {
        _pinEnteredCallback(pin);
      }
      /*String decryptedSeed = HEX.encode(AppCrypt.decrypt(
          await sl.get<Vault>().getSeed(), enterPasswordController.text));
      StateContainer.of(context).setEncryptedSecret(HEX.encode(AppCrypt.encrypt(
          decryptedSeed, await sl.get<Vault>().getSessionKey())));
      _goHome();*/
    } catch (e) {
      if (mounted) {
        setState(() {
          passwordError = AppLocalization.of(context).invalidPassword;
        });
      }
    }
  }

  void _pinEnteredCallback(String pin) async {
    await sl.get<Vault>().writePin(pin);
    PriceConversion conversion =
        await sl.get<SharedPrefsUtil>().getPriceConversion();
    // Update wallet
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/home', (Route<dynamic> route) => false,
        arguments: conversion);
  }
}
