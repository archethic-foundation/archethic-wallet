/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:aewallet/util/string_encryption.dart';
import 'package:aewallet/util/vault.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
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
        // TODO(Chralu): remettre en place ce mécanisme.
        // preferences.updateLockDate();
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
    final theme = ref.watch(ThemeProviders.selectedTheme);
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
                        style: theme.textStyleSize24W700EquinoxPrimary,
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
                      style: theme.textStyleSize16W700Primary,
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
                          style: theme.textStyleSize14W200Primary,
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
                        style: theme.textStyleSize14W600Primary,
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
                          AppButton(
                            AppButtonType.primaryOutline,
                            localizations.confirm,
                            Dimens.buttonTopDimens,
                            key: const Key('confirm'),
                            onPressed: () async {},
                          )
                        else
                          AppButton(
                            AppButtonType.primary,
                            localizations.confirm,
                            Dimens.buttonTopDimens,
                            key: const Key('confirm'),
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
