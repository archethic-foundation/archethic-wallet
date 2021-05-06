import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:uniris_mobile_wallet/network/model/response/coins_price_response.dart';
import 'package:uniris_mobile_wallet/network/model/response/coins_response.dart';


class ApiCoinsService {
  var logger = Logger();

  Future<CoinsResponse> getCoinsResponse() async {
    CoinsResponse? coinsResponse;
    HttpClient httpClient = new HttpClient();
    try {
      HttpClientRequest request = await httpClient
          .getUrl(Uri.parse("https://api.coingecko.com/api/v3/coins/uniris"));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        coinsResponse = coinsResponseFromJson(reply);
      }
    } catch (e, s) {
    } finally {
      httpClient.close();
    }
    return coinsResponse!;
  }

  Future<CoinsPriceResponse> getCoinsChart(String currency, int nbDays) async {
    CoinsPriceResponse? coinsPriceResponse;
    HttpClient httpClient = new HttpClient();
    try {
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://api.coingecko.com/api/v3/coins/uniris/market_chart?vs_currency=" +
              currency +
              "&days=" +
              nbDays.toString()));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        coinsPriceResponse = coinsPriceResponseFromJson(reply);
      }
    } catch (e, s) {
    } finally {
      httpClient.close();
    }
    return coinsPriceResponse!;
  }
}
