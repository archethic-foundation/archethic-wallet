/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: always_specify_types

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/util/string_encryption.dart';
import 'package:core/util/vault.dart';
import 'package:core_ui/ui/util/dimens.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/util/preferences.dart';

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
    final Vault vault = await Vault.getInstance();
    final Preferences preferences = await Preferences.getInstance();

    if (enterPasswordController!.text ==
        stringDecryptBase64(
            vault.getPassword()!, await StateContainer.of(context).getSeed())) {
      preferences.resetLockAttempts();
      Navigator.of(context).pop(true);
    } else {
      enterPasswordController!.text = '';
      preferences.incrementLockAttempts();
      _failedAttempts++;
      if (_failedAttempts >= maxAttempts) {
        preferences.updateLockDate();
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/lock_screen_transition', (Route<dynamic> route) => false);
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      StateContainer.of(context).curTheme.background5Small!),
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
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                SafeArea(
              minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
                top: MediaQuery.of(context).size.height * 0.10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                  color:
                                      StateContainer.of(context).curTheme.text,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: Text(
                              AppLocalization.of(context)!.passwordMethod,
                              style:
                                  AppStyles.textStyleSize24W700EquinoxPrimary(
                                      context),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          AppTextField(
                            topMargin: 30,
                            padding: const EdgeInsetsDirectional.only(
                                start: 16, end: 16),
                            focusNode: enterPasswordFocusNode,
                            controller: enterPasswordController,
                            textInputAction: TextInputAction.go,
                            maxLines: 1,
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
                            labelText:
                                AppLocalization.of(context)!.enterPasswordHint,
                            keyboardType: TextInputType.text,
                            obscureText: !enterPasswordVisible!,
                            textAlign: TextAlign.center,
                            style:
                                AppStyles.textStyleSize16W700Primary(context),
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
                                  horizontal: 40, vertical: 10),
                              child: AutoSizeText(
                                AppLocalization.of(context)!.attempt +
                                    _failedAttempts.toString() +
                                    '/' +
                                    maxAttempts.toString(),
                                style: AppStyles.textStyleSize14W200Primary(
                                    context),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                stepGranularity: 0.1,
                              ),
                            ),
                          // Error Container
                          Container(
                            alignment: const AlignmentDirectional(0, 0),
                            margin: const EdgeInsets.only(top: 3),
                            child: Text(
                                passwordError == null ? '' : passwordError!,
                                style: AppStyles.textStyleSize14W600Primary(
                                    context)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          enterPasswordController!.text == ''
                              ? AppButton.buildAppButton(
                                  const Key('confirm'),
                                  context,
                                  AppButtonType.primaryOutline,
                                  AppLocalization.of(context)!.confirm,
                                  Dimens.buttonTopDimens,
                                  onPressed: () async {})
                              : AppButton.buildAppButton(
                                  const Key('confirm'),
                                  context,
                                  AppButtonType.primary,
                                  AppLocalization.of(context)!.confirm,
                                  Dimens.buttonTopDimens, onPressed: () async {
                                  await _verifyPassword();
                                }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
