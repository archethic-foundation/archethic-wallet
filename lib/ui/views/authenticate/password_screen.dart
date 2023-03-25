/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/authentication.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/authenticate/auto_lock_guard.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({
    super.key,
    required this.canNavigateBack,
  });

  static const name = 'PasswordScreen';

  final bool canNavigateBack;

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen>
    with LockGuardMixin {
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
    showLockCountdownScreenIfNeeded(context, ref);
  }

  Future<void> _verifyPassword() async {
    final result = await ref
        .read(
          AuthenticationProviders.passwordAuthentication.notifier,
        )
        .authenticateWithPassword(
          PasswordCredentials(
            password: enterPasswordController!.text,
            seed: ref.read(SessionProviders.session).loggedIn!.wallet.seed,
          ),
        );

    await result.maybeMap(
      success: (_) {
        Navigator.of(context).pop(true);
        return;
      },
      orElse: () async {
        showLockCountdownScreenIfNeeded(context, ref);
        enterPasswordController!.text = '';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final passwordAuthentication = ref.watch(
      AuthenticationProviders.passwordAuthentication,
    );

    return WillPopScope(
      onWillPop: () async => widget.canNavigateBack,
      child: Scaffold(
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
                            child: widget.canNavigateBack
                                ? BackButton(
                                    key: const Key('back'),
                                    color: theme.text,
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                  )
                                : const SizedBox(),
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
                              ? UiIcons.eye
                              : UiIcons.eye_hidden,
                          onPressed: () {
                            setState(() {
                              enterPasswordVisible = !enterPasswordVisible!;
                            });
                          },
                        ),
                      ),
                      if (passwordAuthentication.failedAttemptsCount > 0)
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 10,
                          ),
                          child: AutoSizeText(
                            '${localizations.attempt}${passwordAuthentication.failedAttemptsCount}/${passwordAuthentication.maxAttemptsCount}',
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
                            AppButtonTiny(
                              AppButtonTinyType.primaryOutline,
                              localizations.confirm,
                              Dimens.buttonTopDimens,
                              key: const Key('confirm'),
                              onPressed: () async {},
                            )
                          else
                            AppButtonTiny(
                              AppButtonTinyType.primary,
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
      ),
    );
  }
}
