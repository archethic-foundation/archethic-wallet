/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:password_strength/password_strength.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/util/string_encryption.dart';
import 'package:aewallet/util/vault.dart';

class SetPassword extends StatefulWidget {
  final String? header;
  final String? description;
  final String? name;
  final String? seed;

  const SetPassword({
    super.key,
    this.header,
    this.description,
    this.name,
    this.seed,
  });
  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  FocusNode? setPasswordFocusNode;
  TextEditingController? setPasswordController;
  FocusNode? confirmPasswordFocusNode;
  TextEditingController? confirmPasswordController;
  bool? animationOpen;
  double passwordStrength = 0;

  String? passwordError;
  bool? passwordsMatch;
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
              StateContainer.of(context).curTheme.background1Small!,
            ),
            fit: BoxFit.fitHeight,
          ),
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
                top: MediaQuery.of(context).size.height * 0.075,
              ),
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
                                  Navigator.pop(context, false);
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: IconWidget.build(
                            context,
                            'assets/icons/password.png',
                            90,
                            90,
                          ),
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
                                        context,
                                      ),
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
                                          start: 20,
                                          end: 20,
                                          top: 15.0,
                                        ),
                                        child: Text(
                                          widget.description!,
                                          style: AppStyles
                                              .textStyleSize16W600Primary(
                                            context,
                                          ),
                                          textAlign: TextAlign.justify,
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
                                    passwordStrength = estimatePasswordStrength(
                                      setPasswordController!.text,
                                    );
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
                                      .createPasswordHint,
                                  keyboardType: TextInputType.text,
                                  obscureText: !setPasswordVisible!,
                                  textAlign: TextAlign.center,
                                  style: AppStyles.textStyleSize16W700Primary(
                                    context,
                                  ),
                                  onSubmitted: (text) {
                                    confirmPasswordFocusNode!.requestFocus();
                                  },
                                  prefixButton: TextFieldButton(
                                    icon: Icons.shuffle_sharp,
                                    onPressed: () {
                                      setPasswordController!.text = '';
                                      int passwordLength =
                                          Random().nextInt(8) + 5;

                                      String allowedChars =
                                          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#=+!£\$%&?[](){}';
                                      int i = 0;
                                      while (i < passwordLength.round()) {
                                        int random = Random.secure()
                                            .nextInt(allowedChars.length);
                                        setPasswordController!.text +=
                                            allowedChars[random];
                                        i++;
                                      }

                                      setState(() {
                                        setPasswordVisible = true;
                                        passwordStrength =
                                            estimatePasswordStrength(
                                          setPasswordController!.text,
                                        );
                                      });
                                    },
                                  ),
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
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: 10,
                                      right: MediaQuery.of(context).size.width *
                                          0.105,
                                    ),
                                    width: 150,
                                    child: Column(
                                      children: [
                                        LinearProgressIndicator(
                                          value: passwordStrength,
                                          backgroundColor: Colors.grey[300],
                                          color: passwordStrength <= 0.25
                                              ? Colors.red
                                              : passwordStrength <= 0.6
                                                  ? Colors.orange
                                                  : passwordStrength <= 0.8
                                                      ? Colors.yellow
                                                      : Colors.green,
                                          minHeight: 5,
                                        ),
                                        passwordStrength <= 0.25
                                            ? Text(
                                                AppLocalization.of(context)!
                                                    .passwordStrengthWeak,
                                                textAlign: TextAlign.end,
                                                style: AppStyles
                                                    .textStyleSize12W100Primary(
                                                  context,
                                                ),
                                              )
                                            : passwordStrength <= 0.8
                                                ? Text(
                                                    AppLocalization.of(context)!
                                                        .passwordStrengthAlright,
                                                    textAlign: TextAlign.end,
                                                    style: AppStyles
                                                        .textStyleSize12W100Primary(
                                                      context,
                                                    ),
                                                  )
                                                : Text(
                                                    AppLocalization.of(context)!
                                                        .passwordStrengthStrong,
                                                    textAlign: TextAlign.end,
                                                    style: AppStyles
                                                        .textStyleSize12W100Primary(
                                                      context,
                                                    ),
                                                  ),
                                      ],
                                    ),
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
                                    context,
                                  ),
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
                                    passwordError == null ? '' : passwordError!,
                                    style: AppStyles.textStyleSize14W600Primary(
                                      context,
                                    ),
                                  ),
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
                            AppButtonType.primary,
                            AppLocalization.of(context)!.confirm,
                            Dimens.buttonTopDimens,
                            onPressed: () async {
                              await _validateRequest();
                            },
                          ),
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
      Vault vault = await Vault.getInstance();
      vault.setPassword(
        stringEncryptBase64(setPasswordController!.text, widget.seed),
      );
      Navigator.of(context).pop(true);
    }
  }
}
