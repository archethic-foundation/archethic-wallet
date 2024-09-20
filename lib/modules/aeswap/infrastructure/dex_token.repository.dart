import 'dart:convert';

import 'package:aewallet/modules/aeswap/domain/models/dex_pair.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/model_parser.dart';
import 'package:aewallet/modules/aeswap/domain/repositories/dex_token.repository.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/dex_token.hive.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/tokens_list.hive.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/services.dart';

class DexTokenRepositoryImpl with ModelParser implements DexTokenRepository {
  DexTokenRepositoryImpl();

  @override
  Future<DexToken?> getTokenFromAddress(
    String address,
  ) async {
    DexToken? token;
    final tokensListDatasource = await HiveTokensListDatasource.getInstance();
    final tokenHive = tokensListDatasource.getToken(
      aedappfm.EndpointUtil.getEnvironnement(),
      address,
    );
    if (tokenHive == null) {
      final tokenMap = await aedappfm.sl.get<ApiService>().getToken(
        [address],
        request: 'name, symbol, type',
      );
      if (tokenMap[address] != null && tokenMap[address]!.type == 'fungible') {
        token = tokenSDKToModel(tokenMap[address]!, 0);
        token = token.copyWith(address: address);
        await tokensListDatasource.setToken(
          aedappfm.EndpointUtil.getEnvironnement(),
          token.toHive(),
        );
      }
    } else {
      token = tokenHive.toModel();
    }

    return token;
  }

  @override
  Future<List<DexToken>> getTokensFromAccount(
    String accountAddress,
  ) async {
    final dexTokens = <DexToken>[];
    final balanceMap =
        await aedappfm.sl.get<ApiService>().fetchBalance([accountAddress]);
    final balance = balanceMap[accountAddress];
    if (balance == null) {
      return [];
    }

    final tokenAddressList = <String>[];
    for (final token in balance.token) {
      if (token.tokenId == 0) tokenAddressList.add(token.address!);
    }

    final dexTokenUCO = ucoToken.copyWith(
      balance: fromBigInt(balance.uco).toDouble(),
      icon: 'Archethic.svg',
    );
    dexTokens.add(dexTokenUCO);

    final tokenMap = await aedappfm.sl.get<ApiService>().getToken(
          tokenAddressList,
          request: 'name, symbol, properties',
        );

    for (final entry in tokenMap.entries) {
      final key = entry.key;
      final value = entry.value;

      final _token = value.copyWith(address: key);

      var balanceAmount = 0.0;
      for (final tokenBalance in balance.token) {
        if (tokenBalance.address!.toUpperCase() ==
            _token.address!.toUpperCase()) {
          balanceAmount = fromBigInt(tokenBalance.amount).toDouble();
          break;
        }
      }

      var dexToken = tokenSDKToModel(_token, balanceAmount);

      final tokenSymbolSearch = <String>[];
      if (value.properties.isNotEmpty &&
          value.properties['token1_address'] != null &&
          value.properties['token2_address'] != null) {
        if (value.properties['token1_address'] != 'UCO') {
          tokenSymbolSearch.add(value.properties['token1_address']);
        }
        if (value.properties['token2_address'] != 'UCO') {
          tokenSymbolSearch.add(value.properties['token2_address']);
        }
        final tokensSymbolMap = await aedappfm.sl.get<ApiService>().getToken(
              tokenSymbolSearch,
              request: 'name, symbol',
            );

        dexToken = dexToken.copyWith(
          isLpToken: true,
          lpTokenPair: DexPair(
            token1: value.properties['token1_address'] != 'UCO'
                ? DexToken(
                    address: value.properties['token1_address'],
                    name: tokensSymbolMap[value.properties['token1_address']] !=
                            null
                        ? tokensSymbolMap[value.properties['token1_address']]!
                            .name!
                        : '',
                    symbol: tokensSymbolMap[
                                value.properties['token1_address']] !=
                            null
                        ? tokensSymbolMap[value.properties['token1_address']]!
                            .symbol!
                        : '',
                  )
                : ucoToken,
            token2: value.properties['token2_address'] != 'UCO'
                ? DexToken(
                    address: value.properties['token2_address'],
                    name: tokensSymbolMap[value.properties['token2_address']] !=
                            null
                        ? tokensSymbolMap[value.properties['token2_address']]!
                            .name!
                        : '',
                    symbol: tokensSymbolMap[
                                value.properties['token2_address']] !=
                            null
                        ? tokensSymbolMap[value.properties['token2_address']]!
                            .symbol!
                        : '',
                  )
                : ucoToken,
          ),
        );
      }
      dexTokens.add(
        dexToken,
      );
    }

    dexTokens.sort((a, b) {
      final symbolA = a.symbol.toUpperCase();
      final symbolB = b.symbol.toUpperCase();

      if (a.isLpToken && !b.isLpToken) {
        return 1;
      } else if (!a.isLpToken && b.isLpToken) {
        return -1;
      } else {
        return symbolA.compareTo(symbolB);
      }
    });

    return dexTokens;
  }

  @override
  Future<String?> getTokenIcon(String address) async {
    final jsonContent = await rootBundle
        .loadString('lib/modules/aeswap/domain/repositories/common_bases.json');

    final jsonData = jsonDecode(jsonContent);

    final currentEnvironment = aedappfm.EndpointUtil.getEnvironnement();
    try {
      final tokens = jsonData['tokens'][currentEnvironment] as List<dynamic>;
      String? tokenIcon;
      for (final token in tokens) {
        if (token['address'].toString().toUpperCase() ==
            address.toUpperCase()) {
          tokenIcon = token['icon'];
          break;
        }
      }
      return tokenIcon;
    } catch (e) {
      return null;
    }
  }
}
