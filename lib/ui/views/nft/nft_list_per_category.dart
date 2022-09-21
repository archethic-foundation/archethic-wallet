/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/model/nft_category.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/nft_list.dart';
import 'package:aewallet/ui/widgets/components/balance_indicator.dart';

class NFTListPerCategory extends StatelessWidget {
  final int? currentNftCategoryIndex;
  const NFTListPerCategory({super.key, this.currentNftCategoryIndex});

  @override
  Widget build(BuildContext context) {
    List<NftCategory> nftCategories = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!
        .getListNftCategory(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  StateContainer.of(context).curTheme.background2Small!),
              fit: BoxFit.fitHeight),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              StateContainer.of(context).curTheme.backgroundDark!,
              StateContainer.of(context).curTheme.background!
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsetsDirectional.only(
                              start: smallScreen(context) ? 15 : 20),
                          height: 50,
                          width: 50,
                          child: BackButton(
                            key: const Key('back'),
                            color: StateContainer.of(context).curTheme.text,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    BalanceIndicatorWidget(
                        primaryCurrency:
                            StateContainer.of(context).curPrimaryCurrency,
                        displaySwitchButton: false),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      child: Column(
                        children: [
                          Hero(
                            tag:
                                'nftCategory${nftCategories[currentNftCategoryIndex!].name!}',
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
                                  nftCategories[currentNftCategoryIndex!]
                                      .image!,
                                  width: 50,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            nftCategories[currentNftCategoryIndex!].name!,
                            textAlign: TextAlign.center,
                            style:
                                AppStyles.textStyleSize12W100Primary(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: NFTList(
                        images: StateContainer.of(context).imagesNFT!,
                        currentNftCategoryIndex: currentNftCategoryIndex),
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
