import 'package:aewallet/domain/models/dapp.dart';
import 'package:aewallet/infrastructure/repositories/dapps_repository.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dapps.g.dart';

@riverpod
DAppsRepositoryImpl _dAppsRepository(
  _DAppsRepositoryRef ref,
) =>
    DAppsRepositoryImpl();

@riverpod
Future<DApp?> _getDApp(
  _GetDAppRef ref,
  AvailableNetworks network,
  String code,
) async {
  return ref.watch(_dAppsRepositoryProvider).getDApp(network, code);
}

@riverpod
Future<List<DApp>> _getDAppsFromNetwork(
  _GetDAppsFromNetworkRef ref,
  AvailableNetworks network,
) async {
  final dAppsFromNetwork =
      await ref.read(_dAppsRepositoryProvider).getDAppsFromNetwork(network);
  return dAppsFromNetwork;
}

abstract class DAppsProviders {
  static const getDApp = _getDAppProvider;
  static const getDAppsFromNetwork = _getDAppsFromNetworkProvider;
}
