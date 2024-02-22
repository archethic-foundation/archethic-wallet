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
    final addTokenNotifier =
        ref.watch(AddTokenFormProvider.addTokenForm.notifier);

    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.tokenSymbolHint,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  width: 0.5,
                                ),
                                gradient:
                                    ArchethicTheme.gradientInputFormBackground,
                              ),
                              child: TextField(
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                autocorrect: false,
                                controller: symbolController,
                                onChanged: (text) async {
                                  await addTokenNotifier.setSymbol(
                                    context: context,
                                    symbol: text,
                                  );
                                },
                                focusNode: symbolFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        child: Text(
                          localizations.tokenSymbolMaxNumberCharacter,
                          style:
                              ArchethicThemeStyles.textStyleSize10W100Primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }
}
