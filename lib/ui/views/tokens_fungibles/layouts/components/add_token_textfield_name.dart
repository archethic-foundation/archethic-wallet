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
    final addTokenNotifier =
        ref.watch(AddTokenFormProvider.addTokenForm.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.tokenNameHint,
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
                                ArchethicTheme.gradientInputFormBackground,
                          ),
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            autocorrect: false,
                            controller: nameController,
                            onChanged: (text) async {
                              await addTokenNotifier.setName(
                                context: context,
                                name: text,
                              );
                            },
                            focusNode: nameFocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(40),
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
