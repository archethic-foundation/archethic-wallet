part of 'on_ramp_provider.transak.repository.dart';

OnRampProviderToken _onRampProviderTokenFromTransakJson(
  Map<String, dynamic> jsonToken,
) {
  return switch (jsonToken) {
    {
      'address': final String address,
      'symbol': final String providerTokenId,
      'network': {
        'chainId': final String chainId,
        'name': final String providerChainId
      },
    } =>
      (
        address: address.toLowerCase(),
        providerTokenId: providerTokenId,
        chain: (chainId: int.parse(chainId), providerChainId: providerChainId),
      ),
    _ => throw FormatException(
        'Invalid JSON format for OnRampTransakToken',
        jsonToken,
      ),
  };
}
