/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../../nft_creation_process_sheet.dart';

class NFTCreationProcessInfosTabTextFieldDescription
    extends ConsumerStatefulWidget {
  const NFTCreationProcessInfosTabTextFieldDescription({
    super.key,
  });

  @override
  ConsumerState<NFTCreationProcessInfosTabTextFieldDescription> createState() =>
      _NFTCreationProcessInfosTabTextFieldDescriptionState();
}

class _NFTCreationProcessInfosTabTextFieldDescriptionState
    extends ConsumerState<NFTCreationProcessInfosTabTextFieldDescription> {
  late FocusNode nftDescriptionFocusNode;
  late TextEditingController nftDescriptionController;

  @override
  void initState() {
    super.initState();
    nftDescriptionFocusNode = FocusNode();
    final nftCreation = ref.read(
      NftCreationFormProvider.nftCreationForm,
    );
    nftDescriptionController =
        TextEditingController(text: nftCreation.description);
  }

  @override
  void dispose() {
    nftDescriptionFocusNode.dispose();
    nftDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm.notifier,
    );

    ref.listen<NftCreationFormState>(
      NftCreationFormProvider.nftCreationForm,
      (_, nftCreation) {
        if (nftCreation.description != nftDescriptionController.text) {
          nftDescriptionController.text = nftCreation.description;
        }
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.nftDescriptionHint,
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              maxLines: 6,
                              autocorrect: false,
                              controller: nftDescriptionController,
                              onChanged: nftCreationNotifier.setDescription,
                              focusNode: nftDescriptionFocusNode,
                              textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.multiline,
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(200),
                              ],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10),
                              ),
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
