/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:convert';
import 'package:aewallet/domain/repositories/farm_apr.repository.dart';
import 'package:http/http.dart' as http;

class FarmAPRRepositoryImpl implements FarmAPRRepositoryInterface {
  @override
  Future<Map<String, String>> fetchAPRFarm() async {
    final url = Uri.parse(
      'https://faas-lon1-917a94a7.doserverless.co/api/v1/web/fn-279bbae3-a757-4cef-ade7-a63bdaca36f7/mainnet/apr',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final defaultAPR = '${(data['apr'] as num).toStringAsFixed(0)}%';
        final defaultAPRDuration = data['level'];
        return {
          'defaultAPR': defaultAPR,
          'defaultAPRDuration': defaultAPRDuration,
        };
      } else {
        return {'defaultAPR': '___%', 'defaultAPRDuration': ''};
      }
    } catch (error) {
      return {'defaultAPR': '___%', 'defaultAPRDuration': ''};
    }
  }
}
