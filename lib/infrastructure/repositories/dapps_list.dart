/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:convert';
import 'package:aewallet/domain/models/dapps.dart';
import 'package:aewallet/domain/repositories/dapps/dapps_repository.dart';
import 'package:flutter/services.dart';

class DAppsList implements DAppsRepositoryInterface {
  @override
  Future<List<DApps>> getDApps() async {
    final jsonContent =
        await rootBundle.loadString('lib/domain/repositories/dapps/dapps.json');

    final Map<String, dynamic> jsonData = json.decode(jsonContent);

    return jsonData['DApps'];
  }
}
