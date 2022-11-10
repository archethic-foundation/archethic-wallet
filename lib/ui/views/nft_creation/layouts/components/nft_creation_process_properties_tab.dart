/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessPropertiesTab extends ConsumerWidget {
  const NFTCreationProcessPropertiesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final nftCreationArgs = ref.read(
      NftCreationFormProvider.nftCreationFormArgs,
    );
    final nftCreation =
        ref.watch(NftCreationFormProvider.nftCreationForm(nftCreationArgs));
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm(nftCreationArgs).notifier,
    );

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                localizations.nftPropertyExplanation,
                style: theme.textStyleSize12W100Primary,
                textAlign: TextAlign.justify,
              ),
            ),
            const CategoryTemplateForm(),
            const NFTCreationProcessPropertiesTabTextfieldName(),
            const SizedBox(
              height: 30,
            ),
            const NFTCreationProcessPropertiesTabTextfieldValue(),
            Row(
              children: <Widget>[
                if (nftCreation.canAddProperty)
                  AppButtonTiny(
                    AppButtonTinyType.primary,
                    AppLocalization.of(context)!.addNFTProperty,
                    Dimens.buttonBottomDimens,
                    key: const Key('addNFTProperty'),
                    icon: Icon(
                      Icons.add,
                      color: theme.text,
                      size: 14,
                    ),
                    onPressed: () {
                      if (nftCreationNotifier.controlAddNFTProperty(context)) {
                        nftCreationNotifier.setProperty(
                          nftCreation.propertyName,
                          nftCreation.propertyValue,
                        );
                      }
                    },
                  )
                else
                  AppButtonTiny(
                    AppButtonTinyType.primaryOutline,
                    AppLocalization.of(context)!.addNFTProperty,
                    Dimens.buttonBottomDimens,
                    key: const Key('addNFTProperty'),
                    icon: Icon(
                      Icons.add,
                      color: theme.text30,
                      size: 14,
                    ),
                    onPressed: () {},
                  ),
              ],
            ),
            const NFTCreationProcessPropertiesTabTextfieldSearch(),
            const NFTCreationProcessPropertiesList(),
          ],
        ),
      ),
    );
  }
}
