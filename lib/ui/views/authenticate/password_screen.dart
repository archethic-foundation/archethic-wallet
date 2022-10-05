/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:aewallet/util/string_encryption.dart';
import 'package:aewallet/util/vault.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
// Flutter imports:
import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  static const int maxAttempts = 5;
  int _failedAttempts = 0;

  FocusNode? enterPasswordFocusNode;
  TextEditingController? enterPasswordController;

  String? passwordError;
  bool? enterPasswordVisible;

  @override
  void initState() {
    super.initState();
    enterPasswordVisible = false;
    enterPasswordFocusNode = FocusNode();
    enterPasswordController = TextEditingController();

    Preferences.getInstance().then((Preferences preferences) {
      setState(() {
        // Get adjusted failed attempts
        _failedAttempts = preferences.getLockAttempts() % maxAttempts;
      });
    });
  }

  Future<void> _verifyPassword() async {
    final vault = await Vault.getInstance();
    final preferences = await Preferences.getInstance();

    if (enterPasswordController!.text ==
        stringDecryptBase64(
          vault.getPassword()!,
          await StateContainer.of(context).getSeed(),
        )) {
      preferences.resetLockAttempts();
      Navigator.of(context).pop(true);
    } else {
      enterPasswordController!.text = '';
      preferences.incrementLockAttempts();
      _failedAttempts++;
      if (_failedAttempts >= maxAttempts) {
        preferences.updateLockDate();
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/lock_screen_transition',
          (Route<dynamic> route) => false,
        );
      }

      if (mounted) {
        setState(() {
          passwordError = AppLocalization.of(context)!.invalidPassword;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              theme.background5Small!,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[theme.backgroundDark!, theme.background!],
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.06,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsetsDirectional.only(start: 15),
                          height: 50,
                          width: 50,
                          child: BackButton(
                            key: const Key('back'),
                            color: theme.text,
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      child: Text(
                        localizations.passwordMethod,
                        style: AppStyles.textStyleSize24W700EquinoxPrimary(
                          context,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    AppTextField(
                      topMargin: 30,
                      padding: const EdgeInsetsDirectional.only(
                        start: 16,
                        end: 16,
                      ),
                      focusNode: enterPasswordFocusNode,
                      controller: enterPasswordController,
                      textInputAction: TextInputAction.go,
                      autocorrect: false,
                      autofocus: true,
                      onChanged: (String newText) {
                        setState(() {
                          if (passwordError != null) {
                            passwordError = null;
                          }
                        });
                      },
                      onSubmitted: (value) async {
                        FocusScope.of(context).unfocus();
                      },
                      labelText: localizations.enterPasswordHint,
                      keyboardType: TextInputType.text,
                      obscureText: !enterPasswordVisible!,
                      style: AppStyles.textStyleSize16W700Primary(context),
                      suffixButton: TextFieldButton(
                        icon: enterPasswordVisible!
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onPressed: () {
                          setState(() {
                            enterPasswordVisible = !enterPasswordVisible!;
                          });
                        },
                      ),
                    ),
                    if (_failedAttempts > 0)
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        child: AutoSizeText(
                          '${localizations.attempt}$_failedAttempts/$maxAttempts',
                          style: AppStyles.textStyleSize14W200Primary(
                            context,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          stepGranularity: 0.1,
                        ),
                      ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      margin: const EdgeInsets.only(top: 3),
                      child: Text(
                        passwordError == null ? '' : passwordError!,
                        style: AppStyles.textStyleSize14W600Primary(
                          context,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        if (enterPasswordController!.text == '')
                          AppButton.buildAppButton(
                            const Key('confirm'),
                            context,
                            AppButtonType.primaryOutline,
                            localizations.confirm,
                            Dimens.buttonTopDimens,
                            onPressed: () async {},
                          )
                        else
                          AppButton.buildAppButton(
                            const Key('confirm'),
                            context,
                            AppButtonType.primary,
                            localizations.confirm,
                            Dimens.buttonTopDimens,
                            onPressed: () async {
                              await _verifyPassword();
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
