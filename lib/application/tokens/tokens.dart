import 'dart:developer';

import 'package:aewallet/application/aeswap/dex_token.dart';
import 'package:aewallet/infrastructure/repositories/tokens/tokens.repository.dart';
import 'package:aewallet/modules/aeswap/application/pool/dex_pool.dart';
import 'package:aewallet/modules/aeswap/application/session/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tokens.g.dart';

@riverpod
Future<List<AEToken>> tokensList(
  TokensListRef ref,
  String userGenesisAddress, {
  bool withVerified = true,
  bool withLPToken = true,
  bool withNotVerified = true,
}) async {
  final apiService = sl.get<ApiService>();

  final environment = ref.watch(environmentProvider);
  final poolListRaw = await ref.watch(DexPoolProviders.getPoolListRaw.future);

  return TokensRepositoryImpl().getTokensList(
    userGenesisAddress,
    apiService,
    poolListRaw,
    environment,
    withVerified: withVerified,
    withLPToken: withLPToken,
    withNotVerified: withNotVerified,
  );
}

@riverpod
Future<double> tokensTotalUSD(
  TokensTotalUSDRef ref,
  String userGenesisAddress,
) async {
  var total = 0.0;
  const _logName = 'tokensTotalUSD';
  final tokensList = await ref.watch(
    tokensListProvider(userGenesisAddress).future,
  );

  for (final token in tokensList) {
    log(
      '${token.address} : ${token.symbol} (${token.isLpToken})',
      name: _logName,
    );
    final priceToken = token.isLpToken && token.lpTokenPair != null
        ? ref
                .watch(
                  DexTokensProviders.estimateLPTokenInFiat(
                    token.lpTokenPair!.token1.address!,
                    token.lpTokenPair!.token2.address!,
                    token.balance,
                    token.address!,
                  ),
                )
                .value ??
            0
        : ((ref
                    .watch(
                      // TODO(reddwarf03): infinite loop
                      DexTokensProviders.estimateTokenInFiat(
                        token.address != null ? token.address! : 'UCO',
                      ),
                    )
                    .value ??
                0) *
            token.balance);

    total += priceToken;
  }

  return total;
}
