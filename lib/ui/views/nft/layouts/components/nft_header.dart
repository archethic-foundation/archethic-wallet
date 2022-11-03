/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/nft_category.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTHeader extends ConsumerWidget {
  const NFTHeader({
    super.key,
    required this.currentNftCategoryIndex,
    this.displayCategoryName = false,
  });
  final int currentNftCategoryIndex;
  final bool displayCategoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final accountSelected = ref.read(AccountProviders.selectedAccount);
    final nftCategories = ref.read(
      NftCategoryProviders.fetchNftCategory(
        context: context,
        account: accountSelected!,
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsetsDirectional.only(
                start: smallScreen(context) ? 15 : 20,
              ),
              height: 50,
              width: 50,
              child: BackButton(
                key: const Key('back'),
                color: theme.text,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        const BalanceIndicatorWidget(
          displaySwitchButton: false,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 10),
          child: Column(
            children: [
              Hero(
                tag:
                    'nftCategory${nftCategories[currentNftCategoryIndex].name!}',
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
                    child: Image.asset(
                      nftCategories[currentNftCategoryIndex].image,
                      width: 50,
                    ),
                  ),
                ),
              ),
              if (displayCategoryName)
                Text(
                  nftCategories[currentNftCategoryIndex].name!,
                  textAlign: TextAlign.center,
                  style: theme.textStyleSize12W100Primary,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
