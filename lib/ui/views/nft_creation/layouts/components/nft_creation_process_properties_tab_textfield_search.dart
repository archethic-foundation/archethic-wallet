/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessPropertiesTabTextfieldSearch
    extends ConsumerStatefulWidget {
  const NFTCreationProcessPropertiesTabTextfieldSearch({
    super.key,
  });
  @override
  ConsumerState<NFTCreationProcessPropertiesTabTextfieldSearch> createState() =>
      _NFTCreationProcessPropertiesTabTextfieldSearchState();
}

class _NFTCreationProcessPropertiesTabTextfieldSearchState
    extends ConsumerState<NFTCreationProcessPropertiesTabTextfieldSearch> {
  late TextEditingController nftPropertySearchController;

  @override
  void initState() {
    super.initState();
    nftPropertySearchController = TextEditingController();
  }

  @override
  void dispose() {
    nftPropertySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ).notifier,
    );

    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: AppTextField(
        controller: nftPropertySearchController,
        autocorrect: false,
        labelText: AppLocalizations.of(context)!.searchField,
        keyboardType: TextInputType.text,
        style: theme.textStyleSize16W600Primary,
        onChanged: (text) {
          nftCreationNotifier.setPropertySearch(text);
        },
      ),
    );
  }
}
