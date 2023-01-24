/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
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
Future<List<NftCategory>> _selectedAccountNftCategories(
  _SelectedAccountNftCategoriesRef ref, {
  required BuildContext context,
}) async {
  final selectedAccount =
      await ref.watch(AccountProviders.selectedAccount.future);

  if (selectedAccount == null) {
    return ref.watch(_nftCategoryRepositoryProvider).getListByDefault(context);
  }

  return ref.watch(
    _fetchNftCategoryProvider(
      context: context,
      account: selectedAccount,
    ),
  );
}

@riverpod
List<NftCategory> _fetchNftCategory(
  _FetchNftCategoryRef ref, {
  required BuildContext context,
  required Account account,
}) {
  final nftCategoryAccountSelectedList = ref
      .watch(_nftCategoryRepositoryProvider)
      .getListNftCategory(context, account);
  if (nftCategoryAccountSelectedList.isNotEmpty) {
    return nftCategoryAccountSelectedList;
  }

  return ref.watch(_nftCategoryRepositoryProvider).getListByDefault(context);
}

@riverpod
int _getNbNFTInCategory(
  _GetNbNFTInCategoryRef ref, {
  required Account account,
  required int categoryNftIndex,
}) {
  var count = 0;
  if (account.nftInfosOffChainList == null ||
      account.nftInfosOffChainList!.isEmpty ||
      account.accountNFT == null) {
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
  ref.watch(_nftCategoryRepositoryProvider).updateNftCategoryList(
        nftCategoryListCustomized,
        account,
      );
  return;
}

@riverpod
String _getDescriptionHeader(
  _GetDescriptionHeaderRef ref, {
  required BuildContext context,
  required int id,
}) {
  return ref
      .read(_nftCategoryRepositoryProvider)
      .getDescriptionHeader(context, id);
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
      /* NftCategory(
        id: 3,
        name: localizations.nftCategoryCollectibles,
        image: 'assets/images/category_nft_collectibles.jpg',
      ),
      NftCategory(
        id: 4,
        name: localizations.nftCategoryMusic,
        image: 'assets/images/category_nft_music.jpg',
      ),*/
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
    final localizations = AppLocalization.of(context)!;
    switch (id) {
      case 0:
        return localizations.nftCategoryDescriptionHeader0;
      case 1:
        return localizations.nftCategoryDescriptionHeader1;
      case 2:
        return localizations.nftCategoryDescriptionHeader2;
      case 3:
        return localizations.nftCategoryDescriptionHeader3;
      case 4:
        return localizations.nftCategoryDescriptionHeader4;
      case 5:
        return localizations.nftCategoryDescriptionHeader5;
      case 6:
        return localizations.nftCategoryDescriptionHeader6;
      default:
        return localizations.nftCategoryDescriptionHeaderDefault;
    }
  }
}

abstract class NftCategoryProviders {
  static final nftCategoryRepository = _nftCategoryRepositoryProvider;
  static final fetchNftCategories = _fetchNftCategoryProvider;
  static final selectedAccountNftCategories =
      _selectedAccountNftCategoriesProvider;
  static final getNbNFTInCategory = _getNbNFTInCategoryProvider;
  static final getListByDefault = _getListByDefaultProvider;
  static final updateNftCategoryList = _updateNftCategoryListProvider;
  static final getDescriptionHeader = _getDescriptionHeaderProvider;
}
