import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/verified_tokens.dart';
import 'package:aewallet/infrastructure/repositories/verified_tokens_list.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verified_tokens.g.dart';

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
      .watch(_verifiedTokensRepositoryProvider)
      .getVerifiedTokensFromNetwork(network);
  return verifiedTokensFromNetwork;
}

@Riverpod(keepAlive: true)
Future<bool> _isVerifiedToken(
  _IsVerifiedTokenRef ref,
  String address,
) async {
  final networkSettings = ref.watch(
    SettingsProviders.settings.select((settings) => settings.network),
  );

  return ref
      .watch(_verifiedTokensRepositoryProvider)
      .isVerifiedToken(networkSettings.network, address);
}

class VerifiedTokensRepository {
  Future<VerifiedTokens> getVerifiedTokens() async {
    return VerifiedTokensList().getVerifiedTokens();
  }

  Future<List<String>> getVerifiedTokensFromNetwork(
    AvailableNetworks network,
  ) async {
    final verifiedTokens = await getVerifiedTokens();
    switch (network) {
      case AvailableNetworks.archethicTestNet:
        return verifiedTokens.testnet;
      case AvailableNetworks.archethicMainNet:
        return verifiedTokens.mainnet;
      case AvailableNetworks.archethicDevNet:
        return verifiedTokens.devnet;
    }
  }

  Future<bool> isVerifiedToken(
    AvailableNetworks network,
    String address,
  ) async {
    final verifiedTokens = await getVerifiedTokensFromNetwork(network);
    if (verifiedTokens.contains(address.toUpperCase())) {
      return true;
    }
    return false;
  }
}

abstract class VerifiedTokensProviders {
  static final getVerifiedTokens = _getVerifiedTokensProvider;
  static const isVerifiedToken = _isVerifiedTokenProvider;
  static const getVerifiedTokensFromNetwork =
      _getVerifiedTokensFromNetworkProvider;
}
