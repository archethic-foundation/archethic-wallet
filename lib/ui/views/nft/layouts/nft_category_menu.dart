/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/nft/nft_category.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/responsive.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NftCategoryMenu extends ConsumerWidget {
  const NftCategoryMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
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

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
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
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: theme.backgroundDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(
                            color: Colors.white10,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(nftCategories[index].image),
                        ),
                      ),
                    ),
                    if (count > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: badge.Badge(
                          badgeAnimation: const badge.BadgeAnimation.slide(
                            toAnimate: false,
                          ),
                          badgeContent: Text(count.toString()),
                        ),
                      ),
                  ],
                ),
                Text(
                  nftCategories[index].name!,
                  textAlign: TextAlign.center,
                  style: theme.textStyleSize12W400Primary,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
