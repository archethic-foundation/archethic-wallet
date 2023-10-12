import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/certified_tokens.dart';
import 'package:aewallet/infrastructure/repositories/certified_tokens_list.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'certified_tokens.g.dart';

@Riverpod(keepAlive: true)
CertifiedTokensRepository _certifiedTokensRepository(
  _CertifiedTokensRepositoryRef ref,
) =>
    CertifiedTokensRepository();

@Riverpod(keepAlive: true)
Future<CertifiedTokens> _getCertifiedTokens(
  _GetCertifiedTokensRef ref,
) async {
  final certifiedTokens =
      await ref.watch(_certifiedTokensRepositoryProvider).getCertifiedTokens();
  return certifiedTokens;
}

@Riverpod(keepAlive: true)
Future<List<String>> _getCertifiedTokensFromNetwork(
  _GetCertifiedTokensFromNetworkRef ref,
  AvailableNetworks network,
) async {
  final certifiedTokensFromNetwork = await ref
      .watch(_certifiedTokensRepositoryProvider)
      .getCertifiedTokensFromNetwork(network);
  return certifiedTokensFromNetwork;
}

@Riverpod(keepAlive: true)
Future<bool> _isCertifiedToken(
  _IsCertifiedTokenRef ref,
  String address,
) async {
  final networkSettings = ref.watch(
    SettingsProviders.settings.select((settings) => settings.network),
  );

  return ref
      .watch(_certifiedTokensRepositoryProvider)
      .isCertifiedToken(networkSettings.network, address);
}

class CertifiedTokensRepository {
  Future<CertifiedTokens> getCertifiedTokens() async {
    return CertifiedTokensList().getCertifiedTokens();
  }

  Future<List<String>> getCertifiedTokensFromNetwork(
    AvailableNetworks network,
  ) async {
    final certifiedTokens = await getCertifiedTokens();
    switch (network) {
      case AvailableNetworks.archethicTestNet:
        return certifiedTokens.testnet;
      case AvailableNetworks.archethicMainNet:
        return certifiedTokens.mainnet;
      case AvailableNetworks.archethicDevNet:
        return certifiedTokens.devnet;
    }
  }

  Future<bool> isCertifiedToken(
    AvailableNetworks network,
    String address,
  ) async {
    final certifiedTokens = await getCertifiedTokensFromNetwork(network);
    if (certifiedTokens.contains(address.toUpperCase())) {
      return true;
    }
    return false;
  }
}

abstract class CertifiedTokensProviders {
  static final getCertifiedTokens = _getCertifiedTokensProvider;
  static const isCertifiedToken = _isCertifiedTokenProvider;
  static const getCertifiedTokensFromNetwork =
      _getCertifiedTokensFromNetworkProvider;
}
