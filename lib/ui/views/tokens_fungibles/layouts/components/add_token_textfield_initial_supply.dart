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
    initialSupplyFocusNode = FocusNode();
    _updateAmountTextController();
  }

  void _updateAmountTextController() {
    final addToken = ref.read(AddTokenFormProvider.addTokenForm);
    initialSupplyController = TextEditingController();
    initialSupplyController.value =
        AmountTextInputFormatter(precision: 8).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: addToken.initialSupply == 0
            ? ''
            : addToken.initialSupply.toString(),
      ),
    );
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
    final addTokenNotifier =
        ref.watch(AddTokenFormProvider.addTokenForm.notifier);
    final addToken = ref.read(AddTokenFormProvider.addTokenForm);
    if (!(addToken.initialSupply != 0.0 ||
        (initialSupplyController.text == '' ||
            initialSupplyController.text == '0' ||
            initialSupplyController.text == '0.'))) {
      _updateAmountTextController();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.tokenInitialSupplyHint,
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
                  child: Row(
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
                                ArchethicThemeBase.gradientInputFormBackground,
                          ),
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            autocorrect: false,
                            controller: initialSupplyController,
                            onChanged: (text) async {
                              await addTokenNotifier.setInitialSupply(
                                context: context,
                                initialSupply:
                                    double.tryParse(text.replaceAll(' ', '')) ??
                                        0,
                              );
                            },
                            focusNode: initialSupplyFocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(23),
                              AmountTextInputFormatter(
                                precision: 8,
                              ),
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
