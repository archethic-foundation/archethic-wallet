/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/nft/nft_category.dart';
import 'package:aewallet/model/nft_category.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NftCategoryDialog {
  static Future<NftCategory?> getDialog(
    BuildContext context,
    WidgetRef ref,
    String tokenId,
  ) async {
    final pickerItemsList = List<PickerItem>.empty(growable: true);
    final listNftCategory = await ref.read(
      NftCategoryProviders.selectedAccountNftCategories(
        context: context,
      ).future,
    );
    final selectedAccount =
        ref.watch(AccountProviders.selectedAccount).valueOrNull!;
    final nftInfosOffChain = selectedAccount.getftInfosOffChain(
      // TODO(redDwarf03): we should not interact directly with Hive DTOs. Use providers instead. -> which provider / Link to NFT ? (3)
      tokenId,
    );

    for (final nftCategory in listNftCategory) {
      pickerItemsList.add(
        PickerItem(
          nftCategory.name.toString(),
          null,
          nftCategory.image,
          null,
          nftCategory,
          true,
        ),
      );
    }
    return showDialog<NftCategory>(
      context: context,
      builder: (BuildContext context) {
        final localizations = AppLocalizations.of(context)!;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              insetPadding: const EdgeInsets.only(
                top: 100,
                bottom: 100,
                left: 20,
                right: 20,
              ),
              alignment: Alignment.topCenter,
              title: Column(
                children: [
                  Text(
                    localizations.nftCategory,
                    style: ArchethicThemeStyles.textStyleSize24W700Primary,
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                side: BorderSide(
                  color: ArchethicTheme.text45,
                ),
              ),
              content: SingleChildScrollView(
                child: PickerWidget(
                  pickerItems: pickerItemsList,
                  selectedIndexes: [nftInfosOffChain!.categoryNftIndex ?? 0],
                  onSelected: (value) {
                    Navigator.pop(context, value.value);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
