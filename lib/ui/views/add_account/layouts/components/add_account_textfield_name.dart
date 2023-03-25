/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'add_account_form_sheet.dart';

class AddAccountTextFieldName extends ConsumerStatefulWidget {
  const AddAccountTextFieldName({
    super.key,
  });

  @override
  ConsumerState<AddAccountTextFieldName> createState() =>
      _AddAccountTextFieldNameState();
}

class _AddAccountTextFieldNameState
    extends ConsumerState<AddAccountTextFieldName> {
  late TextEditingController nameController;
  late FocusNode nameFocusNode;

  @override
  void initState() {
    super.initState();
    final addAccount = ref.read(AddAccountFormProvider.addAccountForm);
    nameFocusNode = FocusNode();
    nameController = TextEditingController(text: addAccount.name);
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;
    final addAccountNotifier =
        ref.watch(AddAccountFormProvider.addAccountForm.notifier);

    return AppTextField(
      focusNode: nameFocusNode,
      controller: nameController,
      cursorColor: theme.text,
      textInputAction: TextInputAction.next,
      labelText: localizations.introNewWalletGetFirstInfosNameBlank,
      autocorrect: false,
      keyboardType: TextInputType.text,
      style: theme.textStyleSize16W600Primary,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(
          20,
        ),
        UpperCaseTextFormatter(),
      ],
      onChanged: (text) async {
        addAccountNotifier.setName(
          text,
        );
      },
    );
  }
}
