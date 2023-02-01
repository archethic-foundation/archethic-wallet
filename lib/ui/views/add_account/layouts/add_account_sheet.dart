/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/add_account/bloc/provider.dart';
import 'package:aewallet/ui/views/add_account/bloc/state.dart';
import 'package:aewallet/ui/views/add_account/layouts/components/add_account_confirm_sheet.dart';
import 'package:aewallet/ui/views/add_account/layouts/components/add_account_form_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAccountSheet extends ConsumerWidget {
  const AddAccountSheet({
    required this.seed,
    super.key,
  });

  final String seed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAccount = ref
        .watch(
          AccountProviders.selectedAccount,
        )
        .valueOrNull;

    if (selectedAccount == null) return const SizedBox();

    return ProviderScope(
      overrides: [
        AddAccountFormProvider.initialAddAccountForm.overrideWithValue(
          AddAccountFormState(
            seed: seed,
          ),
        ),
      ],
      child: AddAccountSheetBody(
        seed: seed,
      ),
    );
  }
}

class AddAccountSheetBody extends ConsumerWidget {
  const AddAccountSheetBody({
    required this.seed,
    super.key,
  });

  final String seed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final addAccount = ref.watch(AddAccountFormProvider.addAccountForm);

    ref.listen<AddAccountFormState>(
      AddAccountFormProvider.addAccountForm,
      (_, addAccount) {
        if (addAccount.isControlsOk) return;

        UIUtil.showSnackbar(
          addAccount.errorText,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
          duration: const Duration(seconds: 5),
        );

        ref.read(AddAccountFormProvider.addAccountForm.notifier).setError(
              '',
            );
      },
    );

    if (addAccount.addAccountProcessStep == AddAccountProcessStep.form) {
      return const AddAccountFormSheet();
    } else {
      return const AddAccountConfirmSheet();
    }
  }
}
