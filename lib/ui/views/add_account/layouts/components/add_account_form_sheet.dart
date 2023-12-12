/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/add_account/bloc/provider.dart';
import 'package:aewallet/ui/views/add_account/bloc/state.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

part 'add_account_textfield_name.dart';

class AddAccountFormSheet extends ConsumerWidget {
  const AddAccountFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;
    final addAccount = ref.watch(AddAccountFormProvider.addAccountForm);
    final addAccountNotifier =
        ref.watch(AddAccountFormProvider.addAccountForm.notifier);

    if (accountSelected == null) return const SizedBox();

    return Scaffold(
      drawerEdgeDragWidth: 0,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: ArchethicTheme.background,
      appBar: SheetAppBar(
        title: localizations.addAccount,
        widgetLeft: BackButton(
          key: const Key('back'),
          color: ArchethicTheme.text,
          onPressed: () {
            context.go(HomePage.routerPage);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          bottom: 20,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ArchethicTheme.backgroundSmall,
            ),
            fit: BoxFit.fitHeight,
            opacity: 0.7,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: <Widget>[
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
                          style:
                              ArchethicThemeStyles.textStyleSize14W600Primary,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: AddAccountTextFieldName(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AutoSizeText(
                          localizations.introNewWalletGetFirstInfosNameInfos,
                          style:
                              ArchethicThemeStyles.textStyleSize12W100Primary,
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
                      AppButtonTinyConnectivity(
                        localizations.addAccount,
                        icon: Symbols.add,
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
                        disabled: !addAccount.canAddAccount,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
