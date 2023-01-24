/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/add_account/bloc/provider.dart';
import 'package:aewallet/ui/views/add_account/bloc/state.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'add_account_textfield_name.dart';

class AddAccountFormSheet extends ConsumerWidget {
  const AddAccountFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;
    final addAccount = ref.watch(AddAccountFormProvider.addAccountForm);
    final addAccountNotifier =
        ref.watch(AddAccountFormProvider.addAccountForm.notifier);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    if (accountSelected == null) return const SizedBox();

    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            SheetHeader(
              title: localizations.addAccount,
            ),
            Expanded(
              child: ArchethicScrollbar(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 15,
                    right: 15,
                    bottom: bottom + 80,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        localizations.introNewWalletGetFirstInfosNameRequest,
                        style: theme.textStyleSize14W600Primary,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: AddAccountTextFieldName(),
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
                      AutoSizeText(
                        localizations.introNewWalletGetFirstInfosNameInfos,
                        style: theme.textStyleSize12W100Primary,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (addAccount.canAddAccount &&
                        connectivityStatusProvider ==
                            ConnectivityStatus.isConnected)
                      AppButtonTiny(
                        AppButtonTinyType.primary,
                        localizations.addAccount,
                        icon: Icon(
                          Icons.add,
                          color: theme.mainButtonLabel,
                          size: 14,
                        ),
                        Dimens.buttonBottomDimens,
                        key: const Key('addAccount'),
                        onPressed: () async {
                          final isNameOk =
                              addAccountNotifier.controlName(context);

                          if (isNameOk) {
                            addAccountNotifier.setAddAccountProcessStep(
                              AddAccountProcessStep.confirmation,
                            );
                          }
                        },
                      )
                    else
                      AppButtonTiny(
                        AppButtonTinyType.primaryOutline,
                        localizations.addAccount,
                        Dimens.buttonBottomDimens,
                        key: const Key('addAccount'),
                        icon: Icon(
                          Icons.add,
                          color: theme.mainButtonLabel!.withOpacity(0.3),
                          size: 14,
                        ),
                        onPressed: () {},
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
