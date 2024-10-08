import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/modules/aeswap/application/api_service.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/infrastructure/balance.repository.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:collection/collection.dart';
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
