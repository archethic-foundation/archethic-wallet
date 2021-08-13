// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show uint8ListToHex;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/dimens.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/data/appdb.dart';
import 'package:archethic_mobile_wallet/model/vault.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/widgets/app_text_field.dart';
import 'package:archethic_mobile_wallet/ui/widgets/buttons.dart';
import 'package:archethic_mobile_wallet/ui/widgets/pin_screen.dart';
import 'package:archethic_mobile_wallet/ui/widgets/tap_outside_unfocus.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/apputil.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/encrypt/crypter.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/keys/seeds.dart';

class IntroPassword extends StatefulWidget {
  const IntroPassword({this.seed});

  final String seed;

  @override
  _IntroPasswordState createState() => _IntroPasswordState();
}

class _IntroPasswordState extends State<IntroPassword> {
  FocusNode createPasswordFocusNode;
  TextEditingController createPasswordController;
  FocusNode confirmPasswordFocusNode;
  TextEditingController confirmPasswordController;

  String passwordError;

  bool passwordsMatch;

  @override
  void initState() {
    super.initState();
    passwordsMatch = false;
    createPasswordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    createPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
        child: TapOutsideUnfocus(
            child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
                top: MediaQuery.of(context).size.height * 0.075),
            child: Column(
              children: <Widget>[
                //A widget that holds the header, the paragraph and Back Button
                Expanded(
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
                                child: FaIcon(FontAwesomeIcons.chevronLeft,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .primary,
                                    size: 24)),
                          ),
                        ],
                      ),
                      // The header
                      Container(
                        margin: EdgeInsetsDirectional.only(
                          start: smallScreen(context) ? 30 : 40,
                          end: smallScreen(context) ? 30 : 40,
                          top: 10,
                        ),
                        alignment: const AlignmentDirectional(-1, 0),
                        child: AutoSizeText(
                          AppLocalization.of(context).createAPasswordHeader,
                          maxLines: 3,
                          stepGranularity: 0.5,
                          style: AppStyles.textStyleSize28W700Primary(context),
                        ),
                      ),
                      // The paragraph
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            start: smallScreen(context) ? 30 : 40,
                            end: smallScreen(context) ? 30 : 40,
                            top: 16.0),
                        child: AutoSizeText(
                          AppLocalization.of(context)
                              .passwordWillBeRequiredToOpenParagraph,
                          style: AppStyles.textStyleSize16W200Primary(context),
                          maxLines: 5,
                          stepGranularity: 0.5,
                        ),
                      ),
                      Expanded(
                          child: KeyboardAvoider(
                              duration: const Duration(milliseconds: 0),
                              autoScroll: true,
                              focusPadding: 40,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    // Create a Password Text Field
                                    AppTextField(
                                      topMargin: 30,
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 16, end: 16),
                                      focusNode: createPasswordFocusNode,
                                      controller: createPasswordController,
                                      textInputAction: TextInputAction.next,
                                      maxLines: 1,
                                      autocorrect: false,
                                      onChanged: (String newText) {
                                        if (passwordError != null) {
                                          setState(() {
                                            passwordError = null;
                                          });
                                        }
                                        if (confirmPasswordController.text ==
                                            createPasswordController.text) {
                                          if (mounted) {
                                            setState(() {
                                              passwordsMatch = true;
                                            });
                                          }
                                        } else {
                                          if (mounted) {
                                            setState(() {
                                              passwordsMatch = false;
                                            });
                                          }
                                        }
                                      },
                                      hintText: AppLocalization.of(context)
                                          .createPasswordHint,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      textAlign: TextAlign.center,
                                      style:
                                          AppStyles.textStyleSize16W700Primary(
                                              context),
                                      onSubmitted: (String text) {
                                        confirmPasswordFocusNode.requestFocus();
                                      },
                                    ),
                                    // Confirm Password Text Field
                                    AppTextField(
                                      topMargin: 20,
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 16, end: 16),
                                      focusNode: confirmPasswordFocusNode,
                                      controller: confirmPasswordController,
                                      textInputAction: TextInputAction.done,
                                      maxLines: 1,
                                      autocorrect: false,
                                      onChanged: (String newText) {
                                        if (passwordError != null) {
                                          setState(() {
                                            passwordError = null;
                                          });
                                        }
                                        if (confirmPasswordController.text ==
                                            createPasswordController.text) {
                                          if (mounted) {
                                            setState(() {
                                              passwordsMatch = true;
                                            });
                                          }
                                        } else {
                                          if (mounted) {
                                            setState(() {
                                              passwordsMatch = false;
                                            });
                                          }
                                        }
                                      },
                                      hintText: AppLocalization.of(context)
                                          .confirmPasswordHint,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      textAlign: TextAlign.center,
                                      style:
                                          AppStyles.textStyleSize16W700Primary(
                                              context),
                                    ),
                                    // Error Text
                                    Container(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      margin: const EdgeInsets.only(top: 3),
                                      child: Text(passwordError ?? '',
                                          style: AppStyles
                                              .textStyleSize14W600Primary(
                                                  context)),
                                    ),
                                  ])))
                    ],
                  ),
                ),

                //A column with "Next" and "Go Back" buttons
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // Next Button
                        AppButton.buildAppButton(
                            context,
                            AppButtonType.PRIMARY,
                            AppLocalization.of(context).nextButton,
                            Dimens.BUTTON_TOP_DIMENS, onPressed: () async {
                          await submitAndEncrypt();
                        }),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        // Go Back Button
                        AppButton.buildAppButton(
                            context,
                            AppButtonType.PRIMARY,
                            AppLocalization.of(context).goBackButton,
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
        )),
      ),
    );
  }

  Future<void> submitAndEncrypt() async {
    if (createPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      if (mounted) {
        setState(() {
          passwordError = AppLocalization.of(context).passwordBlank;
        });
      }
    } else if (createPasswordController.text !=
        confirmPasswordController.text) {
      if (mounted) {
        setState(() {
          passwordError = AppLocalization.of(context).passwordsDontMatch;
        });
      }
    } else if (widget.seed != null) {
      final String encryptedSeed = uint8ListToHex(
          AppCrypt.encrypt(widget.seed, confirmPasswordController.text));
      await sl.get<Vault>().setSeed(encryptedSeed);
      StateContainer.of(context).setEncryptedSecret(uint8ListToHex(
          AppCrypt.encrypt(
              widget.seed, await sl.get<Vault>().getSessionKey())));
      await sl.get<DBHelper>().dropAccounts();
      await AppUtil().loginAccount(widget.seed, context);
      StateContainer.of(context)
          .requestUpdate(StateContainer.of(context).selectedAccount);
      final String pin = await Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return const PinScreen(PinOverlayType.NEW_PIN);
      }));
      if (pin != null && pin.length > 5) {
        _pinEnteredCallback(pin);
      }
    } else {
      // Generate a seed and encrypt
      final String seed = AppSeeds.generateSeed();
      final String encryptedSeed = uint8ListToHex(
          AppCrypt.encrypt(seed, confirmPasswordController.text));
      await sl.get<Vault>().setSeed(encryptedSeed);
      // Also encrypt it with the session key, so user doesnt need password to sign blocks within the app
      StateContainer.of(context).setEncryptedSecret(uint8ListToHex(
          AppCrypt.encrypt(seed, await sl.get<Vault>().getSessionKey())));
      // Update wallet
      AppUtil()
          .loginAccount(await StateContainer.of(context).getSeed(), context)
          .then((_) {
        StateContainer.of(context)
            .requestUpdate(StateContainer.of(context).selectedAccount);
        Navigator.of(context).pushNamed('/intro_backup_safety');
      });
    }
  }

  Future<void> _pinEnteredCallback(String pin) async {
    await sl.get<Vault>().writePin(pin);
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/home',
      (Route<dynamic> route) => false,
    );
  }
}
