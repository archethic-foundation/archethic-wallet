import 'dart:convert';

import 'package:aewallet/application/api_service.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/modules/aeswap/application/farm/farm_lock_factory.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_farm_lock_user_infos_response.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
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
Future<double> airdropPersonalRewards(
  Ref ref,
) async {
  final keychain = ref.watch(
    sessionNotifierProvider.select(
      (value) => value.loggedIn?.wallet.appKeychain,
    ),
  );

  if (keychain == null) return 0.0;

  final apiService = ref.watch(apiServiceProvider);
  final farmLock = ref.watch(farmLockFormFarmLockProvider).valueOrNull;

  if (farmLock == null) return 0.0;

  final farmFactory = FarmLockFactory(farmLock.farmAddress, apiService);

  var personalLP = 0.0;
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
        personalLP += userInfosResponse.amount;
      }
    }
  }
  return personalLP;
}

@riverpod
Future<int?> airdropPersonalMultiplier(
  Ref ref,
) async {
  final airdropPersonalRewards =
      await ref.watch(airdropPersonalRewardsProvider.future);

  return _getMultiplier(airdropPersonalRewards);
}

int? _getMultiplier(double x) {
  if (1 <= x && x < 5) {
    return 1;
  } else if (5 <= x && x < 20) {
    return 2;
  } else if (20 <= x && x < 60) {
    return 3;
  } else if (60 <= x && x < 150) {
    return 5;
  } else if (150 <= x && x < 300) {
    return 8;
  } else if (300 <= x && x < 500) {
    return 13;
  } else if (500 <= x && x < 750) {
    return 21;
  } else if (750 <= x && x < 1000) {
    return 34;
  } else if (x >= 1000) {
    return 55;
  } else {
    return null;
  }
}
