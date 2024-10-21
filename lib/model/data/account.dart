/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:developer';

import 'package:aewallet/infrastructure/datasources/account.hive.dart';
import 'package:aewallet/infrastructure/datasources/appdb.hive.dart';
import 'package:aewallet/model/blockchain/keychain_secured_infos.dart';
import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/nft_infos_off_chain.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_pool_list_response.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
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

  Future<void> updateLastAddress(
    AddressService addressService,
  ) async {
    final lastAddressFromAddressMap =
        await addressService.lastAddressFromAddress([genesisAddress]);
    lastAddress = lastAddressFromAddressMap.isEmpty ||
            lastAddressFromAddressMap[genesisAddress] == null
        ? genesisAddress
        : lastAddressFromAddressMap[genesisAddress];
    await updateAccount();
  }

  Future<void> updateFungiblesTokens(
    List<GetPoolListResponse> poolsListRaw,
    AppService appService,
  ) async {
    accountTokens = await appService.getFungiblesTokensList(
      lastAddress!,
      poolsListRaw,
    );
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

  Future<void> updateBalance(
    aedappfm.Environment environment,
    AppService appService,
    OracleService oracleService,
  ) async {
    const _logName = 'updateBalance';
    var totalUSD = 0.0;
    final balanceGetResponseMap =
        await appService.getBalanceGetResponse([lastAddress!]);

    if (balanceGetResponseMap[lastAddress] == null) {
      return;
    }

    // TODO(Reddwarf03): il faut passer par les providers dédiés
    final ucidsTokens = await aedappfm.UcidsTokensRepositoryImpl()
        .getUcidsTokensFromNetwork(environment);
    log('ucidsTokens $ucidsTokens', name: _logName);

    final cryptoPrice = await aedappfm.CoinPriceRepositoryImpl().fetchPrices();
    log('cryptoPrice $cryptoPrice', name: _logName);

    final balanceGetResponse = balanceGetResponseMap[lastAddress]!;
    final ucoAmount = fromBigInt(balanceGetResponse.uco).toDouble();
    final accountBalance = AccountBalance(
      nativeTokenName: AccountBalance.cryptoCurrencyLabel,
      nativeTokenValue: ucoAmount,
    );

    if (balanceGetResponse.uco > 0) {
      accountBalance.tokensFungiblesNb++;
      final oracleUcoPrice = await oracleService.getOracleData();
      totalUSD = (Decimal.parse(totalUSD.toString()) +
              Decimal.parse(ucoAmount.toString()) *
                  Decimal.parse(oracleUcoPrice.uco!.usd!.toString()))
          .toDouble();
      log('totalUSD UCO $totalUSD', name: _logName);
    }

    for (final token in balanceGetResponse.token) {
      if (token.tokenId != null) {
        if (token.tokenId == 0) {
          accountBalance.tokensFungiblesNb++;

          final ucidsToken = ucidsTokens[token.address];
          if (ucidsToken != null && ucidsToken != 0 && cryptoPrice != null) {
            final amountTokenUSD =
                (Decimal.parse(fromBigInt(token.amount).toString()) *
                        Decimal.parse(
                          aedappfm.CoinPriceRepositoryImpl()
                              .getPriceFromUcid(ucidsToken, cryptoPrice)
                              .toString(),
                        ))
                    .toDouble();
            log('totalUSD ${token.address} $amountTokenUSD', name: _logName);
            totalUSD = totalUSD + amountTokenUSD;
          }
        } else {
          accountBalance.nftNb++;
        }
      }
    }
    log('totalUSD $totalUSD', name: _logName);
    accountBalance.totalUSD = totalUSD;
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
    AppService appService,
  ) async {
    recentTransactions = await appService.getAccountRecentTransactions(
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
    await AccountHiveDatasource.instance().updateAccount(this);
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
    required AppService appService,
  }) async {
    final localOrRemoteToken = tokenId ??
        (await appService.getToken([tokenAddress!]))[tokenAddress]!.id;

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
