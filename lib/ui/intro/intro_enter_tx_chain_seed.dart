// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show AddressService;
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

class IntroEnterTxChainSeed extends StatefulWidget {
  @override
  _IntroEnterTxChainSeedState createState() => _IntroEnterTxChainSeedState();
}

class _IntroEnterTxChainSeedState extends State<IntroEnterTxChainSeed> {
  FocusNode enterTxChainSeedFocusNode;
  TextEditingController enterTxChainSeedController;
  FocusNode enterEndpointFocusNode;
  TextEditingController enterEndpointController;
  bool useCustomEndpoint;

  String enterEndpointHint = '';
  String enterEndpointValidationText = '';

  Future<void> initControllerText() async {
    enterEndpointController.text =
        await sl.get<SharedPrefsUtil>().getEndpoint();
    enterTxChainSeedController.text =
        'testnet';
  }

  @override
  void initState() {
    super.initState();
    enterTxChainSeedFocusNode = FocusNode();
    enterTxChainSeedController = TextEditingController();
    enterEndpointFocusNode = FocusNode();
    enterEndpointController = TextEditingController();

    initControllerText();
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
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary,
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
                            AppLocalization.of(context).enterTxChainSeedText,
                            style:
                                AppStyles.textStyleMediumW200Primary(context),
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
                                        focusNode: enterTxChainSeedFocusNode,
                                        controller: enterTxChainSeedController,
                                        style:
                                            AppStyles.textStyleSmallW100Text60(
                                                context),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(255),
                                        ],
                                        textInputAction: TextInputAction.done,
                                        maxLines: null,
                                        autocorrect: false,
                                        hintText: AppLocalization.of(context)
                                            .enterTxChainSeedHint,
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
                                                    enterTxChainSeedController
                                                        .text = scanResult;
                                                  });
                                                  enterTxChainSeedFocusNode
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
                                                enterTxChainSeedController
                                                    .text = data;
                                              });
                                            } else {}
                                          },
                                        ),
                                        fadeSuffixOnCondition: true,
                                        suffixShowFirstCondition: true,
                                        onChanged: (String text) {},
                                      ),
                                    ]))),
                        Expanded(
                            child: KeyboardAvoider(
                          duration: const Duration(milliseconds: 0),
                          autoScroll: true,
                          focusPadding: 40,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalization.of(context).enterEndpoint,
                                    style: AppStyles.textStyleMediumW200Primary(
                                        context),
                                  ),
                                ],
                              ),
                              AppTextField(
                                padding: EdgeInsets.zero,
                                focusNode: enterEndpointFocusNode,
                                controller: enterEndpointController,
                                cursorColor:
                                    StateContainer.of(context).curTheme.primary,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  fontFamily: 'Montserrat',
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(150)
                                ],
                                onChanged: (String text) {
                                  setState(() {
                                    enterEndpointValidationText = '';
                                  });
                                },
                                textInputAction: TextInputAction.next,
                                maxLines: null,
                                autocorrect: false,
                                hintText: enterEndpointHint == null
                                    ? ''
                                    : AppLocalization.of(context).enterEndpoint,
                                keyboardType: TextInputType.multiline,
                                textAlign: TextAlign.left,
                                onSubmitted: (String text) {
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                            ],
                          ),
                        )),
                      ],
                    )),
                    Row(
                      children: <Widget>[
                        AppButton.buildAppButton(
                            context,
                            AppButtonType.PRIMARY,
                            AppLocalization.of(context).connectWallet,
                            Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () async {
                          await validate();
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

  Future<void> validate() async {
    try {
      await sl.get<SharedPrefsUtil>().setEndpoint(enterEndpointController.text);
      await setupServiceLocator();

      final String genesisAddress =
          sl.get<AddressService>().deriveAddress(enterTxChainSeedController.text, 0);
      String _seed = enterTxChainSeedController.text;
      await sl.get<Vault>().setSeed(_seed);
      await sl.get<DBHelper>().dropAccounts();

      await AppUtil().loginAccount(genesisAddress, context);
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
    } catch (e) {
      print(e);
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
