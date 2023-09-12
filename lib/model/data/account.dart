/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/blockchain/keychain_secured_infos.dart';
import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/nft_infos_off_chain.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: HiveTypeIds.account)

/// Next field available : 15
class Account extends HiveObject with KeychainServiceMixin {
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
    this.accountNFTCollections,
    this.nftInfosOffChainList,
    this.nftCategoryList,
    this.serviceType,
  });

  String get nameDisplayed => _getShortName(name);

  String _getShortName(String name) {
    var result = name;
    if (name.startsWith('archethic-wallet-')) {
      result = result.replaceFirst('archethic-wallet-', '');
    }
    if (name.startsWith('aeweb-')) {
      result = result.replaceFirst('aeweb-', '');
    }

    return Uri.decodeFull(
      result,
    );
  }

  Account copyWith({
    String? name,
    String? genesisAddress,
    int? lastLoadingTransactionInputs,
    bool? selected,
    String? lastAddress,
    String? serviceType,
    AccountBalance? balance,
    List<RecentTransaction>? recentTransactions,
    List<AccountToken>? accountTokens,
    List<AccountToken>? accountNFT,
    List<AccountToken>? accountNFTCollections,
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
        serviceType: serviceType ?? this.serviceType,
        balance: balance ?? this.balance,
        recentTransactions: recentTransactions ?? this.recentTransactions,
        accountTokens: accountTokens ?? this.accountTokens,
        accountNFT: accountNFT ?? this.accountNFT,
        accountNFTCollections:
            accountNFTCollections ?? this.accountNFTCollections,
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

  /// Service Type
  @HiveField(13)
  String? serviceType;

  /// NFT Collections
  @HiveField(14)
  List<AccountToken>? accountNFTCollections;

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

  Future<void> updateNFT(
    KeychainSecuredInfos keychainSecuredInfos,
    List<AccountToken>? accountNFT,
    List<AccountToken>? accountNFTCollections,
  ) async {
    this.accountNFT = accountNFT;
    this.accountNFTCollections = accountNFTCollections;

    _addToken(accountNFT);
    _addToken(accountNFTCollections);

    await updateAccount();
  }

  void _addToken(List<AccountToken>? accountTokens) {
    if (accountTokens == null) {
      return;
    }

    nftInfosOffChainList ??= List<NftInfosOffChain>.empty(growable: true);
    for (final accountToken in accountTokens) {
      final nftInfoOffChainExists = nftInfosOffChainList!.any(
        (nftInfoOff) => nftInfoOff.id == accountToken.tokenInformation!.id,
      );
      if (nftInfoOffChainExists == true) {
        continue;
      }
      nftInfosOffChainList!.add(
        NftInfosOffChain(
          categoryNftIndex: 0,
          favorite: false,
          id: accountToken.tokenInformation!.id,
        ),
      );
    }
  }

  Future<void> updateBalance() async {
    final balanceGetResponseMap =
        await sl.get<AppService>().getBalanceGetResponse([lastAddress!]);

    if (balanceGetResponseMap[lastAddress] == null) {
      return;
    }
    final balanceGetResponse = balanceGetResponseMap[lastAddress]!;
    final accountBalance = AccountBalance(
      nativeTokenName: AccountBalance.cryptoCurrencyLabel,
      nativeTokenValue: fromBigInt(balanceGetResponse.uco).toDouble(),
    );

    for (final token in balanceGetResponse.token) {
      if (token.tokenId != null) {
        if (token.tokenId == 0) {
          accountBalance.tokensFungiblesNb++;
        } else {
          accountBalance.nftNb++;
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
    String name,
    KeychainSecuredInfos keychainSecuredInfos,
  ) async {
    recentTransactions =
        await sl.get<AppService>().getAccountRecentTransactions(
              genesisAddress,
              lastAddress!,
              name,
              keychainSecuredInfos,
              recentTransactions ?? [],
            );
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
        (await sl.get<AppService>().getToken([tokenAddress!]))[tokenAddress]!
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

  Future<void> clearRecentTransactionsFromCache() async {
    recentTransactions = [];
    await updateAccount();
  }
}

mixin KeychainServiceMixin {
  final kMainDerivation = "m/650'/";

  String getServiceTypeFromPath(String derivationPath) {
    var serviceType = 'other';
    final name = derivationPath.replaceFirst(kMainDerivation, '');

    if (name.startsWith('archethic-wallet-')) {
      serviceType = 'archethicWallet';
    } else {
      if (name.startsWith('aeweb-')) {
        serviceType = 'aeweb';
      }
    }
    return serviceType;
  }

  String getNameFromPath(String derivationPath) {
    final name = derivationPath.replaceFirst(kMainDerivation, '');
    return name.split('/').first;
  }
}
