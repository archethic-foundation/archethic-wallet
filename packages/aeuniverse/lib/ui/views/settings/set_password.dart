/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/authentication_method.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/model/device_lock_timeout.dart';
import 'package:core/model/primary_currency.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:aeuniverse/util/keychain_util.dart';
import 'package:core/util/password_util.dart';
import 'package:core/util/string_encryption.dart';
import 'package:core/util/vault.dart';
import 'package:core_ui/ui/util/dimens.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aeuniverse/util/preferences.dart';

class SetPassword extends StatefulWidget {
  final String? header;
  final String? description;
  final String? name;
  final String? seed;
  final String? process;
  final bool initPreferences;

  const SetPassword(
      {super.key,
      this.header,
      this.description,
      this.initPreferences = false,
      this.name,
      this.seed,
      this.process});
  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  FocusNode? setPasswordFocusNode;
  TextEditingController? setPasswordController;
  FocusNode? confirmPasswordFocusNode;
  TextEditingController? confirmPasswordController;
  bool? animationOpen;

  String? passwordError;
  bool? passwordsMatch;
  bool? isPasswordCompromised;
  bool? setPasswordVisible;
  bool? confirmPasswordVisible;

  @override
  void initState() {
    super.initState();
    setPasswordVisible = false;
    confirmPasswordVisible = false;
    passwordsMatch = false;
    setPasswordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    setPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    animationOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  StateContainer.of(context).curTheme.background1Small!),
              fit: BoxFit.fitHeight),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              StateContainer.of(context).curTheme.backgroundDark!,
              StateContainer.of(context).curTheme.background!
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin:
                                  const EdgeInsetsDirectional.only(start: 15),
                              height: 50,
                              width: 50,
                              child: BackButton(
                                key: const Key('back'),
                                color: StateContainer.of(context).curTheme.text,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: buildIconWidget(
                              context,
                              'packages/aeuniverse/assets/icons/password.png',
                              90,
                              90),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.header != null)
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(
                                      start: 20,
                                      end: 20,
                                      top: 10,
                                    ),
                                    alignment:
                                        const AlignmentDirectional(-1, 0),
                                    child: AutoSizeText(
                                      widget.header!,
                                      style:
                                          AppStyles.textStyleSize20W700Warning(
                                              context),
                                    ),
                                  ),
                                if (widget.description != null)
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, end: 20, top: 15.0),
                                        child: Text(
                                          widget.description!,
                                          style: AppStyles
                                              .textStyleSize16W600Primary(
                                                  context),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, end: 20, top: 15),
                                        child: Text(
                                          AppLocalization.of(context)!
                                              .setPasswordDescription,
                                          style: AppStyles
                                              .textStyleSize16W400Primary(
                                                  context),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, end: 20),
                                        child: Text(
                                          AppLocalization.of(context)!
                                              .passwordAtLeast
                                              .replaceAll('%1', '7'),
                                          style: PasswordUtil.hasMinLength(
                                                  setPasswordController!.text,
                                                  7)
                                              ? AppStyles
                                                  .textStyleSize16W400PrimarySuccess(
                                                      context)
                                              : AppStyles
                                                  .textStyleSize16W400Primary(
                                                      context),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, end: 20),
                                        child: Text(
                                          AppLocalization.of(context)!
                                              .passwordNormalLetters
                                              .replaceAll('%1', '1'),
                                          style: PasswordUtil.hasMinNormalChar(
                                                  setPasswordController!.text,
                                                  1)
                                              ? AppStyles
                                                  .textStyleSize16W400PrimarySuccess(
                                                      context)
                                              : AppStyles
                                                  .textStyleSize16W400Primary(
                                                      context),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, end: 20),
                                        child: Text(
                                          AppLocalization.of(context)!
                                              .passwordNumericCharacters
                                              .replaceAll('%1', '1'),
                                          style: PasswordUtil.hasMinNumericChar(
                                                  setPasswordController!.text,
                                                  1)
                                              ? AppStyles
                                                  .textStyleSize16W400PrimarySuccess(
                                                      context)
                                              : AppStyles
                                                  .textStyleSize16W400Primary(
                                                      context),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, end: 20),
                                        child: Text(
                                          AppLocalization.of(context)!
                                              .passwordSpecialCharacters
                                              .replaceAll('%1', '1'),
                                          style: PasswordUtil.hasMinSpecialChar(
                                                  setPasswordController!.text,
                                                  1)
                                              ? AppStyles
                                                  .textStyleSize16W400PrimarySuccess(
                                                      context)
                                              : AppStyles
                                                  .textStyleSize16W400Primary(
                                                      context),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, end: 20),
                                        child: Text(
                                          AppLocalization.of(context)!
                                              .passwordBreachDatabase,
                                          style: isPasswordCompromised !=
                                                      null &&
                                                  isPasswordCompromised! ==
                                                      false
                                              ? AppStyles
                                                  .textStyleSize16W400PrimarySuccess(
                                                      context)
                                              : AppStyles
                                                  .textStyleSize16W400Primary(
                                                      context),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                AppTextField(
                                  topMargin: 30,
                                  cursorColor:
                                      StateContainer.of(context).curTheme.text,
                                  focusNode: setPasswordFocusNode,
                                  controller: setPasswordController,
                                  textInputAction: TextInputAction.next,
                                  maxLines: 1,
                                  autocorrect: false,
                                  onChanged: (String newText) async {
                                    if (passwordError != null) {
                                      setState(() {
                                        passwordError = null;
                                      });
                                    }
                                    if (newText.length >= 7) {
                                      isPasswordCompromised = await PasswordUtil
                                          .isPasswordCompromised(
                                              setPasswordController!.text);
                                    } else {
                                      isPasswordCompromised = null;
                                    }

                                    if (confirmPasswordController!.text ==
                                        setPasswordController!.text) {
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
                                  labelText: AppLocalization.of(context)!
                                      .createPasswordHint,
                                  keyboardType: TextInputType.text,
                                  obscureText: !setPasswordVisible!,
                                  textAlign: TextAlign.center,
                                  style: AppStyles.textStyleSize16W700Primary(
                                      context),
                                  onSubmitted: (text) {
                                    confirmPasswordFocusNode!.requestFocus();
                                  },
                                  suffixButton: TextFieldButton(
                                    icon: setPasswordVisible!
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    onPressed: () {
                                      setState(() {
                                        setPasswordVisible =
                                            !setPasswordVisible!;
                                      });
                                    },
                                  ),
                                ),
                                AppTextField(
                                  topMargin: 20,
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
                                    if (confirmPasswordController!.text ==
                                        setPasswordController!.text) {
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
                                  labelText: AppLocalization.of(context)!
                                      .confirmPasswordHint,
                                  keyboardType: TextInputType.text,
                                  obscureText: !confirmPasswordVisible!,
                                  textAlign: TextAlign.center,
                                  style: AppStyles.textStyleSize16W700Primary(
                                      context),
                                  suffixButton: TextFieldButton(
                                    icon: confirmPasswordVisible!
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    onPressed: () {
                                      setState(() {
                                        confirmPasswordVisible =
                                            !confirmPasswordVisible!;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // Error Text
                                Container(
                                  alignment: const AlignmentDirectional(0, 0),
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text(
                                      passwordError == null
                                          ? ''
                                          : passwordError!,
                                      style:
                                          AppStyles.textStyleSize14W600Primary(
                                              context)),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          AppButton.buildAppButton(
                              const Key('confirm'),
                              context,
                              PasswordUtil.hasMinLength(
                                              setPasswordController!.text, 1) ==
                                          true &&
                                      PasswordUtil.hasMinNormalChar(
                                              setPasswordController!.text, 1) ==
                                          true &&
                                      PasswordUtil.hasMinNumericChar(
                                              setPasswordController!.text, 1) ==
                                          true &&
                                      PasswordUtil.hasMinSpecialChar(
                                              setPasswordController!.text, 1) ==
                                          true
                                  ? AppButtonType.primary
                                  : AppButtonType.primaryOutline,
                              AppLocalization.of(context)!.confirm,
                              Dimens.buttonTopDimens, onPressed: () async {
                            if (PasswordUtil.hasMinLength(
                                        setPasswordController!.text, 1) ==
                                    true &&
                                PasswordUtil.hasMinNormalChar(
                                        setPasswordController!.text, 1) ==
                                    true &&
                                PasswordUtil.hasMinNumericChar(
                                        setPasswordController!.text, 1) ==
                                    true &&
                                PasswordUtil.hasMinSpecialChar(
                                        setPasswordController!.text, 1) ==
                                    true) {
                              await _validateRequest();
                            }
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
      ),
    );
  }

  Future<void> _validateRequest() async {
    if (setPasswordController!.text.isEmpty ||
        confirmPasswordController!.text.isEmpty) {
      if (mounted) {
        setState(() {
          passwordError = AppLocalization.of(context)!.passwordBlank;
        });
      }
    } else if (setPasswordController!.text != confirmPasswordController!.text) {
      if (mounted) {
        setState(() {
          passwordError = AppLocalization.of(context)!.passwordsDontMatch;
        });
      }
    } else {
      _showSendingAnimation(context);
      Vault vault = await Vault.getInstance();
      vault.setPassword(
          stringEncryptBase64(setPasswordController!.text, widget.seed));
      final Preferences preferences = await Preferences.getInstance();
      preferences.setAuthMethod(AuthenticationMethod(AuthMethod.password));
      if (widget.initPreferences == true) {
        preferences.setLock(true);
        preferences.setShowBalances(true);
        preferences.setShowBlog(true);
        preferences.setActiveVibrations(true);
        if (!kIsWeb &&
            (Platform.isIOS == true ||
                Platform.isAndroid == true ||
                Platform.isMacOS == true)) {
          preferences.setActiveNotifications(true);
        } else {
          preferences.setActiveNotifications(false);
        }
        preferences.setPinPadShuffle(false);
        preferences.setShowPriceChart(true);
        preferences.setPrimaryCurrency(
            PrimaryCurrencySetting(AvailablePrimaryCurrency.NATIVE));
        preferences.setLockTimeout(LockTimeoutSetting(LockTimeoutOption.one));
        if (widget.process == 'newWallet') {
          await sl.get<DBHelper>().clearAppWallet();
          final Vault vault = await Vault.getInstance();
          await vault.setSeed(widget.seed!);
          StateContainer.of(context).appWallet =
              await KeychainUtil().newAppWallet(widget.seed!, widget.name!);
          await StateContainer.of(context).requestUpdate();
        }

        StateContainer.of(context).checkTransactionInputs(
            AppLocalization.of(context)!.transactionInputNotification);
      }
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/home',
        (Route<dynamic> route) => false,
      );
    }
  }

  void _showSendingAnimation(BuildContext context) {
    animationOpen = true;
    Navigator.of(context).push(AnimationLoadingOverlay(
        AnimationType.send,
        StateContainer.of(context).curTheme.animationOverlayStrong!,
        StateContainer.of(context).curTheme.animationOverlayMedium!,
        onPoppedCallback: () => animationOpen = false,
        title: AppLocalization.of(context)!.appWalletInitInProgress));
  }
}
