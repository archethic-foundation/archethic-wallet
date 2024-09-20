import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/infrastructure/dex_token.repository.dart';
import 'package:aewallet/modules/aeswap/infrastructure/pool_factory.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_token.g.dart';

@riverpod
DexTokenRepositoryImpl _dexTokenRepository(_DexTokenRepositoryRef ref) =>
    DexTokenRepositoryImpl();

@riverpod
Future<DexToken?> _getTokenFromAddress(
  _GetTokenFromAddressRef ref,
  address,
) async {
  return ref.watch(_dexTokenRepositoryProvider).getTokenFromAddress(address);
}

@riverpod
Future<List<DexToken>> _getTokenFromAccount(
  _GetTokenFromAccountRef ref,
  accountAddress,
) async {
  return ref
      .watch(_dexTokenRepositoryProvider)
      .getTokensFromAccount(accountAddress);
}

@riverpod
Future<String?> _getTokenIcon(
  _GetTokenIconRef ref,
  address,
) async {
  return ref.watch(_dexTokenRepositoryProvider).getTokenIcon(address);
}

@riverpod
Future<double> _estimateTokenInFiat(
  _EstimateTokenInFiatRef ref,
  DexToken token,
) async {
  var fiatValue = 0.0;
  if (token.symbol == 'UCO') {
    final archethicOracleUCO =
        ref.watch(aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO);

    fiatValue = archethicOracleUCO.usd;
  } else {
    final env = ref.read(SettingsProviders.settings).network.getNetworkLabel();
    final price = await ref.watch(
      aedappfm.CoinPriceProviders.coinPrice(
        address: token.address!,
        network: env,
      ).future,
    );

    fiatValue = price;
  }
  return fiatValue;
}

@riverpod
Future<double> _estimateLPTokenInFiat(
  _EstimateLPTokenInFiatRef ref,
  DexToken token1,
  DexToken token2,
  double lpTokenAmount,
  String poolAddress,
) async {
  if (lpTokenAmount <= 0) {
    return 0;
  }

  var fiatValueToken1 = 0.0;
  var fiatValueToken2 = 0.0;

  fiatValueToken1 =
      await ref.read(DexTokensProviders.estimateTokenInFiat(token1).future);
  fiatValueToken2 =
      await ref.read(DexTokensProviders.estimateTokenInFiat(token2).future);

  if (fiatValueToken1 == 0 && fiatValueToken2 == 0) {
    throw Exception();
  }

  final apiService = aedappfm.sl.get<ApiService>();
  final amounts = await PoolFactoryRepositoryImpl(poolAddress, apiService)
      .getRemoveAmounts(lpTokenAmount);
  var amountToken1 = 0.0;
  var amountToken2 = 0.0;
  if (amounts != null) {
    amountToken1 =
        amounts['token1'] == null ? 0.0 : amounts['token1'] as double;
    amountToken2 =
        amounts['token2'] == null ? 0.0 : amounts['token2'] as double;
  }

  if (fiatValueToken1 > 0 && fiatValueToken2 > 0) {
    return amountToken1 * fiatValueToken1 + amountToken2 * fiatValueToken2;
  }

  if (fiatValueToken1 > 0 && fiatValueToken2 == 0) {
    return (amountToken1 + amountToken2) * fiatValueToken1;
  }

  if (fiatValueToken1 == 0 && fiatValueToken2 > 0) {
    return (amountToken1 + amountToken2) * fiatValueToken2;
  }

  return 0;
}

abstract class DexTokensProviders {
  static const getTokenFromAddress = _getTokenFromAddressProvider;
  static const getTokenFromAccount = _getTokenFromAccountProvider;
  static const getTokenIcon = _getTokenIconProvider;
  static const estimateTokenInFiat = _estimateTokenInFiatProvider;
  static const estimateLPTokenInFiat = _estimateLPTokenInFiatProvider;
}
