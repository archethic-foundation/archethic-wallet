/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/nft_category.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nft_category.g.dart';

@riverpod
NFTCategoryRepository _nftCategoryRepository(_NftCategoryRepositoryRef ref) =>
    NFTCategoryRepository();

@riverpod
List<NftCategory> _fetchNftCategory(
  _FetchNftCategoryRef ref,
  BuildContext context,
  Account account,
) {
  final nftCategoryAccountSelectedList = ref
      .read(_nftCategoryRepositoryProvider)
      .getListNftCategory(context, account);
  if (nftCategoryAccountSelectedList.isNotEmpty) {
    return nftCategoryAccountSelectedList;
  }

  return ref.read(_nftCategoryRepositoryProvider).getListByDefault(context);
}

@riverpod
int _getNbNFTInCategory(
  _GetNbNFTInCategoryRef ref, {
  required Account account,
  required int categoryNftIndex,
}) {
  var count = 0;
  if (account.nftInfosOffChainList == null ||
      account.nftInfosOffChainList!.isEmpty) {
    return count;
  }

  for (final accountToken in account.accountNFT!) {
    final nftInfosOffChain = account.nftInfosOffChainList!
        .where(
          (element) => element.id == accountToken.tokenInformations!.id,
        )
        .firstOrNull;
    if (nftInfosOffChain!.categoryNftIndex == categoryNftIndex) {
      count++;
    }
  }
  return count;
}

@riverpod
List<NftCategory> _getListByDefault(
  _GetListByDefaultRef ref, {
  required BuildContext context,
}) {
  return ref.read(_nftCategoryRepositoryProvider).getListByDefault(context);
}

@riverpod
Future<void> _updateNftCategoryList(
  _UpdateNftCategoryListRef ref, {
  required List<NftCategory> nftCategoryListCustomized,
  required Account account,
}) async {
  return ref.watch(_nftCategoryRepositoryProvider).updateNftCategoryList(
        nftCategoryListCustomized,
        account,
      );
}

class NFTCategoryRepository {
  List<NftCategory> getListNftCategory(
    BuildContext context,
    Account account,
  ) {
    final listNftCategoryByDefault = getListByDefault(context);
    if (account.nftCategoryList == null) {
      return listNftCategoryByDefault;
    }

    final nftCategoryListCustomized = List<NftCategory>.empty(growable: true);
    for (final nftCategoryId in account.nftCategoryList!) {
      nftCategoryListCustomized.add(
        listNftCategoryByDefault
            .where((element) => element.id == nftCategoryId)
            .single,
      );
    }
    return nftCategoryListCustomized;
  }

  Future<void> updateNftCategoryList(
    List<NftCategory> nftCategoryListCustomized,
    Account account,
  ) async {
    account.nftCategoryList ??= List<int>.empty(growable: true);
    account.nftCategoryList!.clear();
    for (final nftCategory in nftCategoryListCustomized) {
      account.nftCategoryList!.add(nftCategory.id);
    }

    await account.updateAccount();
  }

  List<NftCategory> getListByDefault(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    return [
      NftCategory(
        id: 0,
        name: localizations.nftWithoutCategory,
        image: 'assets/images/category_nft_without.jpg',
      ),
      NftCategory(
        id: 1,
        name: localizations.nftCategoryArt,
        image: 'assets/images/category_nft_art.jpg',
      ),
      NftCategory(
        id: 2,
        name: localizations.nftCategoryAccess,
        image: 'assets/images/category_nft_access.jpg',
      ),
      NftCategory(
        id: 3,
        name: localizations.nftCategoryCollectibles,
        image: 'assets/images/category_nft_collectibles.jpg',
      ),
      NftCategory(
        id: 4,
        name: localizations.nftCategoryMusic,
        image: 'assets/images/category_nft_music.jpg',
      ),
      NftCategory(
        id: 5,
        name: localizations.nftCategoryDoc,
        image: 'assets/images/category_nft_doc.jpg',
      ),
      NftCategory(
        id: 6,
        name: localizations.nftCategoryLoyaltyCard,
        image: 'assets/images/category_nft_loyalty_card.jpg',
      )
    ];
  }

  String getDescriptionHeader(BuildContext context, int id) {
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

abstract class NftCategoryProviders {
  static final fetchNftCategory = _fetchNftCategoryProvider;
  static final getNbNFTInCategory = _getNbNFTInCategoryProvider;
  static final getListByDefault = _getListByDefaultProvider;
  static final updateNftCategoryList = _updateNftCategoryListProvider;
}
