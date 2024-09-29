import 'dart:convert';

import 'package:aewallet/modules/aeswap/domain/models/dex_blockchain.dart';
import 'package:aewallet/modules/aeswap/domain/repositories/dex_blockchain.repository.dart';
import 'package:flutter/services.dart';

class DexBlockchainsRepositoryImpl implements DexBlockchainsRepository {
  @override
  Future<List<DexBlockchain>> getBlockchainsListConf() async {
    final jsonContent = await rootBundle.loadString(
        'lib/modules/aeswap/domain/repositories/blockchains_list.json');

    final jsonData = jsonDecode(jsonContent);

    final blockchainsList =
        List<Map<String, dynamic>>.from(jsonData['blockchains']);

    return blockchainsList.map(DexBlockchain.fromJson).toList();
  }

  @override
  List<DexBlockchain> getBlockchainsList(
    List<DexBlockchain> blockchainsList,
  ) {
    blockchainsList.sort((a, b) {
      final compareEnv = a.env.compareTo(b.env);
      if (compareEnv != 0) {
        return compareEnv;
      } else {
        return a.name.compareTo(b.name);
      }
    });
    return blockchainsList;
  }

  @override
  Future<DexBlockchain?> getBlockchainFromEnv(
    List<DexBlockchain> blockchainsList,
    String env,
  ) async {
    return blockchainsList.singleWhere((element) => element.env == env);
  }
}
