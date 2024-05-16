/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/domain/models/authentication.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/authenticate/auto_lock_guard.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({
    super.key,
    required this.canNavigateBack,
  });

  static const name = 'PasswordScreen';
  static const routerPage = '/password';

  final bool canNavigateBack;

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen>
    with CountdownLockMixin
    implements SheetSkeletonInterface {
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
    if (!mounted) return;

    final password = enterPasswordController!.text;
    final result = await ref
        .read(
          AuthenticationProviders.passwordAuthentication.notifier,
        )
        .authenticateWithPassword(
          PasswordCredentials(
            password: password,
          ),
        );

    await result.maybeMap(
      success: (_) async {
        await ref
            .read(
              AuthenticationProviders.settings.notifier,
            )
            .setAuthMethod(AuthMethod.password);
        context.pop<String?>(password);
        return;
      },
      orElse: () async {
        await showLockCountdownScreenIfNeeded(context, ref);
        enterPasswordController!.text = '';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.canNavigateBack,
      child: SheetSkeleton(
        appBar: getAppBar(context, ref),
        floatingActionButton: getFloatingActionButton(context, ref),
        sheetContent: getSheetContent(context, ref),
      ),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Row(
      children: <Widget>[
        AppButtonTiny(
          AppButtonTinyType.primary,
          localizations.confirm,
          Dimens.buttonTopDimens,
          key: const Key('confirm'),
          onPressed: () async {
            await _verifyPassword();
          },
          disabled: enterPasswordController!.text == '',
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.passwordMethod,
      widgetLeft: widget.canNavigateBack
          ? BackButton(
              key: const Key('back'),
              color: ArchethicTheme.text,
              onPressed: () {
                context.pop(false);
              },
            )
          : const SizedBox(),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final passwordAuthentication = ref.watch(
      AuthenticationProviders.passwordAuthentication,
    );

    return Column(
      children: <Widget>[
        AppTextField(
          topMargin: 30,
          padding: const EdgeInsetsDirectional.only(
            start: 16,
            end: 16,
          ),
          focusNode: enterPasswordFocusNode,
          controller: enterPasswordController,
          textInputAction: TextInputAction.done,
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
            await _verifyPassword();
          },
          labelText: localizations.enterPasswordHint,
          keyboardType: TextInputType.text,
          obscureText: !enterPasswordVisible!,
          style: ArchethicThemeStyles.textStyleSize16W700Primary,
          suffixButton: TextFieldButton(
            icon: enterPasswordVisible!
                ? Symbols.visibility
                : Symbols.visibility_off,
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
              style: ArchethicThemeStyles.textStyleSize14W200Primary,
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
            style: ArchethicThemeStyles.textStyleSize14W600Primary,
          ),
        ),
      ],
    );
  }
}
