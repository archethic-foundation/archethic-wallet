/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/domain/models/dapp.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

abstract class DAppsRepositoryInterface {
  Future<List<DApp>> getDAppsFromNetwork(
    AvailableNetworks network,
    ApiService apiService,
  );

  Future<DApp?> getDApp(
    AvailableNetworks network,
    String code,
    ApiService apiService,
  );
}
