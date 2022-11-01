/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../nft_creation_process_sheet.dart';

class NFTCreationProcessPropertiesTab extends ConsumerStatefulWidget {
  const NFTCreationProcessPropertiesTab({
    super.key,
  });

  @override
  ConsumerState<NFTCreationProcessPropertiesTab> createState() =>
      _NFTCreationProcessPropertiesTabState();
}

class _NFTCreationProcessPropertiesTabState
    extends ConsumerState<NFTCreationProcessPropertiesTab> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final nftCreation = ref.watch(NftCreationFormProvider.nftCreationForm);
    final nftCreationNotifier =
        ref.watch(NftCreationFormProvider.nftCreationForm.notifier);

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
            /*    Align(
              child: Text(
                addNFTPropertyMessage,
                textAlign: TextAlign.center,
                style: theme.textStyleSize12W100Primary,
              ),
            ),*/
            Row(
              children: <Widget>[
                //   if (nftCreation.canAddProperty)
                AppButtonTiny(
                  AppButtonTinyType.primary,
                  AppLocalization.of(context)!.addNFTProperty,
                  Dimens.buttonBottomDimens,
                  key: const Key('addNFTProperty'),
                  onPressed: () async {
                    if (nftCreationNotifier.controlAddNFTProperty(context)) {
                      // TODO(reddwarf03): manage
                      /* nftCreationNotifier.setProperty(
                        nftPropertyNameController.text,
                        nftPropertyValueController.text,
                      );
                      nftPropertyNameController.text = '';
                      nftPropertyValueController.text = '';*/
                    }
                  },
                )
                /*  else
                  AppButton.buildAppButtonTiny(
                    const Key('addNFTProperty'),
                    context,
                    ref,
                    AppButtonType.primaryOutline,
                    AppLocalization.of(context)!.addNFTProperty,
                    Dimens.buttonBottomDimens,
                    onPressed: () {},
                  ),*/
              ],
            ),
            const NFTCreationProcessPropertiesTabTextfieldSearch(),
            if (nftCreation.properties.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Wrap(
                  children:
                      List.generate(nftCreation.properties.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: NFTCreationProcessPropertyAccess(
                        propertyName:
                            nftCreation.properties[index].propertyName,
                        propertyValue:
                            nftCreation.properties[index].propertyValue,
                        publicKeys: nftCreation.properties[index].publicKeys,
                        propertiesHidden: const [
                          'file',
                          'type/mime',
                          'name',
                          'description'
                        ],
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
