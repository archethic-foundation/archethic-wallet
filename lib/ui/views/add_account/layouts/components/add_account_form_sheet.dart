/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/complex/estimated_fees.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/add_account/bloc/provider.dart';
import 'package:aewallet/ui/views/add_account/bloc/state.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
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
    final accountSelected = ref.watch(
      accountsNotifierProvider.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const EstimatedFees(AsyncValue.data(0)),
        BtnFooterPrimary(
          buttonText: localizations.addAccount,
          key: const Key('addAccount'),
          onTap: () async {
            final isNameOk = addAccountNotifier.controlName(context);

            if (isNameOk) {
              addAccountNotifier.setAddAccountProcessStep(
                AddAccountProcessStep.confirmation,
              );
            }
          },
          isLocked: !addAccount.canAddAccount || addAccount.name.trim().isEmpty,
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
          context.pop();
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: AddAccountTextFieldName(),
        ),
        const SizedBox(
          height: 20,
        ),
        AutoSizeText(
          localizations.addAccountNameWarning,
          style: ArchethicThemeStyles.textStyleSize12W100Primary,
        ),
      ],
    );
  }
}
