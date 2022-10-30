/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/tokens_fungibles/bloc/provider.dart';
import 'package:aewallet/ui/views/tokens_fungibles/bloc/state.dart';
import 'package:aewallet/ui/views/tokens_fungibles/layouts/components/add_token_confirm_sheet.dart';
import 'package:aewallet/ui/views/tokens_fungibles/layouts/components/add_token_form_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTokenSheet extends ConsumerWidget {
  const AddTokenSheet({
    required this.seed,
    super.key,
  });

  final String seed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAccount = ref.watch(
      AccountProviders.getSelectedAccount(context: context),
    );

    // The main column that holds everything
    return ProviderScope(
      overrides: [
        AddTokenFormProvider.initialAddTokenForm.overrideWithValue(
          AddTokenFormState(
            feeEstimation: const AsyncValue.data(0),
            seed: seed,
            accountBalance: selectedAccount!.balance!,
          ),
        ),
      ],
      child: AddTokenSheetBody(
        seed: seed,
      ),
    );
  }
}

class AddTokenSheetBody extends ConsumerWidget {
  const AddTokenSheetBody({
    required this.seed,
    super.key,
  });

  final String seed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final addToken = ref.watch(AddTokenFormProvider.addTokenForm);

    ref.listen<AddTokenFormState>(
      AddTokenFormProvider.addTokenForm,
      (_, addToken) {
        if (addToken.isControlsOk) return;

        final errorMessages = <String>[];
        if (addToken.errorNameText.isNotEmpty) {
          errorMessages.add(addToken.errorNameText);
        }
        if (addToken.errorSymbolText.isNotEmpty) {
          errorMessages.add(addToken.errorSymbolText);
        }
        if (addToken.errorInitialSupplyText.isNotEmpty) {
          errorMessages.add(addToken.errorInitialSupplyText);
        }

        UIUtil.showSnackbar(
          errorMessages.join('\n'),
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
          duration: const Duration(seconds: 5),
        );
      },
    );

    if (addToken.addTokenProcessStep == AddTokenProcessStep.form) {
      return AddTokenFormSheet(seed: seed);
    } else {
      return const AddTokenConfirmSheet();
    }
  }
}
