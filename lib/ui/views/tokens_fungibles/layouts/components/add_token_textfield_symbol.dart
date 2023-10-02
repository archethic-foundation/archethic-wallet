/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'add_token_form_sheet.dart';

class AddTokenTextFieldSymbol extends ConsumerStatefulWidget {
  const AddTokenTextFieldSymbol({
    super.key,
  });

  @override
  ConsumerState<AddTokenTextFieldSymbol> createState() =>
      _AddTokenTextFieldSymbolState();
}

class _AddTokenTextFieldSymbolState
    extends ConsumerState<AddTokenTextFieldSymbol> {
  late TextEditingController symbolController;
  late FocusNode symbolFocusNode;

  @override
  void initState() {
    super.initState();
    final addToken = ref.read(AddTokenFormProvider.addTokenForm);
    symbolFocusNode = FocusNode();
    symbolController = TextEditingController(text: addToken.symbol);
  }

  @override
  void dispose() {
    symbolFocusNode.dispose();
    symbolController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;
    final addTokenNotifier =
        ref.watch(AddTokenFormProvider.addTokenForm.notifier);

    return Column(
      children: [
        AppTextField(
          textAlign: TextAlign.start,
          focusNode: symbolFocusNode,
          controller: symbolController,
          cursorColor: theme.text,
          textInputAction: TextInputAction.next,
          labelText: localizations.tokenSymbolHint,
          autocorrect: false,
          keyboardType: TextInputType.text,
          style: theme.textStyleSize16W600Primary,
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
          ],
          onChanged: (text) async {
            await addTokenNotifier.setSymbol(
              context: context,
              symbol: text,
            );
          },
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(
            left: 40,
            top: 5,
            bottom: 5,
          ),
          child: Text(
            localizations.tokenSymbolMaxNumberCharacter,
            style: theme.textStyleSize10W100Primary,
          ),
        ),
      ],
    );
  }
}
