/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../add_contact.dart';

class AddContactTextFieldName extends ConsumerStatefulWidget {
  const AddContactTextFieldName({
    super.key,
  });

  @override
  ConsumerState<AddContactTextFieldName> createState() =>
      _AddContactTextFieldNameState();
}

class _AddContactTextFieldNameState
    extends ConsumerState<AddContactTextFieldName> {
  late FocusNode nameFocusNode;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameFocusNode = FocusNode();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;

    final contactCreationNotifier =
        ref.watch(ContactCreationFormProvider.contactCreationForm.notifier);

    return AppTextField(
      focusNode: nameFocusNode,
      controller: nameController,
      textInputAction: TextInputAction.next,
      labelText: localizations.contactNameHint,
      keyboardType: TextInputType.text,
      style: theme.textStyleSize16W600Primary,
      inputFormatters: <TextInputFormatter>[
        UpperCaseTextFormatter(),
        LengthLimitingTextInputFormatter(20),
      ],
      onChanged: (text) async {
        contactCreationNotifier.setName(text, context);
      },
    );
  }
}
