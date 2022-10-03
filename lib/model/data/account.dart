/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/nft_infos_off_chain.dart';
import 'package:aewallet/model/data/price.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/model/nft_category.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/get_it_instance.dart';

part 'account.g.dart';

@HiveType(typeId: 1)
class Account extends HiveObject {
  Account({
    this.name,
    this.genesisAddress,
    this.lastLoadingTransactionInputs,
    this.selected = false,
    this.lastAddress,
    this.balance,
    this.recentTransactions,
    this.accountTokens,
    this.accountNFT,
  });

  /// Account name - Primary Key
  @HiveField(0)
  String? name;

  /// Genesis Address
  @HiveField(1)
  String? genesisAddress;

  /// Last loading of transaction inputs
  @HiveField(2)
  int? lastLoadingTransactionInputs;

  /// Whether this is the currently selected account
  @HiveField(3)
  bool? selected;

  /// Last address
  @HiveField(4)
  String? lastAddress;

  /// Balance
  @HiveField(5)
  AccountBalance? balance;

  /// Recent transactions
  @HiveField(6)
  List<RecentTransaction>? recentTransactions;

  /// Tokens
  @HiveField(7)
  List<AccountToken>? accountTokens;

  /// NFT
  @HiveField(8)
  List<AccountToken>? accountNFT;

  /// NFT Info Off Chain
  @HiveField(10)
  List<NftInfosOffChain>? nftInfosOffChainList;

  /// List of NFT category
  @HiveField(11)
  List<int>? nftCategoryList;

  List<NftCategory> getListNftCategory(BuildContext context) {
    final List<NftCategory> nftCategoryListCustomized =
        List<NftCategory>.empty(growable: true);
    if (nftCategoryList == null) {
      return NftCategory.getListByDefault(context);
    } else {
      for (final int nftCategoryId in nftCategoryList!) {
        nftCategoryListCustomized.add(
          NftCategory.getListByDefault(context).elementAt(nftCategoryId),
        );
      }
      return nftCategoryListCustomized;
    }
  }

  Future<void> updateNftCategoryList(
    List<NftCategory> nftCategoryListCustomized,
  ) async {
    nftCategoryList ??= List<int>.empty(growable: true);
    nftCategoryList!.clear();
    for (final NftCategory nftCategory in nftCategoryListCustomized) {
      nftCategoryList!.add(nftCategory.id!);
    }

    await updateAccount();
  }

  Future<void> updateLastAddress() async {
    final String lastAddressFromAddress =
        await sl.get<AddressService>().lastAddressFromAddress(genesisAddress!);
    lastAddress =
        lastAddressFromAddress == '' ? genesisAddress! : lastAddressFromAddress;
    await updateAccount();
  }

  Future<void> updateFungiblesTokens() async {
    accountTokens =
        await sl.get<AppService>().getFungiblesTokensList(lastAddress!);
    await updateAccount();
  }

  Future<void> updateNFT() async {
    accountNFT = await sl.get<AppService>().getNFTList(lastAddress!);

    bool nftInfosOffChainExist = false;
    if (accountNFT != null) {
      for (final AccountToken accountToken in accountNFT!) {
        if (nftInfosOffChainList == null) {
          nftInfosOffChainList = List<NftInfosOffChain>.empty(growable: true);
          nftInfosOffChainList!.add(
            NftInfosOffChain(
              categoryNftIndex: 0,
              favorite: false,
              id: accountToken.tokenInformations!.id,
            ),
          );
        }
        for (final NftInfosOffChain nftInfosOffChain in nftInfosOffChainList!) {
          nftInfosOffChainExist = false;
          if (accountToken.tokenInformations!.id == nftInfosOffChain.id) {
            nftInfosOffChainExist = true;
          }
        }
        if (nftInfosOffChainExist == false) {
          nftInfosOffChainList!.add(
            NftInfosOffChain(
              categoryNftIndex: 0,
              favorite: false,
              id: accountToken.tokenInformations!.id,
            ),
          );
        }
      }
    }

    await updateAccount();
  }

  Future<void> updateBalance(
    String tokenName,
    String fiatCurrencyCode,
    Price price,
  ) async {
    final Balance balanceGetResponse =
        await sl.get<AppService>().getBalanceGetResponse(lastAddress!);
    double fiatCurrencyValue = 0;
    if (balanceGetResponse.uco != null && price.amount != null) {
      fiatCurrencyValue = fromBigInt(balanceGetResponse.uco) * price.amount!;
    }
    final AccountBalance accountBalance = AccountBalance(
      nativeTokenName: tokenName,
      nativeTokenValue: balanceGetResponse.uco == null
          ? 0
          : fromBigInt(balanceGetResponse.uco).toDouble(),
      fiatCurrencyCode: fiatCurrencyCode,
      fiatCurrencyValue: fiatCurrencyValue,
      tokenPrice: price,
    );
    balance = accountBalance;
    await updateAccount();
  }

  Future<void> updateLastLoadingTransactionInputs() async {
    lastLoadingTransactionInputs =
        DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
    await updateAccount();
  }

