/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/nft_infos_off_chain.dart';
import 'package:aewallet/model/nft_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      await ref.watch(AccountProviders.accounts.future).selectedAccount;

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
  return _filterNTFInCategory(
        account,
        account.accountNFT,
        categoryNftIndex,
      ).length +
      _filterNTFInCategory(
        account,
        account.accountNFTCollections,
        categoryNftIndex,
      ).length;
}

List<NftInfosOffChain> _filterNTFInCategory(
  Account account,
  List<AccountToken>? accountTokens,
  int categoryNftIndex,
) {
  final listFilteredNFT = <NftInfosOffChain>[];

  if (account.nftInfosOffChainList == null || accountTokens == null) {
    return listFilteredNFT;
  }

  for (final accountToken in accountTokens) {
    final nftInfoOffChain = account.nftInfosOffChainList!
        .where(
          (nftInfoOff) =>
              nftInfoOff.id == accountToken.tokenInformation!.id &&
              nftInfoOff.categoryNftIndex == categoryNftIndex,
        )
        .firstOrNull;
    if (nftInfoOffChain != null) {
      listFilteredNFT.add(nftInfoOffChain);
    }
  }

  return listFilteredNFT;
}

@riverpod
List<NftCategory> _getListByDefault(
  _GetListByDefaultRef ref, {
  required BuildContext context,
}) {
  return ref.watch(_nftCategoryRepositoryProvider).getListByDefault(context);
}

@riverpod
List<NftCategory> _listNFTCategoryHidden(
  _ListNFTCategoryHiddenRef ref, {
  required BuildContext context,
}) {
  final nftCategoryToHidden =
      ref.watch(_nftCategoryRepositoryProvider).getListByDefault(context);

  final listNftCategory = ref
      .watch(
        NftCategoryProviders.selectedAccountNftCategories(
          context: context,
        ),
      )
      .valueOrNull;

  if (listNftCategory == null) {
    return nftCategoryToHidden;
  }
  for (final nftCategory in listNftCategory) {
    nftCategoryToHidden.removeWhere((element) => element.id == nftCategory.id);
  }
  return nftCategoryToHidden;
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
    final localizations = AppLocalizations.of(context)!;
    return [
      NftCategory(
        name: localizations.nftWithoutCategory,
      ),
      NftCategory(
        id: 1,
        name: localizations.nftCategoryArt,
      ),
      NftCategory(
        id: 2,
        name: localizations.nftCategoryAccess,
      ),
      /* NftCategory(
        id: 3,
        name: localizations.nftCategoryCollectibles,
      ),
      NftCategory(
        id: 4,
        name: localizations.nftCategoryMusic,
      ),*/
      NftCategory(
        id: 5,
        name: localizations.nftCategoryDoc,
      ),
      NftCategory(
        id: 6,
        name: localizations.nftCategoryLoyaltyCard,
      ),
    ];
  }

  String getDescriptionHeader(BuildContext context, int id) {
    final localizations = AppLocalizations.of(context)!;
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
  // TODO(reddwarf03): Distinct actions and infos' provider: change the name for example getNbNFTInCategory -> nbNFTInCategory; fetchNftCategories -> nftCategories
  // and let for example updateNftCategoryList because it's not a provider; it's an action
  static final nftCategoryRepository = _nftCategoryRepositoryProvider;
  static const fetchNftCategories = _fetchNftCategoryProvider;
  static const listNFTCategoryHidden = _listNFTCategoryHiddenProvider;
  static const selectedAccountNftCategories =
      _selectedAccountNftCategoriesProvider;
  static const getNbNFTInCategory = _getNbNFTInCategoryProvider;
  static const getListByDefault = _getListByDefaultProvider;
  static const getDescriptionHeader = _getDescriptionHeaderProvider;
}

abstract class NftCategoryProvidersActions {
  static Future<void> updateNftCategoryList(
    WidgetRef ref, {
    required List<NftCategory> nftCategoryListCustomized,
    required Account account,
  }) async {
    await ref.watch(_nftCategoryRepositoryProvider).updateNftCategoryList(
          nftCategoryListCustomized,
          account,
        );
    ref.invalidate(NftCategoryProviders.selectedAccountNftCategories);
    return;
  }
}
