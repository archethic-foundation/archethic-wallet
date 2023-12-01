/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:math';

import 'package:aewallet/infrastructure/datasources/hive_vault.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/util/string_encryption.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:password_strength/password_strength.dart';

class SetPassword extends ConsumerStatefulWidget {
  const SetPassword({
    super.key,
    this.header,
    this.description,
    this.seed,
  });
  final String? header;
  final String? description;
  final String? seed;
  @override
  ConsumerState<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends ConsumerState<SetPassword> {
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
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ArchethicTheme.backgroundSmall,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              ArchethicTheme.backgroundDark,
              ArchethicTheme.background,
            ],
          ),
        ),
        child: TapOutsideUnfocus(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                SafeArea(
              minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
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
                                color: ArchethicTheme.text,
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.header != null)
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(
                                      start: 20,
                                      end: 20,
                                      top: 10,
                                    ),
                                    alignment: AlignmentDirectional.centerStart,
                                    child: AutoSizeText(
                                      widget.header!,
                                      style: ArchethicThemeStyles
                                          .textStyleSize24W700Primary,
                                    ),
                                  ),

                                AppTextField(
                                  topMargin: 30,
                                  cursorColor: ArchethicTheme.text,
                                  focusNode: setPasswordFocusNode,
                                  controller: setPasswordController,
                                  textInputAction: TextInputAction.next,
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
                                  labelText: localizations.createPasswordHint,
                                  keyboardType: TextInputType.text,
                                  obscureText: !setPasswordVisible!,
                                  style: ArchethicThemeStyles
                                      .textStyleSize16W700Primary,
                                  onSubmitted: (text) {
                                    confirmPasswordFocusNode!.requestFocus();
                                  },
                                  prefixButton: TextFieldButton(
                                    icon: Symbols.shuffle,
                                    onPressed: () {
                                      setPasswordController!.text = '';
                                      final passwordLength =
                                          Random().nextInt(8) + 5;

                                      const allowedChars =
                                          r'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#=+!£$%&?[](){}';
                                      var i = 0;
                                      while (i < passwordLength) {
                                        final random = Random.secure()
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
                                        ? Symbols.visibility
                                        : Symbols.visibility_off,
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: LinearProgressIndicator(
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
                                        ),
                                        if (passwordStrength <= 0.25)
                                          Text(
                                            localizations.passwordStrengthWeak,
                                            textAlign: TextAlign.end,
                                            style: ArchethicThemeStyles
                                                .textStyleSize12W100Primary,
                                          )
                                        else
                                          passwordStrength <= 0.8
                                              ? Text(
                                                  localizations
                                                      .passwordStrengthAlright,
                                                  textAlign: TextAlign.end,
                                                  style: ArchethicThemeStyles
                                                      .textStyleSize12W100Primary,
                                                )
                                              : Text(
                                                  localizations
                                                      .passwordStrengthStrong,
                                                  textAlign: TextAlign.end,
                                                  style: ArchethicThemeStyles
                                                      .textStyleSize12W100Primary,
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
                                  labelText: localizations.confirmPasswordHint,
                                  keyboardType: TextInputType.text,
                                  obscureText: !confirmPasswordVisible!,
                                  style: ArchethicThemeStyles
                                      .textStyleSize16W700Primary,
                                  suffixButton: TextFieldButton(
                                    icon: confirmPasswordVisible!
                                        ? Symbols.visibility
                                        : Symbols.visibility_off,
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
                                  alignment: AlignmentDirectional.center,
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    passwordError == null ? '' : passwordError!,
                                    style: ArchethicThemeStyles
                                        .textStyleSize14W600Primary,
                                  ),
                                ),

                                if (widget.description != null)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                          start: 20,
                                          end: 20,
                                          top: 15,
                                        ),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Icon(
                                                Symbols.info,
                                                color: ArchethicTheme.text,
                                                size: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              widget.description!,
                                              style: ArchethicThemeStyles
                                                  .textStyleSize12W100Primary,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
                          AppButtonTiny(
                            AppButtonTinyType.primary,
                            localizations.confirm,
                            Dimens.buttonTopDimens,
                            key: const Key('confirm'),
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
          passwordError = AppLocalizations.of(context)!.passwordBlank;
        });
      }
    } else if (setPasswordController!.text != confirmPasswordController!.text) {
      if (mounted) {
        setState(() {
          passwordError = AppLocalizations.of(context)!.passwordsDontMatch;
        });
      }
    } else {
      final vault = await HiveVaultDatasource.getInstance();
      vault.setPassword(
        stringEncryptBase64(setPasswordController!.text, widget.seed),
      );
      Navigator.of(context).pop(true);
    }
  }
}
