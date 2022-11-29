/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/nft/nft_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryTemplateForm extends ConsumerWidget {
  const CategoryTemplateForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listNftCategory = ref
        .watch(
          NftCategoryProviders.selectedAccountNftCategories(
            context: context,
          ),
        )
        .valueOrNull;

    if (listNftCategory == null) return const SizedBox();

    return const SizedBox();
    // TODO(reddwarf03): create an issue for this feature
    /*
    switch (nftCreation.currentNftCategoryIndex) {
      case 4:
        final nftPropertyAuthorFocusNode = FocusNode();
        final nftPropertyAuthorController = TextEditingController();
        final nftPropertyCompositorFocusNode = FocusNode();
        final nftPropertyCompositorController = TextEditingController();
        return Column(
          children: [
            Text(
              localizations.nftPropertiesRequiredByCategory,
              style: theme.textStyleSize12W100Primary,
              textAlign: TextAlign.justify,
            ),
            NftPropertyAppTextField(
              focusNode: nftPropertyAuthorFocusNode,
              textEditingController: nftPropertyAuthorController,
              hint: 'Compositor',
              propertyKey: 'Compositor',
            ),
            NftPropertyAppTextField(
              focusNode: nftPropertyCompositorFocusNode,
              textEditingController: nftPropertyCompositorController,
              hint: 'Author',
              propertyKey: 'Author',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Divider(
                height: 2,
                color: theme.text15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Optional properties:',
                style: theme.textStyleSize12W100Primary,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        );
      case 6:
        final nftPropertyNameStoreFocusNode = FocusNode();
        final nftPropertyNameStoreController = TextEditingController();
        final nftPropertyIdCardFocusNode = FocusNode();
        final nftPropertyIdCardController = TextEditingController();
        final nftPropertyExpiryDateFocusNode = FocusNode();
        final nftPropertyxpiryDateController = TextEditingController();
        return Column(
          children: [
            Text(
              localizations.nftPropertiesRequiredByCategory,
              style: theme.textStyleSize12W100Primary,
              textAlign: TextAlign.justify,
            ),
            NftPropertyAppTextField(
              focusNode: nftPropertyNameStoreFocusNode,
              textEditingController: nftPropertyNameStoreController,
              hint: 'Name of the store',
              propertyKey: 'Name of the store',
            ),
            NftPropertyAppTextField(
              focusNode: nftPropertyIdCardFocusNode,
              textEditingController: nftPropertyIdCardController,
              hint: 'Id Card',
              propertyKey: 'Id Card',
            ),
            NftPropertyAppTextField(
              focusNode: nftPropertyExpiryDateFocusNode,
              textEditingController: nftPropertyxpiryDateController,
              hint: 'Expiry date',
              propertyKey: 'Expiry Date',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Divider(
                height: 2,
                color: theme.text15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Optional properties:',
                style: theme.textStyleSize12W100Primary,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        );

      default:
        return const SizedBox();
    }*/
  }
}
