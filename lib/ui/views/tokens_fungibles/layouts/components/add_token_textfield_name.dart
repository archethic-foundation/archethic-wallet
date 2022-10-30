/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'add_token_form_sheet.dart';

class AddTokenTextFieldName extends ConsumerStatefulWidget {
  const AddTokenTextFieldName({
    super.key,
  });

  @override
  ConsumerState<AddTokenTextFieldName> createState() =>
      _AddTokenTextFieldNameState();
}

class _AddTokenTextFieldNameState extends ConsumerState<AddTokenTextFieldName> {
  late TextEditingController nameController;
  late FocusNode nameFocusNode;

  @override
  void initState() {
    super.initState();
    final addToken = ref.read(AddTokenFormProvider.addTokenForm);
    nameFocusNode = FocusNode();
    nameController = TextEditingController(text: addToken.name);
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
    final localizations = AppLocalization.of(context)!;
    final addTokenNotifier =
        ref.watch(AddTokenFormProvider.addTokenForm.notifier);

    return AppTextField(
      focusNode: nameFocusNode,
      controller: nameController,
      cursorColor: theme.text,
      textInputAction: TextInputAction.newline,
      labelText: localizations.tokenNameHint,
      autocorrect: false,
      keyboardType: TextInputType.text,
      style: theme.textStyleSize16W600Primary,
      inputFormatters: <LengthLimitingTextInputFormatter>[
        LengthLimitingTextInputFormatter(40),
      ],
      onChanged: (text) async {
        addTokenNotifier.setName(
          context: context,
          name: text,
        );
      },
    );
  }
}
