import 'dart:convert';

import 'package:aewallet/domain/models/onramp.dart';
import 'package:aewallet/domain/repositories/on_ramp.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

part 'on_ramp_provider.transak.dto.dart';

class OnRampProviderTransakRepository implements OnRampProviderRepository {
  factory OnRampProviderTransakRepository.staging() =>
      OnRampProviderTransakRepository._(
        envName: 'STAGING',
        apiKey: const String.fromEnvironment('TRANSAK_STAGING_API_KEY'),
        apiBaseUrl: 'https://api-stg.transak.com/api/',
        widgetHost: 'global-stg.transak.com',
      );

  factory OnRampProviderTransakRepository.production() =>
      OnRampProviderTransakRepository._(
        envName: 'PROD',
        apiKey: const String.fromEnvironment('TRANSAK_API_KEY'),
        apiBaseUrl: 'https://api.transak.com/api/',
        widgetHost: 'global.transak.com',
      );
  OnRampProviderTransakRepository._({
    required this.envName,
    required this.apiKey,
    required this.apiBaseUrl,
    required this.widgetHost,
  }) {
    _logger = Logger('OnRampProviderRepository.Transak[$envName]');
  }

  late final Logger _logger;

  final String apiKey;
  final String apiBaseUrl;
  final String widgetHost;
  final String envName;

  @override
  Future<List<OnRampProviderToken>> tokens() async {
    final body = await _get('/v2/currencies/crypto-currencies');

    return switch (body) {
      {'response': final List<dynamic> response} => response
          .map(
            (jsonToken) {
              try {
                return _onRampProviderTokenFromTransakJson(
                  jsonToken as Map<String, dynamic>,
                );
              } catch (e) {
                _logger.warning(e);
                return null;
              }
            },
          )
          .whereType<OnRampProviderToken>()
          .toList(),
      _ => throw Exception('Invalid response format'),
    };
  }

  Future<dynamic> _get(String path) async {
    final response = await http.get(Uri.parse('$apiBaseUrl$path'));

    return switch (response.statusCode) {
      200 => jsonDecode(response.body),
      _ => throw Exception('Unexpected error: ${response.statusCode}')
    };
  }

  @override
  Uri orderTrackUrl({required String orderId}) => Uri.https(
        widgetHost,
        '/user/order/$orderId',
      );

  @override
  Uri checkoutUri({
    required String depositAddress,
    required String tokenId,
    required String chainId,
  }) =>
      Uri.https(
        widgetHost,
        '/',
        {
          'apiKey': apiKey,
          'environment': 'STAGING',
          'walletAddress': depositAddress,
          'disableWalletAddressForm': 'true',
          'hideMenu': 'true',
          'networks': chainId, //polygon
          'cryptoCurrencyList': tokenId, // WETH
          'walletRedirection': 'true',
          'colorMode': 'DARK',
          'redirectURL': 'aewallet://archethic.tech/home',
        },
      );
}
