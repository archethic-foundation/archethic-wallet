/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:math';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:password_strength/password_strength.dart';

class SetPassword extends ConsumerStatefulWidget {
  const SetPassword({
    super.key,
    this.header,
    this.description,
  });

  final String? header;
  final String? description;

  static const routerPage = '/set_password';

  @override
  ConsumerState<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends ConsumerState<SetPassword>
    implements SheetSkeletonInterface {
  late TextEditingController pwdController;
  late FocusNode pwdFocusNode;
  late TextEditingController pwdConfirmController;
  late FocusNode pwdConfirmFocusNode;
  String? passwordError;
  bool? setPasswordVisible;
  bool? passwordsMatch;
  double passwordStrength = 0;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    setPasswordVisible = false;
    pwdFocusNode = FocusNode();
    pwdController = TextEditingController();
    pwdConfirmFocusNode = FocusNode();
    pwdConfirmController = TextEditingController();
    passwordsMatch = false;
  }

  @override
  void dispose() {
    pwdFocusNode.dispose();
    pwdController.dispose();
    pwdConfirmController.dispose();
    pwdConfirmFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
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
          onPressed: _validateRequest,
          disabled: isProcessing,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.passwordMethod,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop(false);
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    AppLocalizations.of(context)!.createPasswordHint,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 130,
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
                                        gradient: ArchethicTheme
                                            .gradientInputFormBackground,
                                      ),
                                      child: TextField(
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                        autocorrect: false,
                                        controller: pwdController,
                                        obscureText: !setPasswordVisible!,
                                        onChanged: (text) async {
                                          passwordStrength =
                                              estimatePasswordStrength(
                                            pwdController.text,
                                          );
                                          if (passwordError != null) {
                                            setState(() {
                                              passwordError = null;
                                            });
                                          }

                                          if (pwdConfirmController.text ==
                                              pwdController.text) {
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
                                        focusNode: pwdFocusNode,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        inputFormatters: <TextInputFormatter>[
                                          LengthLimitingTextInputFormatter(
                                            20,
                                          ),
                                        ],
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding:
                                              EdgeInsets.only(left: 10),
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
                      icon: Symbols.shuffle,
                      onPressed: () {
                        pwdController.text = '';
                        final passwordLength = Random().nextInt(8) + 10;

                        const allowedChars =
                            r'abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ023456789@#=+!£$%&?[](){}';
                        var i = 0;
                        while (i < passwordLength) {
                          final random =
                              Random.secure().nextInt(allowedChars.length);
                          pwdController.text += allowedChars[random];
                          i++;
                        }

                        setState(() {
                          setPasswordVisible = true;
                          passwordStrength = estimatePasswordStrength(
                            pwdController.text,
                          );
                        });
                      },
                    ),
                    TextFieldButton(
                      icon: setPasswordVisible!
                          ? Symbols.visibility
                          : Symbols.visibility_off,
                      onPressed: () {
                        setState(() {
                          setPasswordVisible = !setPasswordVisible!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            )
                .animate()
                .fade(duration: const Duration(milliseconds: 200))
                .scale(duration: const Duration(milliseconds: 200)),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 5,
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
                        AppLocalizations.of(context)!.passwordStrengthWeak,
                        textAlign: TextAlign.end,
                        style: ArchethicThemeStyles.textStyleSize12W100Primary,
                      )
                    else
                      passwordStrength <= 0.8
                          ? Text(
                              AppLocalizations.of(context)!
                                  .passwordStrengthAlright,
                              textAlign: TextAlign.end,
                              style: ArchethicThemeStyles
                                  .textStyleSize12W100Primary,
                            )
                          : Text(
                              AppLocalizations.of(context)!
                                  .passwordStrengthStrong,
                              textAlign: TextAlign.end,
                              style: ArchethicThemeStyles
                                  .textStyleSize12W100Primary,
                            ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    AppLocalizations.of(context)!.confirmPasswordHint,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
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
                                    gradient: ArchethicTheme
                                        .gradientInputFormBackground,
                                  ),
                                  child: TextField(
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    autocorrect: false,
                                    controller: pwdConfirmController,
                                    obscureText: !setPasswordVisible!,
                                    onChanged: (text) async {
                                      if (passwordError != null) {
                                        setState(() {
                                          passwordError = null;
                                        });
                                      }
                                      if (pwdConfirmController.text ==
                                          pwdController.text) {
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
                                    focusNode: pwdConfirmFocusNode,
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
              ],
            )
                .animate()
                .fade(duration: const Duration(milliseconds: 200))
                .scale(duration: const Duration(milliseconds: 200)),
          ],
        ),
        const SizedBox(height: 20),
        // Error Text
        Container(
          alignment: AlignmentDirectional.center,
          margin: const EdgeInsets.only(top: 3),
          child: Text(
            passwordError == null ? '' : passwordError!,
            style: ArchethicThemeStyles.textStyleSize14W600Primary,
          ),
        ),

        if (widget.description != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(
                  top: 15,
                ),
                child: Column(
                  children: [
                    Text(
                      widget.description!,
                      style: ArchethicThemeStyles.textStyleSize12W100Primary,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }

  Future<void> _validateRequest() async {
    if (isProcessing) return;

    if (pwdController.text.isEmpty) {
      setState(() {
        passwordError = AppLocalizations.of(context)!.passwordBlank;
      });
      return;
    }
    if (pwdConfirmController.text.isEmpty) {
      setState(() {
        passwordError = AppLocalizations.of(context)!.passwordConfirmationBlank;
      });
      return;
    }
    if (pwdController.text != pwdConfirmController.text) {
      setState(() {
        passwordError = AppLocalizations.of(context)!.passwordsDontMatch;
      });
      return;
    }

    setState(() {
      isProcessing = true;
    });
    // wait for next redraw to perfor operation.
    // that way, we ensure [isProcessing] change is reflecter on the UI
    // This is necessary because [setPassword] decyphering operation
    // stalls UI on web platform (single-threaded)
    await Future.delayed(
      const Duration(milliseconds: 5),
      () {},
    );
    await ref
        .read(AuthenticationProviders.passwordAuthentication.notifier)
        .setPassword(pwdController.text);
    context.pop(true);
  }
}
