/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../../nft_creation_process_sheet.dart';

class NFTCreationProcessInfosTabTextFieldSymbol extends ConsumerStatefulWidget {
  const NFTCreationProcessInfosTabTextFieldSymbol({
    super.key,
  });

  @override
  ConsumerState<NFTCreationProcessInfosTabTextFieldSymbol> createState() =>
      _NFTCreationProcessInfosTabTextFieldSymbolState();
}

class _NFTCreationProcessInfosTabTextFieldSymbolState
    extends ConsumerState<NFTCreationProcessInfosTabTextFieldSymbol> {
  late FocusNode nftSymbolFocusNode;
  late TextEditingController nftSymbolController;

  @override
  void initState() {
    super.initState();
    nftSymbolFocusNode = FocusNode();
    final nftCreation = ref.read(
      NftCreationFormProvider.nftCreationForm,
    );
    nftSymbolController = TextEditingController(text: nftCreation.symbol);
  }

  @override
  void dispose() {
    nftSymbolFocusNode.dispose();
    nftSymbolController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final localizations = AppLocalizations.of(context)!;

    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm.notifier,
    );

    ref.listen<NftCreationFormState>(
      NftCreationFormProvider.nftCreationForm,
      (_, nftCreation) {
        if (nftCreation.symbol != nftSymbolController.text) {
          nftSymbolController.text = nftCreation.symbol;
        }
      },
    );

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
          child: Column(
            children: [
              Row(
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
                                key: const Key('nftCreationField'),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                autocorrect: false,
                                controller: nftSymbolController,
                                onChanged: nftCreationNotifier.setSymbol,
                                focusNode: nftSymbolFocusNode,
                                textInputAction: TextInputAction.done,
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
                  style: ArchethicThemeStyles.textStyleSize10W100Primary,
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
