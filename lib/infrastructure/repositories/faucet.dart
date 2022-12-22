import 'dart:convert';
import 'dart:io';

import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/faucet.dart';
import 'package:aewallet/infrastructure/datasources/hive_preferences.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

@immutable
class FaucetLimitReachedDTO {
  const FaucetLimitReachedDTO({
    required this.unlockTime,
  });

  factory FaucetLimitReachedDTO.fromJson(Map<String, dynamic> json) =>
      FaucetLimitReachedDTO(
        unlockTime: DateTime.fromMillisecondsSinceEpoch(
          json['unlockTime'] * 1000,
          isUtc: true,
        ),
      );

  final DateTime unlockTime;
}

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
    required String keychainAddress,
    required String deviceId,
    required String captchaToken,
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
            'keychainAddress': keychainAddress,
            'token': captchaToken,
          }),
        );

        try {
          if (response.statusCode == 429) {
            final jsonResponse = json.decode(response.body);
            if (jsonResponse['reason'] == 'Limit reached') {
              final limitReachedResponse =
                  FaucetLimitReachedDTO.fromJson(jsonResponse);
              throw Failure.quotaExceeded(
                cooldownEndDate: limitReachedResponse.unlockTime,
              );
            }
          }
        } on FormatException catch (_) {}

        if (response.statusCode != 200) {
          throw const Failure.other();
        }

        final body = json.decode(response.body);

        return body['challenge'].toString();
      });

  @override
  Future<Result<DateTime, Failure>> claim({
    required String challenge,
    required String deviceId,
    required String recipientAddress,
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
            'recipientAddress': recipientAddress,
            'keychainAddress': keychainAddress,
          }),
        );

        try {
          final jsonResponse = json.decode(response.body);
          if (jsonResponse['reason'] == 'Limit reached') {
            final limitReachedResponse =
                FaucetLimitReachedDTO.fromJson(jsonResponse);

            throw Failure.quotaExceeded(
              cooldownEndDate: limitReachedResponse.unlockTime,
            );
          }

          if (jsonResponse['message'] == 'Unauthorized') {
            throw const Failure.unauthorized();
          }
        } on FormatException catch (_) {}

        if (response.statusCode != 200) {
          if (response.body.contains('Insufficient funds')) {
            throw const Failure.insufficientFunds();
          }
          throw const Failure.other();
        }

        final unlockTime = DateTime.fromMillisecondsSinceEpoch(
          json.decode(response.body)['unlockTime'] * 1000,
          isUtc: true,
        );
        return unlockTime;
      });

  @override
  Future<DateTime?> getClaimCooldownEndDate() async {
    return (await preferences).getFaucetClaimCooldownEndDate();
  }

  @override
  Future<void> setClaimCooldownEndDate({required DateTime date}) async {
    (await preferences).setFaucetClaimCooldownEndDate(date);
  }

  @override
  Future<void> clear() async {
    (await preferences).clearFaucetClaimCooldownEndDate();
  }

  @override
  Future<Result<bool, Failure>> isFaucetEnabled() async => Result.guard(
        () async {
          try {
            final response = await http
                .get(
                  Uri.parse(
                    _FaucetRoutes().status,
                  ),
                )
                .timeout(const Duration(seconds: 1));

            if (response.statusCode == 429) {
              throw const Failure.quotaExceeded();
            }

            return response.statusCode == 200 && response.body == 'up';
          } on Failure catch (_) {
            rethrow;
          } catch (e) {
            throw const Failure.other();
          }
        },
      );
}
