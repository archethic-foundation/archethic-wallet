/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/model/nft_category.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:badges/badges.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NftCategoryMenu extends StatelessWidget {
  const NftCategoryMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey expandedKey = GlobalKey();
    return SliverPadding(
      key: expandedKey,
      padding: const EdgeInsets.only(top: 10, bottom: 170, left: 20, right: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.8,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: NftCategory.getList(context).length + 1,
          (context, index) {
            int count = 0;
            if (index != NftCategory.getList(context).length) {
              count = StateContainer.of(context)
                  .appWallet!
                  .appKeychain!
                  .getAccountSelected()!
                  .getNbNFTInCategory(NftCategory.getList(context)[index].id!);
            }

            return index != NftCategory.getList(context).length
                ? InkWell(
                    onTap: (() {
                      sl.get<HapticUtil>().feedback(FeedbackType.light,
                          StateContainer.of(context).activeVibrations);
                      Navigator.of(context).pushNamed('/nft_list_per_category',
                          arguments: NftCategory.getList(context)[index].id!);
                    }),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Hero(
                              tag:
                                  'nftCategory${NftCategory.getList(context)[index].name!}',
                              child: Card(
                                elevation: 5,
                                shadowColor: Colors.black,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .backgroundDark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(
                                      color: Colors.white10, width: 1),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                      NftCategory.getList(context)[index]
                                          .image!),
                                ),
                              ),
                            ),
                            if (count > 0)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Badge(
                                  toAnimate: false,
                                  badgeContent: Text(count.toString()),
                                  badgeColor: Colors.red,
                                ),
                              ),
                          ],
                        ),
                        Text(
                          NftCategory.getList(context)[index].name!,
                          textAlign: TextAlign.center,
                          style: AppStyles.textStyleSize12W100Primary(context),
                        ),
                      ],
                    ),
                  )
                : InkWell(
                    onTap: (() {
                      sl.get<HapticUtil>().feedback(FeedbackType.light,
                          StateContainer.of(context).activeVibrations);
                    }),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Card(
                              elevation: 5,
                              shadowColor: Colors.black,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(
                                    color: Colors.white10, width: 1),
                              ),
                              child: ClipRRect(
                                child: DottedBorder(
                                  color: Colors.white.withOpacity(0.7),
                                  strokeWidth: 3,
                                  child: Image.asset(
                                      'assets/images/categorie_nft_add.png'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 17, top: 55),
                              child: Text(
                                '+ Add category',
                                style: AppStyles.textStyleSize12W100Primary(
                                    context),
                              ),
                            ),
                          ],
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
