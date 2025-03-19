import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transak.g.dart';

// TODO(Chralu): parametrize with chosen tokens and chains.
@riverpod
Uri transakWebpageUri(
  Ref ref, {
  // required String tokenId,
  // required String chainId,
  required String depositAddress,
}) {
  return Uri.https(
    'global-stg.transak.com',
    '/',
    {
      'apiKey': const String.fromEnvironment('TRANSAK_API_KEY'),
      'environment': 'STAGING',
      'walletAddress': depositAddress,
      'disableWalletAddressForm': 'true',
      'hideMenu': 'true',
      'networks': 'polygon',
      'cryptoCurrencyList': 'WETH',
      'walletRedirection': 'true',
      'colorMode': 'DARK',
      'redirectURL': 'aewallet://archethic.tech/home',
    },
  );
}
