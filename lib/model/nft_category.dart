/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/localization.dart';
import 'package:flutter/material.dart';

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
        image: 'assets/images/category_nft_without.jpg',
      ),
      NftCategory(
        id: 1,
        name: AppLocalization.of(context)!.nftCategoryArt,
        image: 'assets/images/category_nft_art.jpg',
      ),
      NftCategory(
        id: 2,
        name: AppLocalization.of(context)!.nftCategoryAccess,
        image: 'assets/images/category_nft_access.jpg',
      ),
      NftCategory(
        id: 3,
        name: AppLocalization.of(context)!.nftCategoryCollectibles,
        image: 'assets/images/category_nft_collectibles.jpg',
      ),
      NftCategory(
        id: 4,
        name: AppLocalization.of(context)!.nftCategoryMusic,
        image: 'assets/images/category_nft_music.jpg',
      ),
      NftCategory(
        id: 5,
        name: AppLocalization.of(context)!.nftCategoryDoc,
        image: 'assets/images/category_nft_doc.jpg',
      ),
      NftCategory(
        id: 6,
        name: AppLocalization.of(context)!.nftCategoryLoyaltyCard,
        image: 'assets/images/category_nft_loyalty_card.jpg',
      )
    ];
  }

  static String getDescriptionHearder(BuildContext context, int id) {
    switch (id) {
      case 0:
        return 'Import a photo, a document, a piece of information, or any other element that you wish to transform into a non-fungible token.';
      case 1:
        return 'Import a photo, an image or a video.';
      case 2:
        return 'Import a ticket to access an event or a location.';
      case 3:
        return 'Create your collections';
      case 4:
        return 'Import a piece of music or a recording';
      case 5:
        return 'Import a document PDF';
      case 6:
        return 'Import a loyalty card';
      default:
        return 'Import a photo, a document, a piece of information, or any other element that you wish to transform into a non-fungible token.';
    }
  }
}
