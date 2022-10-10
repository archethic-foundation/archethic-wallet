/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/nft_category.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/nft_list.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTListPerCategory extends ConsumerWidget {
  const NFTListPerCategory({super.key, this.currentNftCategoryIndex});
  final int? currentNftCategoryIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.read(ThemeProviders.theme);
    final nftCategories = ref.read(
      NftCategoryProviders.fetchNftCategory(
        context,
        StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!,
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
          builder: (BuildContext context, BoxConstraints constraints) => SafeArea(
            child: Column(
              children: <Widget>[
                Row(
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
                    BalanceIndicatorWidget(
                      primaryCurrency: StateContainer.of(context).curPrimaryCurrency,
                      displaySwitchButton: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      child: Column(
                        children: [
                          Hero(
                            tag: 'nftCategory${nftCategories[currentNftCategoryIndex!].name!}',
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
                                  nftCategories[currentNftCategoryIndex!].image,
                                  width: 50,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            nftCategories[currentNftCategoryIndex!].name!,
                            textAlign: TextAlign.center,
                            style: theme.textStyleSize12W100Primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: NFTList(
                      currentNftCategoryIndex: currentNftCategoryIndex,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
