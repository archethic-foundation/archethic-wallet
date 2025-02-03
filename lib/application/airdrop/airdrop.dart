import 'dart:convert';
import 'dart:typed_data';

import 'package:aewallet/application/airdrop/airdrop_notifier.dart';
import 'package:aewallet/application/api_service.dart';
import 'package:aewallet/application/session/session.dart';
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
Future<int?> airdropCount(
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
      return bodyJson['count'];
    }
  } catch (e) {
    _logger.severe('airdropCount error : $e');
  }
  return null;
}

@riverpod
Future<bool> airdropCheck(
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

    final payload = {
      'pubkey': archethic.uint8ListToHex(keychainKeypair.publicKey!),
    };

    final response = await http.post(
      Uri.parse('https://airdrop-backend.archethic.net/check-email'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['exists'] == true) {
        final airdropNotifier = ref.read(airdropNotifierProvider.notifier);
        await airdropNotifier.updateMailFilled(true);
        return true;
      }
    }
  } catch (e) {
    _logger.severe('airdropCheck error : $e');
  }
  final airdropNotifier = ref.read(airdropNotifierProvider.notifier);
  await airdropNotifier.updateMailFilled(false);
  return false;
}

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
  await airdropNotifier.updatePersonalLPAmount(personalLP, personalLPFlexible);

  return (personalLP: personalLP, personalLPFlexible: personalLPFlexible);
}
