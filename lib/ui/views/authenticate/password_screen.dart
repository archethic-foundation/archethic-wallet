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
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    enterPasswordVisible = false;
    enterPasswordFocusNode = FocusNode();
    enterPasswordController = TextEditingController();
    showLockCountdownScreenIfNeeded(context, ref);
  }

  @override
  void dispose() {
    enterPasswordController?.dispose();
    enterPasswordFocusNode?.dispose();
    super.dispose();
  }

  Future<void> _verifyPassword() async {
    if (isProcessing) return;
    if (!_canBeSubmitted) return;
    if (!mounted) return;

    setState(() {
      isProcessing = true;
    });
    // wait for next redraw to perform operation.
    // that way, we ensure [isProcessing] change is reflecter on the UI
    // This is necessary because [setPassword] decyphering operation
    // stalls UI on web platform (single-threaded)
    await Future.delayed(
      const Duration(milliseconds: 5),
      () {},
    );

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
        _focusTextField();
        await showLockCountdownScreenIfNeeded(context, ref);
        enterPasswordController!.text = '';
        isProcessing = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.canNavigateBack,
      child: GestureDetector(
        onTap: _focusTextField,
        child: SheetSkeleton(
          appBar: getAppBar(context, ref),
          resizeToAvoidBottomInset: true,
          floatingActionButton: getFloatingActionButton(context, ref),
          sheetContent: getSheetContent(context, ref),
        ),
      ),
    );
  }

  bool get _canBeSubmitted => enterPasswordController!.text != '';

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
          onPressed: _verifyPassword,
          disabled: !_canBeSubmitted || isProcessing,
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

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  void _focusTextField() {
    enterPasswordFocusNode?.requestFocus();
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final passwordAuthentication = ref.watch(
      AuthenticationProviders.passwordAuthentication,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.enterPasswordHint,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  width: 0.5,
                                ),
                                gradient:
                                    ArchethicTheme.gradientInputFormBackground,
                              ),
                              child: TextField(
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                autocorrect: false,
                                controller: enterPasswordController,
                                obscureText: !enterPasswordVisible!,
                                onChanged: (String newText) {
                                  setState(() {
                                    if (passwordError != null) {
                                      passwordError = null;
                                    }
                                  });
                                },
                                onSubmitted: (value) async {
                                  _unfocus();
                                  await _verifyPassword();
                                },
                                focusNode: enterPasswordFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(
                                    20,
                                  ),
                                ],
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextFieldButton(
              icon: enterPasswordVisible!
                  ? Symbols.visibility
                  : Symbols.visibility_off,
              onPressed: () {
                setState(() {
                  enterPasswordVisible = !enterPasswordVisible!;
                });
              },
            ),
          ],
        ),
        if (passwordAuthentication.failedAttemptsCount > 0)
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 10,
            ),
            child: AutoSizeText(
              '${AppLocalizations.of(context)!.attempt}${passwordAuthentication.failedAttemptsCount}/${passwordAuthentication.maxAttemptsCount}',
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
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }
}
