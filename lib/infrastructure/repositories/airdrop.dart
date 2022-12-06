import 'dart:convert';
import 'dart:io';

import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/airdrop.dart';
import 'package:aewallet/infrastructure/datasources/hive_preferences.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class _AirDropRoutes {
  String get uriRoot => 'http://192.168.1.20:3000';
  String get challenge => '$uriRoot/challenge';
  String get claim => '$uriRoot/claim';
}

class AirDropRepository implements AirDropRepositoryInterface {
  HivePreferencesDatasource? _preferences;
  Future<HivePreferencesDatasource> get preferences async =>
      _preferences ??= await HivePreferencesDatasource.getInstance();

  @override
  Future<Result<String, Failure>> requestChallenge({
    required String deviceId,
  }) async =>
      Result.guard(() async {
        final response = await http.post(
          Uri.parse(
            _AirDropRoutes().challenge,
          ),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: json.encode({
            'deviceId': deviceId,
          }),
        );

        if (response.statusCode == 429) {
          throw const Failure.quotaExceeded();
        }

        if (response.statusCode != 200) {
          throw const Failure.other();
        }

        final body = json.decode(response.body);

        return body['challenge'].toString();
      });

  @override
  Future<Result<void, Failure>> requestAirDrop({
    required String challenge,
    required String deviceId,
    required String keychainAddress,
  }) async =>
      Result.guard(() async {
        await Future.delayed(Duration(seconds: 3));
        const airDropSecret = String.fromEnvironment('AIRDROP_SECRET');
        final key = utf8.encode(airDropSecret);
        final bytes = utf8.encode(challenge);
        final challengeHmac = Hmac(
          sha256,
          key,
        ).convert(bytes).toString();

        final response = await http.post(
          Uri.parse(
            _AirDropRoutes().claim,
          ),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: json.encode({
            'deviceId': deviceId,
            'challenge': challenge,
            'auth': challengeHmac,
            'keychainAddress': keychainAddress,
          }),
        );

        if (response.statusCode == 429) {
          throw const Failure.quotaExceeded();
        }

        if (response.statusCode != 200) {
          throw const Failure.other();
        }
        (await preferences).setLastAirdropDate(DateTime.now());
      });

  @override
  Future<DateTime?> getLastAirdropDate() async {
    return (await preferences).getLastAirdropDate();
  }

  @override
  Future<void> clear() async {
    (await preferences).clearLastAirdropDate();
  }
}
