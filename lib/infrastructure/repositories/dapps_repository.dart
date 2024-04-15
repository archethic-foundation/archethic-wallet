import 'dart:convert';

import 'package:aewallet/domain/models/dapp.dart';
import 'package:aewallet/domain/repositories/dapps/dapps_repository.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/services.dart';

class DAppsRepositoryImpl implements DAppsRepositoryInterface {
  Future<List<DApp>> _getDAppsLocal() async {
    final dApps = <DApp>[];
    final jsonContent =
        await rootBundle.loadString('lib/domain/repositories/dapps/dapps.json');

    final Map<String, dynamic> jsonMap = jsonDecode(jsonContent);
    if (jsonMap['DApps'] != null) {
      for (final dapp in jsonMap['DApps'] as List) {
        dApps.add(
          DApp(
            code: dapp['code'],
            url: dapp['url'],
            accessToken: dapp['accessToken'] ?? '',
          ),
        );
      }
    }

    return dApps;
  }

  @override
  Future<DApp?> getDApp(
    AvailableNetworks network,
    String code,
  ) async {
    final dapps = await getDAppsFromNetwork(network);
    return dapps.firstWhere(
      (element) => element.code.toUpperCase() == code.toUpperCase(),
    );
  }

  @override
  Future<List<DApp>> getDAppsFromNetwork(
    AvailableNetworks network,
  ) async {
    final dApps = await _getDAppsLocal();
    switch (network) {
      // TODO(reddwarf03): Get true addresses
      case AvailableNetworks.archethicTestNet:
        return _getDAppsFromBlockchain(
          '0000b01e7a497f0576a004c5957d14956e165a6f301d76cda35ba49be4444dac00eb',
        );
      case AvailableNetworks.archethicMainNet:
        return _getDAppsFromBlockchain(
          '000030ed4ed79a05cfaa90b803c0ba933307de9923064651975b59047df3aaf223bb',
        );
      case AvailableNetworks.archethicDevNet:
        return dApps;
    }
  }

  Future<List<DApp>> _getDAppsFromBlockchain(
    String txAddress,
  ) async {
    final dAppsFromBlockchain = <DApp>[];
    final lastAddressMap = await sl
        .get<ApiService>()
        .getLastTransaction([txAddress], request: 'data { content }');
    if (lastAddressMap[txAddress] != null &&
        lastAddressMap[txAddress]!.data != null &&
        lastAddressMap[txAddress]!.data!.content != null) {
      final Map<String, dynamic> jsonMap =
          jsonDecode(lastAddressMap[txAddress]!.data!.content!);
      if (jsonMap['DApps'] != null) {
        for (final dapp in jsonMap['DApps'] as List) {
          dAppsFromBlockchain.add(
            DApp(
              code: dapp['code'],
              url: dapp['url'],
              accessToken: dapp['accessToken'] ?? '',
            ),
          );
        }
      }
    }
    return dAppsFromBlockchain;
  }
}
