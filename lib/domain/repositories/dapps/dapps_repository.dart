/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/domain/models/dapps.dart';

abstract class DAppsRepositoryInterface {
  Future<List<DApps>> getDApps();
}
