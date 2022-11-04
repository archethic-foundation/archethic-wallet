/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'add_token_form_sheet.dart';

class AddTokenTextFieldInitialSupply extends ConsumerStatefulWidget {
  const AddTokenTextFieldInitialSupply({
    super.key,
  });

  @override
  ConsumerState<AddTokenTextFieldInitialSupply> createState() =>
      _AddTokenTextFieldInitialSupplyState();
}

class _AddTokenTextFieldInitialSupplyState
    extends ConsumerState<AddTokenTextFieldInitialSupply> {
  late TextEditingController initialSupplyController;
  late FocusNode initialSupplyFocusNode;

  @override
  void initState() {
    super.initState();
    final addToken = ref.read(AddTokenFormProvider.addTokenForm);
    initialSupplyFocusNode = FocusNode();
    initialSupplyController = TextEditingController(
        text: addToken.initialSupply == 0
            ? ''
            : addToken.initialSupply.toString(),);
  }

  @override
  void dispose() {
    initialSupplyFocusNode.dispose();
    initialSupplyController.dispose();
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
      focusNode: initialSupplyFocusNode,
      controller: initialSupplyController,
      cursorColor: theme.text,
      textInputAction: TextInputAction.next,
      labelText: localizations.tokenInitialSupplyHint,
      keyboardType: TextInputType.number,
      style: theme.textStyleSize16W600Primary,
      inputFormatters: [
        LengthLimitingTextInputFormatter(23),
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d+\.?\d{0,8}'),
        ),
      ],
      onChanged: (text) async {
        addTokenNotifier.setInitialSupply(
          context: context,
          initialSupply: double.tryParse(text) ?? 0,
        );
      },
    );
  }
}