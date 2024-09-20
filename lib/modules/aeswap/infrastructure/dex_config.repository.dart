import 'dart:convert';

import 'package:aewallet/modules/aeswap/domain/models/dex_config.dart';
import 'package:aewallet/modules/aeswap/domain/repositories/dex_config.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/services.dart';

class DexConfigRepositoryImpl implements DexConfigRepository {
  @override
  Future<DexConfig> getDexConfig() async {
    final jsonContent = await rootBundle
        .loadString('lib/modules/aeswap/domain/repositories/config.json');

    final jsonData = jsonDecode(jsonContent);
    final environment = aedappfm.EndpointUtil.getEnvironnement();
    if (environment.isEmpty) {
      return const DexConfig();
    }
    final configList = List<Map<String, dynamic>>.from(jsonData['environment']);
    final configMap = configList.firstWhere(
      (element) => element['name'] == environment,
    );

    return DexConfig.fromJson(configMap);
  }
}
