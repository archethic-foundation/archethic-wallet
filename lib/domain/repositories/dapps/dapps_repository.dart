/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/domain/models/dapp.dart';
import 'package:aewallet/model/available_networks.dart';

abstract class DAppsRepositoryInterface {
  Future<List<DApp>> getDAppsFromNetwork(
    AvailableNetworks network,
  );

  Future<DApp?> getDApp(
    AvailableNetworks network,
    String code,
  );
}
