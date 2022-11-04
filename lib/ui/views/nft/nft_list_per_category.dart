/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/nft_category.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/nft_header.dart';
import 'package:aewallet/ui/views/nft/nft_list.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTListPerCategory extends ConsumerWidget {
  const NFTListPerCategory({super.key, this.currentNftCategoryIndex});
  final int? currentNftCategoryIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final accountSelected =
        ref.read(AccountProviders.getSelectedAccount(context: context));
    final nftCategories = ref.read(
      NftCategoryProviders.fetchNftCategory(
        context: context,
        account: accountSelected!,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              theme.background2Small!,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[theme.backgroundDark!, theme.background!],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            child: Column(
              children: <Widget>[
                NFTHeader(
                    currentNftCategoryIndex: currentNftCategoryIndex ?? 0,
                    displayCategoryName: true),
                NFTList(
                  currentNftCategoryIndex: currentNftCategoryIndex,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
