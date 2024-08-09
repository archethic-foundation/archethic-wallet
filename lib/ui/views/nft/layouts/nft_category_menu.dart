/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/nft/nft_category.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/responsive.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/card_category.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NftCategoryMenu extends ConsumerWidget {
  const NftCategoryMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAccount = ref.watch(
      AccountProviders.accounts.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );

    final nftCategories = ref
        .watch(
          NftCategoryProviders.selectedAccountNftCategories(
            context: context,
          ),
        )
        .valueOrNull;

    if (selectedAccount == null || nftCategories == null) {
      return const SizedBox();
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            Responsive.isDesktop(context) || Responsive.isTablet(context)
                ? 3
                : 2,
        crossAxisSpacing: 20,
        childAspectRatio: 1.3,
      ),
      itemCount: nftCategories.length,
      itemBuilder: (context, index) {
        var count = 0;
        count = ref.read(
          NftCategoryProviders.getNbNFTInCategory(
            account: selectedAccount,
            categoryNftIndex: nftCategories[index].id,
          ),
        );
        return Stack(
          children: [
            CardCategory(
              categoryName: nftCategories[index].name!,
              index: index,
              id: nftCategories[index].id,
            ),
            if (count > 0)
              Positioned(
                right: 10,
                top: 5,
                child: badge.Badge(
                  badgeAnimation: const badge.BadgeAnimation.slide(
                    toAnimate: false,
                  ),
                  badgeContent: Text(
                    count.toString(),
                    style: ArchethicThemeStyles.textStyleSize10W100Primary,
                  ),
                ),
              ),
          ],
        )
            .animate()
            .fade(duration: Duration(milliseconds: 300 + (index * 50)))
            .scale(duration: Duration(milliseconds: 300 + (index * 50)));
      },
    );
  }
}
