/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/nft_infos_off_chain.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/get_it_instance.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 1)
class Account extends HiveObject {
  Account({
    required this.name,
    required this.genesisAddress,
    this.lastLoadingTransactionInputs,
    this.selected = false,
    this.lastAddress,
    this.balance,
    this.recentTransactions,
    this.accountTokens,
    this.accountNFT,
    this.nftInfosOffChainList,
    this.nftCategoryList,
  });

  Account copyWith({
    String? name,
    String? genesisAddress,
    int? lastLoadingTransactionInputs,
    bool? selected,
    String? lastAddress,
    AccountBalance? balance,
    List<RecentTransaction>? recentTransactions,
    List<AccountToken>? accountTokens,
    List<AccountToken>? accountNFT,
    List<NftInfosOffChain>? nftInfosOffChainList,
    List<int>? nftCategoryList,
  }) =>
      Account(
        name: name ?? this.name,
        genesisAddress: genesisAddress ?? this.genesisAddress,
        lastLoadingTransactionInputs:
            lastLoadingTransactionInputs ?? this.lastLoadingTransactionInputs,
        selected: selected ?? this.selected,
        lastAddress: lastAddress ?? this.lastAddress,
        balance: balance ?? this.balance,
        recentTransactions: recentTransactions ?? this.recentTransactions,
        accountTokens: accountTokens ?? this.accountTokens,
        accountNFT: accountNFT ?? this.accountNFT,
        nftInfosOffChainList: nftInfosOffChainList ?? this.nftInfosOffChainList,
        nftCategoryList: nftCategoryList ?? this.nftCategoryList,
      );

  /// Account name - Primary Key
  @HiveField(0)
  final String name;

  /// Genesis Address
  @HiveField(1)
  final String genesisAddress;

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

  Future<void> updateLastAddress() async {
    final lastAddressFromAddressMap =
        await sl.get<AddressService>().lastAddressFromAddress([genesisAddress]);
    lastAddress = lastAddressFromAddressMap.isEmpty ||
            lastAddressFromAddressMap[genesisAddress] == null
        ? genesisAddress
        : lastAddressFromAddressMap[genesisAddress];
    await updateAccount();
  }

  Future<void> updateFungiblesTokens() async {
    accountTokens =
        await sl.get<AppService>().getFungiblesTokensList(lastAddress!);
    await updateAccount();
  }

  Future<void> updateNFT() async {
    accountNFT = await sl.get<AppService>().getNFTList(lastAddress!);

    var nftInfosOffChainExist = false;
    if (accountNFT != null) {
      for (final accountToken in accountNFT!) {
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
        for (final nftInfosOffChain in nftInfosOffChainList!) {
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

  Future<void> updateBalance() async {
    final balanceGetResponse =
        await sl.get<AppService>().getBalanceGetResponse(lastAddress!);
    final accountBalance = AccountBalance(
      nativeTokenName: AccountBalance.cryptoCurrencyLabel,
      nativeTokenValue: balanceGetResponse.uco == null
          ? 0
          : fromBigInt(balanceGetResponse.uco).toDouble(),
    );
    if (balanceGetResponse.token != null) {
      for (final token in balanceGetResponse.token!) {
        if (token.tokenId != null) {
          if (token.tokenId == 0) {
            accountBalance.tokensFungiblesNb++;
          } else {
            accountBalance.nftNb++;
          }
        }
      }
    }

    balance = accountBalance;
    await updateAccount();
  }

  Future<void> updateLastLoadingTransactionInputs() async {
    lastLoadingTransactionInputs =
        DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
    await updateAccount();
  }

  Future<void> updateRecentTransactions(
    String seed,
  ) async {
    recentTransactions = await sl
        .get<AppService>()
        .getAccountRecentTransactions(genesisAddress, lastAddress!, seed, name);
    await updateLastLoadingTransactionInputs();
    await updateAccount();
  }

  Future<void> updateAccount() async {
    await sl.get<DBHelper>().updateAccount(this);
  }

  Future<void> updateNftInfosOffChainFavorite(String? tokenId) async {
    if (nftInfosOffChainList == null) {
      final nftInfosOffChainList = List<NftInfosOffChain>.empty(growable: true);
      final nftInfosOffChain =
          NftInfosOffChain(categoryNftIndex: 0, favorite: false, id: tokenId);
      nftInfosOffChainList.add(nftInfosOffChain);
      await updateAccount();
    } else {
      for (final nftInfosOffChain in nftInfosOffChainList!) {
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
      final nftInfosOffChainList = List<NftInfosOffChain>.empty(growable: true);
      final nftInfosOffChain =
          NftInfosOffChain(categoryNftIndex: 0, favorite: false, id: tokenId);
      nftInfosOffChainList.add(nftInfosOffChain);
    } else {
      for (final nftInfosOffChain in nftInfosOffChainList!) {
        if (nftInfosOffChain.id == tokenId) {
          return nftInfosOffChain;
        }
      }
    }
    return null;
  }

  Future<void> removeftInfosOffChain(String? tokenId) async {
    if (nftInfosOffChainList == null) {
      return;
    }

    nftInfosOffChainList!.removeWhere(
      (element) => element.id == tokenId,
    );

    await updateAccount();
  }

  Future<void> updateNftInfosOffChain({
    String? tokenAddress,
    String? tokenId,
    int? categoryNftIndex,
    bool? favorite = false,
  }) async {
    final localOrRemoteToken = tokenId ??
        (await sl.get<ApiService>().getToken([tokenAddress!]))[tokenAddress]!
            .id;

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
    final accountNFTFiltered = List<AccountToken>.empty(growable: true);
    if (accountNFT == null) {
      return accountNFTFiltered;
    } else {
      if (nftInfosOffChainList == null || nftInfosOffChainList!.isEmpty) {
        return accountNFT!;
      } else {
        for (final accountToken in accountNFT!) {
          final nftInfosOffChain = nftInfosOffChainList!
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
}
