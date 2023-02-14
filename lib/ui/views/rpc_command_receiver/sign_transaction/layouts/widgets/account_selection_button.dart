part of '../sign_transaction_confirmation_form.dart';

class _AccountSelectionButton extends ConsumerWidget {
  const _AccountSelectionButton({
    required this.formNotifier,
    required this.formState,
  });

  final SignTransactionConfirmationFormNotifier formNotifier;
  final SignTransactionConfirmationFormState formState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return TextButton(
      child: Text(
        formState.senderAccount.name,
        style: theme.textStyleSize14W600Primary.copyWith(
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: () async {
        final accounts = await ref.read(AccountProviders.accounts.future);
        final selectedAccount = await AccountsDialog.getDialog(
          context,
          ref,
          formState.senderAccount,
          accounts,
        );

        if (selectedAccount == null) return;

        formNotifier.setAccount(selectedAccount);
      },
    );
  }
}
