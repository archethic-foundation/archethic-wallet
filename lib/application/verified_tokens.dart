import 'dart:convert';

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/verified_tokens.dart';
import 'package:aewallet/infrastructure/repositories/verified_tokens_list.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verified_tokens.g.dart';

@Riverpod(keepAlive: true)
class _VerifiedTokensNotifier extends Notifier<List<String>> {
  List<String>? verifiedTokensList;

  static final _logger = Logger('VerifiedTokensNotifier');

  @override
  List<String> build() {
    return const <String>[];
  }

  Future<void> init() async {
    await _getValue();
  }

  Future<void> _getValue() async {
    final networkSettings = ref.watch(
      SettingsProviders.settings.select((settings) => settings.network),
    );
    final verifiedTokensFromNetwork = await ref
        .watch(_verifiedTokensRepositoryProvider)
        .getVerifiedTokensFromNetwork(networkSettings.network);
    _logger.info(
      'Verified tokens list (${networkSettings.network}) $verifiedTokensFromNetwork',
    );
    state = verifiedTokensFromNetwork;
  }
}

@Riverpod(keepAlive: true)
VerifiedTokensRepository _verifiedTokensRepository(
  _VerifiedTokensRepositoryRef ref,
) =>
    VerifiedTokensRepository();

@Riverpod(keepAlive: true)
Future<VerifiedTokens> _getVerifiedTokens(
  _GetVerifiedTokensRef ref,
) async {
  final verifiedTokens =
      await ref.watch(_verifiedTokensRepositoryProvider).getVerifiedTokens();
  return verifiedTokens;
}

@Riverpod(keepAlive: true)
Future<List<String>> _getVerifiedTokensFromNetwork(
  _GetVerifiedTokensFromNetworkRef ref,
  AvailableNetworks network,
) async {
  final verifiedTokensFromNetwork = await ref
      .read(_verifiedTokensRepositoryProvider)
      .getVerifiedTokensFromNetwork(network);
  return verifiedTokensFromNetwork;
}

@Riverpod(keepAlive: true)
Future<bool> _isVerifiedToken(
  _IsVerifiedTokenRef ref,
  String address,
) async {
  final verifiedTokens = ref.watch(_verifiedTokensNotifierProvider);
  if (verifiedTokens.contains(address.toUpperCase())) {
    return true;
  }
  return false;
}

class VerifiedTokensRepository {
  static final _logger = Logger('VerifiedTokensRepository');

  Future<VerifiedTokens> getVerifiedTokens() async {
    return VerifiedTokensList().getVerifiedTokens();
  }

  /// TODO(Chralu): use dapp framework method
  Future<List<String>> getVerifiedTokensFromNetwork(
    AvailableNetworks network,
  ) async {
    final verifiedTokens = await getVerifiedTokens();
    switch (network) {
      case AvailableNetworks.archethicTestNet:
        return _getVerifiedTokensFromBlockchain(
          '0000b01e7a497f0576a004c5957d14956e165a6f301d76cda35ba49be4444dac00eb',
        );
      case AvailableNetworks.archethicMainNet:
        return _getVerifiedTokensFromBlockchain(
          '000030ed4ed79a05cfaa90b803c0ba933307de9923064651975b59047df3aaf223bb',
        );
      case AvailableNetworks.archethicDevNet:
        return verifiedTokens.devnet;
    }
  }

  Future<List<String>> _getVerifiedTokensFromBlockchain(
    String txAddress,
  ) async {
    final lastAddressMap = await sl
        .get<ApiService>()
        .getLastTransaction([txAddress], request: 'data { content }');
    if (lastAddressMap[txAddress] != null &&
        lastAddressMap[txAddress]!.data != null &&
        lastAddressMap[txAddress]!.data!.content != null) {
      final Map<String, dynamic> jsonMap =
          jsonDecode(lastAddressMap[txAddress]!.data!.content!);
      if (jsonMap['verifiedTokens'] != null &&
          jsonMap['verifiedTokens']['tokens'] != null) {
        _logger.info('Verified tokens ${jsonMap['verifiedTokens']['tokens']}');
        return List.from(jsonMap['verifiedTokens']['tokens']);
      }
    }
    return <String>[];
  }
}

abstract class VerifiedTokensProviders {
  static final getVerifiedTokens = _getVerifiedTokensProvider;
  static const isVerifiedToken = _isVerifiedTokenProvider;
  static const getVerifiedTokensFromNetwork =
      _getVerifiedTokensFromNetworkProvider;
  static final verifiedTokens = _verifiedTokensNotifierProvider;
}
