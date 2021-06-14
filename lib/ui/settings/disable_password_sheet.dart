// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get_it/get_it.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:uniris_lib_dart/utils.dart';

// Project imports:
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
import 'package:uniris_mobile_wallet/util/caseconverter.dart';

class DisablePasswordSheet extends StatefulWidget {
  @override
  _DisablePasswordSheetState createState() => _DisablePasswordSheetState();
}

class _DisablePasswordSheetState extends State<DisablePasswordSheet> {
  FocusNode passwordFocusNode;
  TextEditingController passwordController;

  String passwordError;

  @override
  void initState() {
    super.initState();
    passwordFocusNode = FocusNode();
    passwordController = TextEditingController();
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
                          CaseChange.toUpperCase(
                              AppLocalization.of(context)
                                  .disablePasswordSheetHeader,
                              context),
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
                          .passwordNoLongerRequiredToOpenParagraph,
                      style: AppStyles.textStyleParagraph(context),
                      maxLines: 5,
                      stepGranularity: 0.5,
                    ),
                  ),
                  // Text field
                  Expanded(
                      child: KeyboardAvoider(
                          duration: const Duration(milliseconds: 0),
                          autoScroll: true,
                          focusPadding: 40,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                AppTextField(
                                  topMargin: 30,
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 16, end: 16),
                                  focusNode: passwordFocusNode,
                                  controller: passwordController,
                                  textInputAction: TextInputAction.done,
                                  maxLines: 1,
                                  autocorrect: false,
                                  onChanged: (String newText) {
                                    if (passwordError != null) {
                                      setState(() {
                                        passwordError = null;
                                      });
                                    }
                                  },
                                  hintText: AppLocalization.of(context)
                                      .enterPasswordHint,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0,
                                    color: StateContainer.of(context)
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
                          AppLocalization.of(context)
                              .disablePasswordSheetHeader,
                          Dimens.BUTTON_TOP_DIMENS, onPressed: () async {
                        await submitAndDecrypt();
                      }),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      AppButton.buildAppButton(
                          context,
                          AppButtonType.PRIMARY_OUTLINE,
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

  Future<void> submitAndDecrypt() async {
    final String encryptedSeed = await sl.get<Vault>().getSeed();
    if (passwordController.text.isEmpty) {
      if (mounted) {
        setState(() {
          passwordError = AppLocalization.of(context).passwordBlank;
        });
      }
    } else {
      try {
        final String decryptedSeed = uint8ListToHex(
            AppCrypt.decrypt(encryptedSeed, passwordController.text));
        throwIf(!AppSeeds.isValidSeed(decryptedSeed), const FormatException());
        await sl.get<Vault>().setSeed(decryptedSeed);
        StateContainer.of(context).resetEncryptedSecret();
        UIUtil.showSnackbar(
            AppLocalization.of(context).disablePasswordSuccess, context);
        Navigator.pop(context);
      } catch (e) {
        if (mounted) {
          setState(() {
            passwordError = AppLocalization.of(context).invalidPassword;
          });
        }
      }
    }
  }
}
