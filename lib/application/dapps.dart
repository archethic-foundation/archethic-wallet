import 'dart:convert';

import 'package:aewallet/domain/models/dapps.dart';
import 'package:aewallet/infrastructure/repositories/dapps_list.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dapps.g.dart';

@riverpod
DAppsRepository _dAppsRepository(
  _DAppsRepositoryRef ref,
) =>
    DAppsRepository();

@riverpod
Future<List<DApps>> _getDApps(
  _GetDAppsRef ref,
) async {
  final dApps = await ref.watch(_dAppsRepositoryProvider).getDApps();
  return dApps;
}

@riverpod
Future<List<DApps>> _getDAppsFromNetwork(
  _GetDAppsFromNetworkRef ref,
  AvailableNetworks network,
) async {
  final dAppsFromNetwork =
      await ref.read(_dAppsRepositoryProvider).getDAppsFromNetwork(network);
  return dAppsFromNetwork;
}

class DAppsRepository {
  Future<List<DApps>> getDApps() async {
    return DAppsList().getDApps();
  }

  Future<List<DApps>> getDAppsFromNetwork(
    AvailableNetworks network,
  ) async {
    final dApps = await getDApps();
    switch (network) {
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

  Future<List<DApps>> _getDAppsFromBlockchain(
    String txAddress,
  ) async {
    final dAppsFromBlockchain = <DApps>[];
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
            DApps(
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

abstract class DAppsProviders {
  static final getDApps = _getDAppsProvider;
  static const getDAppsFromNetwork = _getDAppsFromNetworkProvider;
}
