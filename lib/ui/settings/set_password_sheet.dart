// @dart=2.9

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:uniris_lib_dart/utils.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/dimens.dart';
import 'package:uniris_mobile_wallet/localization.dart';
import 'package:uniris_mobile_wallet/model/vault.dart';
import 'package:uniris_mobile_wallet/service_locator.dart';
import 'package:uniris_mobile_wallet/styles.dart';
import 'package:uniris_mobile_wallet/ui/util/ui_util.dart';
import 'package:uniris_mobile_wallet/ui/widgets/app_text_field.dart';
import 'package:uniris_mobile_wallet/ui/widgets/buttons.dart';
import 'package:uniris_mobile_wallet/ui/widgets/tap_outside_unfocus.dart';
import 'package:uniris_mobile_wallet/util/app_ffi/encrypt/crypter.dart';
import 'package:uniris_mobile_wallet/util/app_ffi/keys/seeds.dart';

class SetPasswordSheet extends StatefulWidget {
  @override
  _SetPasswordSheetState createState() => _SetPasswordSheetState();
}

class _SetPasswordSheetState extends State<SetPasswordSheet> {
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
    return TapOutsideUnfocus(
        child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            // Sheet handle
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 5,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.text10,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            // The main widget that holds the header, text fields, and submit button
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // The header
                  Container(
                    margin: const EdgeInsetsDirectional.only(
                        top: 10, start: 60, end: 60),
                    child: Column(
                      children: <Widget>[
                        AutoSizeText(
                          AppLocalization.of(context).createPasswordSheetHeader,
                          style: AppStyles.textStyleHeader(context),
                          minFontSize: 12,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ],
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
                      style: AppStyles.textStyleParagraph(context),
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0,
                                    color: passwordsMatch
                                        ? StateContainer.of(context)
                                            .curTheme
                                            .primary
                                        : StateContainer.of(context)
                                            .curTheme
                                            .text,
                                    fontFamily: 'Montserrat',
                                  ),
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0,
                                    color: passwordsMatch
                                        ? StateContainer.of(context)
                                            .curTheme
                                            .primary
                                        : StateContainer.of(context)
                                            .curTheme
                                            .text,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                // Error Text
                                Container(
                                  alignment: const AlignmentDirectional(0, 0),
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
              ),
            ),

            // Set Password Button
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AppButton.buildAppButton(
                          context,
                          AppButtonType.PRIMARY,
                          AppLocalization.of(context).setPassword,
                          Dimens.BUTTON_TOP_DIMENS, onPressed: () async {
                        await submitAndEncrypt();
                      }),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      AppButton.buildAppButton(
                          context,
                          AppButtonType.PRIMARY,
                          AppLocalization.of(context).close,
                          Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                        Navigator.pop(context);
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> submitAndEncrypt() async {
    final String seed = await sl.get<Vault>().getSeed();
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
    } else if (seed == null || !AppSeeds.isValidSeed(seed)) {
      Navigator.pop(context);
      UIUtil.showSnackbar(
          AppLocalization.of(context).encryptionFailedError, context);
    } else {
      final String encryptedSeed = uint8ListToHex(
          AppCrypt.encrypt(seed, confirmPasswordController.text));
      await sl.get<Vault>().setSeed(encryptedSeed);
      StateContainer.of(context).setEncryptedSecret(uint8ListToHex(
          AppCrypt.encrypt(seed, await sl.get<Vault>().getSessionKey())));
      UIUtil.showSnackbar(
          AppLocalization.of(context).setPasswordSuccess, context);
      Navigator.pop(context);
    }
  }
}
