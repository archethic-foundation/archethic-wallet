/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../../nft_creation_process_sheet.dart';

class NFTCreationProcessPropertiesList extends ConsumerWidget {
  const NFTCreationProcessPropertiesList({
    super.key,
    this.readOnly = false,
  });

  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nftCreation = ref.watch(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ),
    );

    var propertiesFiltered = [];
    if (nftCreation.propertySearch.isEmpty) {
      propertiesFiltered = nftCreation.properties;
    } else {
      propertiesFiltered = nftCreation.properties
          .where(
            (element) =>
                element.propertyName.contains(nftCreation.propertySearch),
          )
          .toList();
    }

    if (propertiesFiltered.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Wrap(
        children: List.generate(propertiesFiltered.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: NFTCreationProcessPropertyAccess(
              propertyName: propertiesFiltered[index].propertyName,
              propertyValue: propertiesFiltered[index].propertyValue,
              propertiesHidden: const [
                'content',
                'type_mime',
                'name',
                'description'
              ],
              readOnly: readOnly,
            ),
          );
        }),
      ),
    );
  }
}
