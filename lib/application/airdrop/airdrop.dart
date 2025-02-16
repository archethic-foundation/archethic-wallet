import 'dart:convert';
import 'dart:typed_data';

import 'package:aewallet/application/airdrop/airdrop_notifier.dart';
import 'package:aewallet/application/api_service.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/model/airdrop.dart';
import 'package:aewallet/modules/aeswap/application/farm/farm_lock_factory.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_farm_lock_user_infos_response.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'airdrop.g.dart';

final _logger = Logger('airDropProvider');

@riverpod
Future<({int? participantCount, int? totalMultiplier})> airdropCount(
  Ref ref,
) async {
  try {
    final response = await http.get(
      Uri.parse(
        'https://airdrop-backend.archethic.net/airdrop-count',
      ),
    );

    if (response.statusCode == 200) {
      final bodyJson = jsonDecode(response.body);
      return (
        participantCount: bodyJson['participant_count'] as int?,
        totalMultiplier: bodyJson['total_multiplier'] as int?,
      );
    }
  } catch (e) {
    _logger.severe('airdropCount error : $e');
  }
  return (
    participantCount: null,
    totalMultiplier: null,
  );
}

// TODO(reddwarf03): Perhaps not necessary because of backend calculation - See airdropUserInfo
@riverpod
Future<({double personalLP, double personalLPFlexible})> airdropPersonalLP(
  Ref ref,
) async {
  var personalLP = 0.0;
  var personalLPFlexible = 0.0;

  final keychain = ref.watch(
    sessionNotifierProvider.select(
      (value) => value.loggedIn?.wallet.appKeychain,
    ),
  );

  if (keychain == null) {
    return (personalLP: personalLP, personalLPFlexible: personalLPFlexible);
  }

  final apiService = ref.watch(apiServiceProvider);
  final farmLock = ref.watch(farmLockFormFarmLockProvider).valueOrNull;

  if (farmLock == null) {
    return (personalLP: personalLP, personalLPFlexible: personalLPFlexible);
  }

  final farmFactory = FarmLockFactory(farmLock.farmAddress, apiService);

  final userGenesisAddresses =
      keychain.accounts.map((account) => account.genesisAddress).toList();

  const batchSize = 20;

  for (var i = 0; i < userGenesisAddresses.length; i += batchSize) {
    final batch = userGenesisAddresses.sublist(
      i,
      (i + batchSize > userGenesisAddresses.length)
          ? userGenesisAddresses.length
          : i + batchSize,
    );

    final results = await farmFactory.getUserInfosFromMultipleAddresses(batch);

    for (final result in results) {
      for (final userInfos in result) {
        final userInfosResponse = UserInfos.fromJson(userInfos!);
        if (userInfosResponse.level == '0') {
          personalLPFlexible += userInfosResponse.amount;
        } else {
          personalLP += userInfosResponse.amount;
        }
      }
    }
  }

  final airdropNotifier = ref.read(airdropNotifierProvider.notifier);
  await airdropNotifier.updateUserInfo(
    personalMultiplier: Airdrop.airdropPersonalMultiplier(personalLP) ?? 0,
    personalLPAmount: personalLP,
    personalLPFlexibleAmount: personalLPFlexible,
  );
  return (personalLP: personalLP, personalLPFlexible: personalLPFlexible);
}

@riverpod
Future<void> airdropUserInfo(
  Ref ref,
) async {
  try {
    final session = ref.watch(sessionNotifierProvider).loggedIn;
    final keychainKeypair = archethic.deriveKeyPair(
      archethic.uint8ListToHex(
        Uint8List.fromList(session!.wallet.keychainSecuredInfos.seed),
      ),
      0,
    );

    final timestamp =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    final publicKey = archethic.uint8ListToHex(keychainKeypair.publicKey!);
    final signedPayload = archethic.sign(
      '$publicKey$timestamp',
      keychainKeypair.privateKey,
      isDataHexa: false,
    );

    final response = await http.get(
      Uri.parse(
        'https://airdrop-backend.archethic.net/airdrop-user-info?pubkey=$publicKey',
      ),
      headers: {
        'x-public-key': base64Encode(utf8.encode(publicKey)),
        'x-timestamp': timestamp,
        'x-signature': base64Url.encode(signedPayload),
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final airdropNotifier = ref.read(airdropNotifierProvider.notifier);
      await airdropNotifier.updateUserInfo(
        personalMultiplier: json['personal_multiplier'] ?? 0,
        personalLPAmount: json['personal_lp'] ?? 0.0,
        personalLPFlexibleAmount: json['personal_lp_flexible'] ?? 0.0,
        isMailConfirmed: json['confirmed'],
        email: json['email'],
        referralCode: json['referralCode'],
      );
    } else if (response.statusCode == 400) {
      _logger.severe('Bad Request: Missing headers or invalid timestamp');
    } else if (response.statusCode == 401) {
      _logger.severe('Unauthorized: Invalid signature');
    }
  } catch (e) {
    _logger.severe('airdropUserInfo error : $e');
  }
}

@riverpod
Future<http.Response?> resendConfirmationMail(
  Ref ref,
  String mailAddress,
) async {
  try {
    final payload = {
      'email': mailAddress,
    };
    final response = await http.post(
      Uri.parse(
        'https://airdrop-backend.archethic.net/resend-confirmation-email',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
    );

    return response;
  } catch (e) {
    return null;
  }
}
