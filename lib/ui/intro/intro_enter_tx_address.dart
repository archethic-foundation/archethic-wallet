// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

// Project imports:
import 'package:archethic_mobile_wallet/app_icons.dart';
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/dimens.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/db/appdb.dart';
import 'package:archethic_mobile_wallet/model/vault.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/util/particles/particles_flutter.dart';
import 'package:archethic_mobile_wallet/ui/util/ui_util.dart';
import 'package:archethic_mobile_wallet/ui/widgets/app_text_field.dart';
import 'package:archethic_mobile_wallet/ui/widgets/buttons.dart';
import 'package:archethic_mobile_wallet/ui/widgets/pin_screen.dart';
import 'package:archethic_mobile_wallet/ui/widgets/tap_outside_unfocus.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/apputil.dart';
import 'package:archethic_mobile_wallet/util/sharedprefsutil.dart';
import 'package:archethic_mobile_wallet/util/user_data_util.dart';

class IntroEnterTxAddress extends StatefulWidget {
  @override
  _IntroEnterTxAddressState createState() => _IntroEnterTxAddressState();
}

class _IntroEnterTxAddressState extends State<IntroEnterTxAddress> {
  FocusNode enterTxAddressFocusNode;
  TextEditingController enterTxAddressController;

  String passwordError;

  @override
  void initState() {
    super.initState();
    enterTxAddressFocusNode = FocusNode();
    enterTxAddressController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
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
              awayAnimationDuration: const Duration(milliseconds: 600),
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
                        SizedBox(height: 80),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: smallScreen(context) ? 30 : 40,
                              vertical: 20),
                          child: AutoSizeText(
                            AppLocalization.of(context).enterTxAddressText,
                            style: AppStyles.textStyleParagraph(context),
                            maxLines: 4,
                            stepGranularity: 0.5,
                          ),
                        ),
                        Expanded(
                            child: KeyboardAvoider(
                                duration: const Duration(milliseconds: 0),
                                autoScroll: true,
                                focusPadding: 40,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      AppTextField(
                                        padding: EdgeInsets.zero,
                                        focusNode: enterTxAddressFocusNode,
                                        controller: enterTxAddressController,
                                        style: AppStyles.textStyleAddressText60(
                                            context),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(255),
                                        ],
                                        textInputAction: TextInputAction.done,
                                        maxLines: null,
                                        autocorrect: false,
                                        hintText: AppLocalization.of(context)
                                            .enterTxAddressHint,
                                        prefixButton: TextFieldButton(
                                            icon: AppIcons.scan,
                                            onPressed: () async {
                                              UIUtil.cancelLockEvent();
                                              final String scanResult =
                                                  await UserDataUtil.getQRData(
                                                      DataType.ADDRESS,
                                                      context);
                                              if (!QRScanErrs.ERROR_LIST
                                                  .contains(scanResult)) {
                                                if (mounted) {
                                                  setState(() {
                                                    enterTxAddressController
                                                        .text = scanResult;
                                                  });
                                                  enterTxAddressFocusNode
                                                      .unfocus();
                                                }
                                              }
                                            }),
                                        fadePrefixOnCondition: true,
                                        prefixShowFirstCondition: true,
                                        suffixButton: TextFieldButton(
                                          icon: AppIcons.paste,
                                          onPressed: () async {
                                            final String data =
                                                await UserDataUtil
                                                    .getClipboardText(
                                                        DataType.ADDRESS);
                                            if (data != null) {
                                              setState(() {
                                                enterTxAddressController.text =
                                                    data;
                                              });
                                            } else {}
                                          },
                                        ),
                                        fadeSuffixOnCondition: true,
                                        suffixShowFirstCondition: true,
                                        onChanged: (String text) {},
                                      ),

                                      // Error Container
                                      Container(
                                        alignment:
                                            const AlignmentDirectional(0, 0),
                                        margin: const EdgeInsets.only(top: 3),
                                        child: Text(passwordError ?? '',
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
      String _seed = enterTxAddressController.text;
      await sl.get<Vault>().setSeed(_seed);
      await sl.get<DBHelper>().dropAccounts();
      await AppUtil().loginAccount(_seed, context);
      StateContainer.of(context).requestUpdate();
      final String pin = await Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return const PinScreen(
          PinOverlayType.NEW_PIN,
        );
      }));
      if (pin != null && pin.length > 5) {
        _pinEnteredCallback(pin);
      }
      /*String decryptedSeed = HEX.encode(AppCrypt.decrypt(
          await sl.get<Vault>().getSeed(), enterTxAddressController.text));
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

  Future<void> _pinEnteredCallback(String pin) async {
    await sl.get<Vault>().writePin(pin);
    final PriceConversion conversion =
        await sl.get<SharedPrefsUtil>().getPriceConversion();
    // Update wallet
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/home', (Route<dynamic> route) => false,
        arguments: conversion);
  }
}
