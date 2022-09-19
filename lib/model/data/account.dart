/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:aewallet/model/data/nft_infos_off_chain.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/price.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:collection/collection.dart';

part 'account.g.dart';

@HiveType(typeId: 1)
class Account extends HiveObject {
  Account(
      {this.name,
      this.genesisAddress,
      this.lastLoadingTransactionInputs,
      this.selected = false,
      this.lastAddress,
      this.balance,
      this.recentTransactions,
      this.accountTokens,
      this.accountNFT});

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

  Future<void> updateLastAddress() async {
    String lastAddressFromAddress =
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
    if (accountNFT != null) {
      for (AccountToken accountToken in accountNFT!) {
        await updateNftInfosOffChain(
            tokenId: accountToken.tokenInformations!.id!);
      }
    }
    await updateAccount();
  }

  Future<void> updateBalance(
      String tokenName, String fiatCurrencyCode, Price price) async {
    final Balance balanceGetResponse =
        await sl.get<AppService>().getBalanceGetResponse(lastAddress!);
    double fiatCurrencyValue = 0;
    if (balanceGetResponse.uco != null && price.amount != null) {
      fiatCurrencyValue = fromBigInt(balanceGetResponse.uco!) * price.amount!;
    }
    final AccountBalance accountBalance = AccountBalance(
        nativeTokenName: tokenName,
        nativeTokenValue: balanceGetResponse.uco == null
            ? 0
            : fromBigInt(balanceGetResponse.uco!).toDouble(),
        fiatCurrencyCode: fiatCurrencyCode,
        fiatCurrencyValue: fiatCurrencyValue,
        tokenPrice: price);
    balance = accountBalance;
    await updateAccount();
  }

  Future<void> updateLastLoadingTransactionInputs() async {
    lastLoadingTransactionInputs =
        DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
    await updateAccount();
  }

  Future<void> updateRecentTransactions(
      String pagingAddress, String seed) async {
    recentTransactions = await sl
        .get<AppService>()
        .getRecentTransactions(genesisAddress!, lastAddress!, seed, name!);
    await updateLastLoadingTransactionInputs();
    await updateAccount();
  }

  Future<void> updateAccount() async {
    await sl.get<DBHelper>().updateAccount(this);
  }

  Future<void> updateNftInfosOffChain(
      {String? tokenAddress,
      String? tokenId,
      int? categoryNftIndex = 0,
      bool? like = false}) async {
    if (tokenId == null) {
      Token token = await sl.get<ApiService>().getToken(tokenAddress!);
      tokenId = token.id;
    }
    nftInfosOffChainList ??= List<NftInfosOffChain>.empty(growable: true);
    if (nftInfosOffChainList!
        .where((element) => element.id == tokenId)
        .isEmpty) {
      nftInfosOffChainList!.add(NftInfosOffChain(
          id: tokenId, categoryNftIndex: categoryNftIndex, like: like));
    } else {
      nftInfosOffChainList![nftInfosOffChainList!
              .indexWhere((element) => element.id == tokenId)] =
          NftInfosOffChain(
              id: tokenId, categoryNftIndex: categoryNftIndex, like: like);
    }
    await updateAccount();
  }

  List<AccountToken> getAccountNFTFiltered(int categoryNftIndex, {bool? like}) {
    List<AccountToken> accountNFTFiltered =
        List<AccountToken>.empty(growable: true);
    if (accountNFT == null) {
      return accountNFTFiltered;
    } else {
      if (nftInfosOffChainList == null || nftInfosOffChainList!.isEmpty) {
        return accountNFT!;
      } else {
        for (AccountToken accountToken in accountNFT!) {
          NftInfosOffChain? nftInfosOffChain = nftInfosOffChainList!
              .where(
                  (element) => element.id == accountToken.tokenInformations!.id)
              .firstOrNull;
          if (nftInfosOffChain != null &&
              nftInfosOffChain.categoryNftIndex == categoryNftIndex) {
            if (like == null) {
              accountNFTFiltered.add(accountToken);
            } else {
              if (nftInfosOffChain.like == like) {
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
      for (AccountToken accountToken in accountNFT!) {
        NftInfosOffChain? nftInfosOffChain = nftInfosOffChainList!
            .where(
                (element) => element.id == accountToken.tokenInformations!.id)
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
