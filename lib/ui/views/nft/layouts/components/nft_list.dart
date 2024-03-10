/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/nft/nft_category.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/responsive.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_list_detail.dart';
import 'package:aewallet/ui/widgets/components/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTList extends ConsumerWidget {
  const NFTList({super.key, required this.currentNftCategoryIndex});
  final int currentNftCategoryIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;

    final nftCategories = ref
        .watch(
          NftCategoryProviders.selectedAccountNftCategories(
            context: context,
          ),
        )
        .valueOrNull;

    if (nftCategories == null) return const SizedBox();

    final nftCategory = nftCategories
        .where(
          (element) => element.id == currentNftCategoryIndex,
        )
        .first;

    final accountTokenList = ref.watch(
      AccountProviders.getAccountNFTFiltered(accountSelected!, nftCategory.id),
    );

    if (accountTokenList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Text(
              localizations.nftListEmptyExplanation,
              style: ArchethicThemeStyles.textStyleSize12W100Primary,
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: DynamicHeightGridView(
        crossAxisCount:
            Responsive.isDesktop(context) || Responsive.isTablet(context)
                ? 3
                : 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 40,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: accountTokenList.length,
        builder: (context, index) {
          final tokenInformation = accountTokenList[index].tokenInformation!;
          return NFTListDetail(
            address: tokenInformation.address ?? '',
            name: tokenInformation.name ?? '',
            properties: tokenInformation.tokenProperties ?? {},
            symbol: tokenInformation.symbol ?? '',
            tokenId: tokenInformation.id ?? '',
            collection: tokenInformation.tokenCollection ?? [],
            index: index,
            roundBorder: true,
          );
        },
      ),
    );
  }
}
