/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/localization.dart';

class NftCategory {
  NftCategory({this.id, this.name, this.image});

  int? id;
  String? name;
  String? image;

  static List<NftCategory> getListByDefault(BuildContext context) {
    return [
      NftCategory(
          id: 0,
          name: AppLocalization.of(context)!.nftWithoutCategory,
          image: 'assets/images/category_nft_without.jpg'),
      NftCategory(
          id: 1,
          name: AppLocalization.of(context)!.nftCategoryArt,
          image: 'assets/images/category_nft_art.jpg'),
      NftCategory(
          id: 2,
          name: AppLocalization.of(context)!.nftCategoryAccess,
          image: 'assets/images/category_nft_access.jpg'),
      NftCategory(
          id: 3,
          name: AppLocalization.of(context)!.nftCategoryCollectibles,
          image: 'assets/images/category_nft_collectibles.jpg'),
      NftCategory(
          id: 4,
          name: AppLocalization.of(context)!.nftCategoryMusic,
          image: 'assets/images/category_nft_music.jpg'),
      NftCategory(
          id: 5,
          name: AppLocalization.of(context)!.nftCategoryDoc,
          image: 'assets/images/category_nft_doc.jpg'),
      NftCategory(
          id: 6,
          name: AppLocalization.of(context)!.nftCategoryLoyaltyCard,
          image: 'assets/images/category_nft_loyalty_card.jpg')
    ];
  }
}
