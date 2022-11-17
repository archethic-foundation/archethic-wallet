/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAccountButton extends ConsumerStatefulWidget {
  const AddAccountButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddAccountButtonState();
}

class _AddAccountButtonState extends ConsumerState<AddAccountButton> {
  bool? isPressed = false;
  final GlobalKey expandedKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final accounts =
        ref.watch(AccountProviders.sortedAccounts).valueOrNull ?? [];

    return AppButtonTiny(
      AppButtonTinyType.primary,
      localizations.addAccount,
      Dimens.buttonBottomDimens,
      key: const Key('addAccount'),
      icon: Icon(
        Icons.add,
        color: theme.text,
        size: 14,
      ),
      onPressed: () async {
        final nameFocusNode = FocusNode();
        final nameController = TextEditingController();
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Text(
                          localizations.introNewWalletGetFirstInfosNameRequest,
                          style: theme.textStyleSize14W600Primary,
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    side: BorderSide(
                      color: theme.text45!,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          AppTextField(
                            leftMargin: 0,
                            rightMargin: 0,
                            focusNode: nameFocusNode,
                            autocorrect: false,
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            style: theme.textStyleSize12W600Primary,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(
                                20,
                              ),
                              UpperCaseTextFormatter(),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              UiIcons.about,
                              color: theme.text,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            localizations.introNewWalletGetFirstInfosNameInfos,
                            style: theme.textStyleSize12W100Primary,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          AppButtonTiny(
                            isPressed == false
                                ? AppButtonTinyType.primary
                                : AppButtonTinyType.primaryOutline,
                            localizations.ok,
                            Dimens.buttonBottomDimens,
                            key: const Key('addName'),
                            onPressed: () async {
                              if (isPressed == true) {
                                return;
                              }

                              if (nameController.text.isEmpty) {
                                UIUtil.showSnackbar(
                                  localizations
                                      .introNewWalletGetFirstInfosNameBlank,
                                  context,
                                  ref,
                                  theme.text!,
                                  theme.snackBarShadow!,
                                  duration: const Duration(
                                    seconds: 5,
                                  ),
                                );

                                FocusScope.of(context).requestFocus(
                                  nameFocusNode,
                                );
                              } else {
                                var accountExists = false;
                                for (final account in accounts) {
                                  if (account.name == nameController.text) {
                                    accountExists = true;
                                  }
                                }
                                if (accountExists == true) {
                                  UIUtil.showSnackbar(
                                    localizations.addAccountExists,
                                    context,
                                    ref,
                                    theme.text!,
                                    theme.snackBarShadow!,
                                    duration: const Duration(
                                      seconds: 5,
                                    ),
                                  );
                                  FocusScope.of(context).requestFocus(
                                    nameFocusNode,
                                  );
                                } else {
                                  setState(() {
                                    isPressed = true;
                                  });
                                  AppDialogs.showConfirmDialog(
                                    context,
                                    ref,
                                    localizations.addAccount,
                                    localizations.addAccountConfirmation
                                        .replaceAll(
                                      '%1',
                                      nameController.text,
                                    ),
                                    localizations.yes,
                                    () async {
                                      try {
                                        await ref
                                            .read(
                                              AccountProviders
                                                  .accounts.notifier,
                                            )
                                            .addAccount(
                                              name: nameController.text,
                                            );
                                      } on ArchethicConnectionException {
                                        UIUtil.showSnackbar(
                                          localizations.noConnection,
                                          context,
                                          ref,
                                          theme.text!,
                                          theme.snackBarShadow!,
                                          duration: const Duration(
                                            seconds: 5,
                                          ),
                                        );
                                      } on Exception {
                                        UIUtil.showSnackbar(
                                          localizations.keychainNotExistWarning,
                                          context,
                                          ref,
                                          theme.text!,
                                          theme.snackBarShadow!,
                                          duration: const Duration(
                                            seconds: 5,
                                          ),
                                        );
                                      }

                                      setState(() {
                                        isPressed = false;
                                      });
                                      Navigator.pop(
                                        context,
                                        true,
                                      );
                                    },
                                    cancelText: localizations.no,
                                    cancelAction: () {
                                      setState(() {
                                        isPressed = false;
                                      });
                                    },
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
