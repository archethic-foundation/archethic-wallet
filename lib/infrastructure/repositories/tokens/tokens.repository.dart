import 'package:aewallet/domain/repositories/tokens/tokens.repository.dart';
import 'package:aewallet/infrastructure/datasources/tokens_list.hive.dart';
import 'package:aewallet/infrastructure/datasources/wallet_token_dto.hive.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class TokensRepositoryImpl implements TokensRepository {
  @override
  Future<Map<String, archethic.Token>> getToken(
    List<String> addresses,
    archethic.ApiService apiService,
  ) async {
    final tokenMap = <String, archethic.Token>{};

    final addressesOutCache = <String>[];
    final tokensListDatasource = await TokensListHiveDatasource.getInstance();

    for (final address in addresses.toSet()) {
      final token = tokensListDatasource.getToken(address);
      if (token != null) {
        tokenMap[address] = token.toModel();
      } else {
        addressesOutCache.add(address);
      }
    }

    var antiSpam = 0;
    final futures = <Future>[];
    for (final address in addressesOutCache) {
      // Delay the API call if we have made more than 10 requests
      if (antiSpam > 0 && antiSpam % 10 == 0) {
        await Future.delayed(const Duration(seconds: 1));
      }

      // Make the API call and update the antiSpam counter
      futures.add(
        apiService.getToken(
          [address],
        ),
      );
      antiSpam++;
    }

    final getTokens = await Future.wait(futures);
    for (final Map<String, archethic.Token> getToken in getTokens) {
      tokenMap.addAll(getToken);

      getToken.forEach((key, value) async {
        value = value.copyWith(address: key);
        await tokensListDatasource.setToken(value.toHive());
      });
    }

    return tokenMap;
  }

  @override
  Future<List<AEToken>> getTokensList(
    String userGenesisAddress,
    archethic.ApiService apiService,
    Environment environment, {
    bool withVerified = true,
    bool withLPToken = true,
    bool withNotVerified = true,
  }) async {
    final tokensList = <AEToken>[];
    final balanceMap = await apiService.fetchBalance([userGenesisAddress]);
    if (balanceMap[userGenesisAddress] == null) {
      return tokensList;
    }
    if (withVerified) {
      final defUCOToken = await aedappfm.DefTokensRepositoryImpl()
          .getDefToken(environment, 'UCO');
      tokensList.add(
        ucoToken.copyWith(
          name: defUCOToken?.name ?? '',
          isVerified: true,
          icon: defUCOToken?.icon,
          ucid: defUCOToken?.ucid,
          balance: archethic
              .fromBigInt(balanceMap[userGenesisAddress]!.uco)
              .toDouble(),
        ),
      );
    }

    if (balanceMap[userGenesisAddress]!.token.isNotEmpty) {
      final tokenAddressList = <String>[];
      for (final tokenBalance in balanceMap[userGenesisAddress]!.token) {
        if (tokenBalance.address != null) {
          tokenAddressList.add(tokenBalance.address!);
        }
      }

      // Search token Information
      final tokenMap = await getToken(
        tokenAddressList.toSet().toList(),
        apiService,
      );

      final verifiedTokens = await aedappfm.VerifiedTokensRepositoryImpl(
        apiService: apiService,
        environment: environment,
      ).getVerifiedTokens();

      for (final tokenBalance in balanceMap[userGenesisAddress]!.token) {
        String? pairSymbolToken1;
        String? pairSymbolToken2;
        AEToken? defPairSymbolToken1;
        AEToken? defPairSymbolToken2;
        final token = tokenMap[tokenBalance.address];
        if (token != null && token.type == 'fungible') {
          final tokenSymbolSearch = <String>[];
          if (token.properties.isNotEmpty &&
              token.properties['token1_address'] != null &&
              token.properties['token2_address'] != null) {
            if (token.properties['token1_address'] != 'UCO') {
              tokenSymbolSearch.add(token.properties['token1_address']);
            }
            if (token.properties['token2_address'] != 'UCO') {
              tokenSymbolSearch.add(token.properties['token2_address']);
            }
            final tokensSymbolMap = await getToken(
              tokenSymbolSearch,
              apiService,
            );
            pairSymbolToken1 = token.properties['token1_address'] != 'UCO'
                ? tokensSymbolMap[token.properties['token1_address']] != null
                    ? tokensSymbolMap[token.properties['token1_address']]!
                        .symbol!
                    : ''
                : 'UCO';
            pairSymbolToken2 = token.properties['token2_address'] != 'UCO'
                ? tokensSymbolMap[token.properties['token2_address']] != null
                    ? tokensSymbolMap[token.properties['token2_address']]!
                        .symbol!
                    : ''
                : 'UCO';
          }

          final defToken = await aedappfm.DefTokensRepositoryImpl()
              .getDefToken(environment, token.address!.toUpperCase());

          if (token.properties['token1_address'] != null) {
            defPairSymbolToken1 =
                await aedappfm.DefTokensRepositoryImpl().getDefToken(
              environment,
              token.properties['token1_address'].toUpperCase(),
            );
          }

          if (token.properties['token2_address'] != null) {
            defPairSymbolToken2 =
                await aedappfm.DefTokensRepositoryImpl().getDefToken(
              environment,
              token.properties['token2_address'].toUpperCase(),
            );
          }
          final aeToken = AEToken(
            name: defToken?.name ?? '',
            address: token.address!.toUpperCase(),
            balance: archethic.fromBigInt(tokenBalance.amount).toDouble(),
            icon: defToken?.icon,
            ucid: defToken?.ucid,
            supply: archethic.fromBigInt(token.supply).toDouble(),
            isLpToken: pairSymbolToken1 != null && pairSymbolToken2 != null,
            symbol: pairSymbolToken1 != null && pairSymbolToken2 != null
                ? 'LP Token'
                : token.symbol!,
            lpTokenPair: pairSymbolToken1 != null && pairSymbolToken2 != null
                ? aedappfm.AETokenPair(
                    token1: AEToken(
                      symbol: pairSymbolToken1,
                      address: token.properties['token1_address'],
                      name: defPairSymbolToken1?.name ?? '',
                      icon: defPairSymbolToken1?.icon,
                      ucid: defPairSymbolToken1?.ucid,
                    ),
                    token2: AEToken(
                      symbol: pairSymbolToken2,
                      address: token.properties['token2_address'],
                      name: defPairSymbolToken2?.name ?? '',
                      icon: defPairSymbolToken2?.icon,
                      ucid: defPairSymbolToken2?.ucid,
                    ),
                  )
                : null,
            isVerified: verifiedTokens.contains(token.address!.toUpperCase()),
          );

          if (aeToken.isLpToken && withLPToken ||
              aeToken.isVerified && withVerified ||
              aeToken.isVerified == false && withNotVerified) {
            tokensList.add(aeToken);
          }
        }
      }
    }

    return tokensList;
  }
}
