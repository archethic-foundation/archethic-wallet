/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/domain/models/dex_blockchain.dart';
import 'package:aewallet/modules/aeswap/domain/repositories/dex_blockchain.repository.dart';
import 'package:aewallet/modules/aeswap/infrastructure/dex_blockchain.repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_blockchain.g.dart';

@riverpod
Future<List<DexBlockchain>> _getBlockchainsListConf(
  _GetBlockchainsListConfRef ref,
) async {
  return ref.watch(_dexBlockchainsRepositoryProvider).getBlockchainsListConf();
}

@riverpod
DexBlockchainsRepository _dexBlockchainsRepository(
  _DexBlockchainsRepositoryRef ref,
) =>
    DexBlockchainsRepositoryImpl();

@riverpod
Future<List<DexBlockchain>> _getBlockchainsList(
  _GetBlockchainsListRef ref,
) async {
  final blockchainsList = await ref
      .watch(_dexBlockchainsRepositoryProvider)
      .getBlockchainsListConf();
  return ref
      .watch(_dexBlockchainsRepositoryProvider)
      .getBlockchainsList(blockchainsList);
}

@riverpod
Future<DexBlockchain?> _getBlockchainFromEnv(
  _GetBlockchainFromEnvRef ref,
  String env,
) async {
  final blockchainsList = await ref
      .watch(_dexBlockchainsRepositoryProvider)
      .getBlockchainsListConf();

  return ref
      .watch(_dexBlockchainsRepositoryProvider)
      .getBlockchainFromEnv(blockchainsList, env);
}

abstract class DexBlockchainsProviders {
  static final getBlockchainsList = _getBlockchainsListProvider;
  static const getBlockchainFromEnv = _getBlockchainFromEnvProvider;
  static final getBlockchainsListConf = _getBlockchainsListConfProvider;
}
