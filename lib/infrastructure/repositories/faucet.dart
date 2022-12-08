import 'dart:convert';
import 'dart:io';

import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/faucet.dart';
import 'package:aewallet/infrastructure/datasources/hive_preferences.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class _FaucetRoutes {
  String get uriRoot => 'https://airdrop.archethic.net';
  String get status => '$uriRoot/status';
  String get challenge => '$uriRoot/challenge';
  String get claim => '$uriRoot/claim';
}

class FaucetRepository implements FaucetRepositoryInterface {
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
            _FaucetRoutes().challenge,
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
  Future<Result<void, Failure>> claim({
    required String challenge,
    required String deviceId,
    required String keychainAddress,
  }) async =>
      Result.guard(() async {
        const faucetSecret = String.fromEnvironment('AIRDROP_SECRET');
        final key = utf8.encode(faucetSecret);
        final bytes = utf8.encode(challenge);
        final challengeHmac = Hmac(
          sha256,
          key,
        ).convert(bytes).toString();

        final response = await http.post(
          Uri.parse(
            _FaucetRoutes().claim,
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
          if (response.body.contains('Insufficient funds')) {
            throw const Failure.insufficientFunds();
          }
          throw const Failure.other();
        }
      });

  @override
  Future<DateTime?> getLastClaimDate() async {
    return (await preferences).getLastFaucetClaimDate();
  }

  @override
  Future<void> setLastClaimDate() async {
    (await preferences).setLastFaucetClaimDate(DateTime.now());
  }

  @override
  Future<void> clear() async {
    (await preferences).clearLastFaucetClaimDate();
  }

  @override
  Future<bool> isFaucetEnabled() async {
    try {
      final response = await http.get(
        Uri.parse(
          _FaucetRoutes().status,
        ),
      );

      return response.statusCode == 200 && response.body == 'up';
    } catch (_) {
      return false;
    }
  }
}
