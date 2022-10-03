/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/model/nft_category.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
// Package imports:
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NftCategoryMenu extends StatelessWidget {
  const NftCategoryMenu({super.key, required this.nftCategories});
  final List<NftCategory> nftCategories;

  @override
  Widget build(BuildContext context) {
    final expandedKey = GlobalKey();

    return SliverPadding(
      key: expandedKey,
      padding: const EdgeInsets.only(top: 10, bottom: 170, left: 20, right: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.8,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: nftCategories.length,
          (context, index) {
            var count = 0;

            count = StateContainer.of(context)
                .appWallet!
                .appKeychain!
                .getAccountSelected()!
                .getNbNFTInCategory(index);

            return InkWell(
              onTap: () {
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      StateContainer.of(context).activeVibrations,
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
                          color: StateContainer.of(context)
                              .curTheme
                              .backgroundDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                              color: Colors.white10,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(nftCategories[index].image!),
                          ),
                        ),
                      ),
                      if (count > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Badge(
                            toAnimate: false,
                            badgeContent: Text(count.toString()),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    nftCategories[index].name!,
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyleSize12W100Primary(context),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