  Future<void> updateRecentTransactions(
    String pagingAddress,
    String seed,
  ) async {
    recentTransactions = await sl
        .get<AppService>()
        .getRecentTransactions(genesisAddress!, lastAddress!, seed, name!);
    await updateLastLoadingTransactionInputs();
    await updateAccount();
  }

  Future<void> updateAccount() async {
    await sl.get<DBHelper>().updateAccount(this);
  }

  Future<void> updateNftInfosOffChainFavorite(String? tokenId) async {
    if (nftInfosOffChainList == null) {
      final List<NftInfosOffChain> nftInfosOffChainList =
          List<NftInfosOffChain>.empty(growable: true);
      final NftInfosOffChain nftInfosOffChain =
          NftInfosOffChain(categoryNftIndex: 0, favorite: false, id: tokenId);
      nftInfosOffChainList.add(nftInfosOffChain);
      await updateAccount();
    } else {
      for (final NftInfosOffChain nftInfosOffChain in nftInfosOffChainList!) {
        if (nftInfosOffChain.id == tokenId) {
          if (nftInfosOffChain.favorite != null) {
            nftInfosOffChain.favorite = !nftInfosOffChain.favorite!;
          } else {
            nftInfosOffChain.favorite = true;
          }
        }
      }
    }
    await updateAccount();
  }

  NftInfosOffChain? getftInfosOffChain(String? tokenId) {
    if (nftInfosOffChainList == null) {
      final List<NftInfosOffChain> nftInfosOffChainList =
          List<NftInfosOffChain>.empty(growable: true);
      final NftInfosOffChain nftInfosOffChain =
          NftInfosOffChain(categoryNftIndex: 0, favorite: false, id: tokenId);
      nftInfosOffChainList.add(nftInfosOffChain);
    } else {
      for (final NftInfosOffChain nftInfosOffChain in nftInfosOffChainList!) {
        if (nftInfosOffChain.id == tokenId) {
          return nftInfosOffChain;
        }
      }
    }
    return null;
  }

  Future<void> removeftInfosOffChain(String? tokenId) async {
    for (final NftInfosOffChain nftInfosOffChain in nftInfosOffChainList!) {
      if (nftInfosOffChain.id == tokenId) {
        nftInfosOffChain.delete();
      }
    }
    await updateAccount();
  }

  Future<void> updateNftInfosOffChain({
    String? tokenAddress,
    String? tokenId,
    int? categoryNftIndex,
    bool? favorite = false,
  }) async {
    final localOrRemoteToken =
        tokenId ?? (await sl.get<ApiService>().getToken(tokenAddress!)).id;

    nftInfosOffChainList ??= List<NftInfosOffChain>.empty(growable: true);
    if (nftInfosOffChainList!
        .where((element) => element.id == localOrRemoteToken)
        .isEmpty) {
      nftInfosOffChainList!.add(
        NftInfosOffChain(
          id: localOrRemoteToken,
          categoryNftIndex: categoryNftIndex,
          favorite: favorite,
        ),
      );
    } else {
      nftInfosOffChainList![nftInfosOffChainList!
              .indexWhere((element) => element.id == localOrRemoteToken)] =
          NftInfosOffChain(
        id: localOrRemoteToken,
        categoryNftIndex: categoryNftIndex,
        favorite: favorite,
      );
    }
    await updateAccount();
  }

  List<AccountToken> getAccountNFTFiltered(
    int categoryNftIndex, {
    bool? favorite,
  }) {
    final List<AccountToken> accountNFTFiltered =
        List<AccountToken>.empty(growable: true);
    if (accountNFT == null) {
      return accountNFTFiltered;
    } else {
      if (nftInfosOffChainList == null || nftInfosOffChainList!.isEmpty) {
        return accountNFT!;
      } else {
        for (final AccountToken accountToken in accountNFT!) {
          final NftInfosOffChain? nftInfosOffChain = nftInfosOffChainList!
              .where(
                (element) => element.id == accountToken.tokenInformations!.id,
              )
              .firstOrNull;
          if (nftInfosOffChain != null &&
              nftInfosOffChain.categoryNftIndex == categoryNftIndex) {
            if (favorite == null) {
              accountNFTFiltered.add(accountToken);
            } else {
              if (nftInfosOffChain.favorite == favorite) {
                accountNFTFiltered.add(accountToken);
              }
            }
          }
        }
        return accountNFTFiltered;
      }
    }
  }

  int getNbNFTInCategory(int categoryNftIndex) {
    int count = 0;
    if (nftInfosOffChainList == null || nftInfosOffChainList!.isEmpty) {
      return count;
    } else {
      for (final AccountToken accountToken in accountNFT!) {
        final NftInfosOffChain? nftInfosOffChain = nftInfosOffChainList!
            .where(
              (element) => element.id == accountToken.tokenInformations!.id,
            )
            .firstOrNull;
        if (nftInfosOffChain != null &&
            nftInfosOffChain.categoryNftIndex == categoryNftIndex) {
          count++;
        }
      }
    }

    return count;
  }
}
