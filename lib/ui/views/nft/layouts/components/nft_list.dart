/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/nft_category.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_list_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTList extends ConsumerWidget {
  const NFTList({super.key, required this.currentNftCategoryIndex});
  final int currentNftCategoryIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;

    final nftCategories = ref
        .read(
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

    final accountTokenList =
        accountSelected?.getAccountNFTFiltered(nftCategory.id) ?? [];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          primary: false,
          shrinkWrap: true,
          itemCount: accountTokenList.length,
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          itemBuilder: (context, index) {
            final tokenInformations =
                accountTokenList[index].tokenInformations!;

            return NFTListDetail(
              tokenInformations: tokenInformations,
              index: index,
            );
          },
        ),
      ),
    );
  }
}
