/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:math';

import 'package:aewallet/application/authent_web.dart';
import 'package:aewallet/infrastructure/datasources/hive_vault.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/string_encryption.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    this.seed,
  });

  final String? header;
  final String? description;
  final String? seed;

  static const routerPage = '/set_password';

  @override
  ConsumerState<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends ConsumerState<SetPassword>
    implements SheetSkeletonInterface {
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
          onPressed: () async {
            await _validateRequest();
          },
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
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          style: ArchethicThemeStyles.textStyleSize16W700Primary,
          onSubmitted: (text) {
            confirmPasswordFocusNode!.requestFocus();
          },
          prefixButton: TextFieldButton(
            icon: Symbols.shuffle,
            onPressed: () {
              setPasswordController!.text = '';
              final passwordLength = Random().nextInt(8) + 10;

              const allowedChars =
                  r'abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ023456789@#=+!£$%&?[](){}';
              var i = 0;
              while (i < passwordLength) {
                final random = Random.secure().nextInt(allowedChars.length);
                setPasswordController!.text += allowedChars[random];
                i++;
              }

              setState(() {
                setPasswordVisible = true;
                passwordStrength = estimatePasswordStrength(
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
                setPasswordVisible = !setPasswordVisible!;
              });
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              right: MediaQuery.of(context).size.width * 0.105,
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
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
                  )
                else
                  passwordStrength <= 0.8
                      ? Text(
                          localizations.passwordStrengthAlright,
                          textAlign: TextAlign.end,
                          style:
                              ArchethicThemeStyles.textStyleSize12W100Primary,
                        )
                      : Text(
                          localizations.passwordStrengthStrong,
                          textAlign: TextAlign.end,
                          style:
                              ArchethicThemeStyles.textStyleSize12W100Primary,
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
          style: ArchethicThemeStyles.textStyleSize16W700Primary,
          suffixButton: TextFieldButton(
            icon: confirmPasswordVisible!
                ? Symbols.visibility
                : Symbols.visibility_off,
            onPressed: () {
              setState(() {
                confirmPasswordVisible = !confirmPasswordVisible!;
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
      final vault = await HiveVaultDatasource.getInstance(
        kIsWeb ? setPasswordController!.text : null,
      );
      await vault.setPassword(
        stringEncryptBase64(setPasswordController!.text, widget.seed),
      );
      if (kIsWeb) {
        ref
            .read(authentWebProviders.notifier)
            .setAuthentWeb(setPasswordController!.text);
      }
      context.pop(true);
    }
  }
}
