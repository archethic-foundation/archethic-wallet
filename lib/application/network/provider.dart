/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/available_networks.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
Future<List<Node>> _networkNodes(
  _NetworkNodesRef ref, {
  required AvailableNetworks network,
}) async {
  final networkSetting = NetworksSetting(
    network: network,
    networkDevEndpoint: '',
  );

  final link = networkSetting.getLink();

  final nodeListMain = await ApiService(
    link,
  ).getNodeList();

  return nodeListMain;
}

@riverpod
Future<bool> _isReservedNodeUri(
  _IsReservedNodeUriRef ref, {
  required Uri uri,
}) async {
  final nodeListMain = await ref.watch(
    _networkNodesProvider(
      network: AvailableNetworks.archethicMainNet,
    ).future,
  );
  final nodeListTest = await ref.watch(
    _networkNodesProvider(
      network: AvailableNetworks.archethicTestNet,
    ).future,
  );

  return nodeListMain.followedBy(nodeListTest).any(
        (node) => node.ip == uri.host && node.port == uri.port,
      );
}

abstract class NetworkProvider {
  static final networkNodes = _networkNodesProvider;
  static final isReservedNodeUri = _isReservedNodeUriProvider;
}
