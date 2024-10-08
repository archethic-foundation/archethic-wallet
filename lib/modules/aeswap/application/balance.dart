import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/aeswap/dex_token.dart';
import 'package:aewallet/modules/aeswap/application/api_service.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/infrastructure/balance.repository.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'balance.g.dart';

@riverpod
Future<archethic.Balance> userBalance(UserBalanceRef ref) async {
  final apiService = ref.watch(apiServiceProvider);
  final selectedAccount = await ref
      .watch(
        AccountProviders.accounts.future,
      )
      .selectedAccount;
  final genesisAddress = selectedAccount?.genesisAddress ?? '';

  if (genesisAddress.isEmpty) return const archethic.Balance();

  try {
    return await BalanceRepositoryImpl(
          apiService: apiService,
        ).getUserTokensBalance(
          genesisAddress,
        ) ??
        const archethic.Balance();
  } catch (e) {
    return const archethic.Balance();
  }
}

@riverpod
Future<archethic.Balance> addressBalance(
  AddressBalanceRef ref,
  String address,
) async {
  final apiService = ref.watch(apiServiceProvider);

  try {
    return await BalanceRepositoryImpl(
          apiService: apiService,
        ).getUserTokensBalance(
          address,
        ) ??
        const archethic.Balance();
  } catch (e) {
    return const archethic.Balance();
  }
}

@riverpod
Future<double> addressBalanceTotalFiat(
  AddressBalanceTotalFiatRef ref,
  String address,
) async {
  try {
    var total = 0.0;

    final balanceAsync = ref.watch(
      addressBalanceProvider(address),
    );

    // ignore: cascade_invocations
    await balanceAsync.when(
      data: (balance) async {
        if (balance.uco > 0) {
          final fiatValueUCO = await ref
              .watch(DexTokensProviders.estimateTokenInFiat('UCO').future);
          total = (Decimal.parse('${archethic.fromBigInt(balance.uco)}') *
                  Decimal.parse(fiatValueUCO.toString()))
              .toDouble();
        }

        for (final balanceToken in balance.token) {
          if (balanceToken.tokenId == 0 &&
              balanceToken.address != null &&
              balanceToken.amount != null &&
              balanceToken.amount! > 0) {
            final fiatValueToken = await ref.watch(
              DexTokensProviders.estimateTokenInFiat(balanceToken.address!)
                  .future,
            );
            total +=
                (Decimal.parse('${archethic.fromBigInt(balanceToken.amount)}') *
                        Decimal.parse(fiatValueToken.toString()))
                    .toDouble();
          }
        }
      },
      error: (e, _) => throw Exception('Balance Total Fiat not retrieved: $e'),
      loading: () {},
    );

    return total;
  } catch (e) {
    throw Exception('Balance Total Fiat not retrieved');
  }
}

@riverpod
Future<double> getBalance(
  GetBalanceRef ref,
  String tokenAddress,
) async {
  final userBalance = await ref.watch(userBalanceProvider.future);
  if (tokenAddress.isUCO) {
    return archethic.fromBigInt(userBalance.uco).toDouble();
  }

  final tokenAmount = userBalance.token
          .firstWhereOrNull(
            (token) =>
                token.address!.toUpperCase() == tokenAddress.toUpperCase(),
          )
          ?.amount ??
      0;

  return archethic.fromBigInt(tokenAmount).toDouble();
}
