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
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part 'add_account_textfield_name.dart';

class AddAccountFormSheet extends ConsumerWidget
    implements SheetSkeletonInterface {
  const AddAccountFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;

    if (accountSelected == null) return const SizedBox();

    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final addAccount = ref.watch(AddAccountFormProvider.addAccountForm);
    final addAccountNotifier =
        ref.watch(AddAccountFormProvider.addAccountForm.notifier);
    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          localizations.addAccount,
          Dimens.buttonBottomDimens,
          key: const Key('addAccount'),
          onPressed: () async {
            final isNameOk = addAccountNotifier.controlName(context);

            if (isNameOk) {
              addAccountNotifier.setAddAccountProcessStep(
                AddAccountProcessStep.confirmation,
              );
            }
          },
          disabled: !addAccount.canAddAccount,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.addAccount,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.go(HomePage.routerPage);
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      children: <Widget>[
        Text(
          localizations.introNewWalletGetFirstInfosNameRequest,
          style: ArchethicThemeStyles.textStyleSize14W600Primary,
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
          style: ArchethicThemeStyles.textStyleSize12W100Primary,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
