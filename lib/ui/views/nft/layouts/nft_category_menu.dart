/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/nft/nft_category.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/responsive.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/card_category.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NftCategoryMenu extends ConsumerWidget {
  const NftCategoryMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAccount =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;
    final preferences = ref.watch(SettingsProviders.settings);

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
        childAspectRatio: 0.8,
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
        return InkWell(
          key: Key('nftCategory$index'),
          onTap: () {
            sl.get<HapticUtil>().feedback(
                  FeedbackType.light,
                  preferences.activeVibrations,
                );
            Navigator.of(context).pushNamed(
              '/nft_list_per_category',
              arguments: nftCategories[index].id,
            );
          },
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: 'nftCategory${nftCategories[index].name!}',
                    child: CardCategory(
                      background: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          nftCategories[index].image,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  if (count > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 12, top: 12),
                      child: badge.Badge(
                        badgeAnimation: const badge.BadgeAnimation.slide(
                          toAnimate: false,
                        ),
                        badgeContent: Text(
                          count.toString(),
                          style:
                              ArchethicThemeStyles.textStyleSize10W100Primary,
                        ),
                      ),
                    ),
                ],
              ),
              Text(
                nftCategories[index].name!,
                textAlign: TextAlign.center,
                style: ArchethicThemeStyles.textStyleSize12W400Primary,
              ),
            ],
          ),
        )
            .animate()
            .fade(duration: Duration(milliseconds: 300 + (index * 50)))
            .scale(duration: Duration(milliseconds: 300 + (index * 50)));
      },
    );
  }
}
