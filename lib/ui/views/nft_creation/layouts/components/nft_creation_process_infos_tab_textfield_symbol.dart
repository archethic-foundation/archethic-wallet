/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

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
    nftSymbolController = TextEditingController();
  }

  @override
  void dispose() {
    nftSymbolFocusNode.dispose();
    nftSymbolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;

    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ).notifier,
    );

    ref.listen<NftCreationFormState>(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ),
      (_, nftCreation) {
        if (nftCreation.symbol != nftSymbolController.text) {
          nftSymbolController.text = nftCreation.symbol;
        }
      },
    );

    return Column(
      children: [
        AppTextField(
          focusNode: nftSymbolFocusNode,
          controller: nftSymbolController,
          cursorColor: theme.text,
          textInputAction: TextInputAction.next,
          labelText: localizations.tokenSymbolHint,
          autocorrect: false,
          keyboardType: TextInputType.text,
          style: theme.textStyleSize16W600Primary,
          inputFormatters: [
            UpperCaseTextFormatter(),
            LengthLimitingTextInputFormatter(10),
          ],
          onChanged: (text) async {
            nftCreationNotifier.setSymbol(
              text,
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
