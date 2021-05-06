// @dart=2.9

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:event_taxi/event_taxi.dart';
import 'package:logger/logger.dart';
import 'package:uniris_mobile_wallet/bus/events.dart';
import 'package:uniris_mobile_wallet/model/token_ref.dart';
import 'package:uniris_mobile_wallet/network/model/response/address_txs_response.dart';
import 'package:uniris_mobile_wallet/network/model/response/servers_wallet_legacy.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_aed.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_ars.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_aud.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_brl.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_btc.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_cad.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_chf.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_clp.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_cny.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_czk.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_dkk.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_eur.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_gbp.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_hkd.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_huf.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_idr.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_ils.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_inr.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_jpy.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_krw.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_kwd.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_mxn.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_myr.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_nok.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_nzd.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_php.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_pkr.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_pln.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_rub.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_sar.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_sek.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_sgd.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_thb.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_try.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_twd.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_usd.dart';
import 'package:uniris_mobile_wallet/network/model/response/simple_price_response_zar.dart';
import 'package:uniris_mobile_wallet/network/model/response/tokens_balance_get_response.dart';
import 'package:uniris_mobile_wallet/network/model/response/tokens_list_get_response.dart';
import 'package:uniris_mobile_wallet/service_locator.dart';
import 'package:uniris_mobile_wallet/util/sharedprefsutil.dart';

class HttpService {
  final Logger log = sl.get<Logger>();

  Future<ServerWalletLegacyResponse> getBestServerWalletLegacyResponse() async {
    List<ServerWalletLegacyResponse> serverWalletLegacyResponseList =
        new List<ServerWalletLegacyResponse>();
    ServerWalletLegacyResponse serverWalletLegacyResponse =
        new ServerWalletLegacyResponse();

    String walletServer = await sl.get<SharedPrefsUtil>().getWalletServer();
    if (walletServer != "auto") {
      if (walletServer.split(":").length > 1) {
        serverWalletLegacyResponse.ip = walletServer.split(":")[0];
        serverWalletLegacyResponse.port =
            int.tryParse(walletServer.split(":")[1]);
      }

      return serverWalletLegacyResponse;
    }

    HttpClient httpClient = new HttpClient();
    try {
      HttpClientRequest request = await httpClient.getUrl(
          Uri.parse("https://api.bismuth.live/servers/wallet/legacy.json"));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        //print("serverWalletLegacyResponseList=" + reply);
        serverWalletLegacyResponseList =
            serverWalletLegacyResponseFromJson(reply);

        // Best server active with less clients
        serverWalletLegacyResponseList
            .removeWhere((element) => element.active == false);
        serverWalletLegacyResponseList.sort((a, b) {
          return a.clients
              .toString()
              .toLowerCase()
              .compareTo(b.clients.toString().toLowerCase());
        });
        if (serverWalletLegacyResponseList.length > 0) {
          serverWalletLegacyResponse = serverWalletLegacyResponseList[0];
        }
      }
    } catch (e) {
      print(e);
    } finally {
      httpClient.close();
    }
    //print("Server Wallet : " +
    //    serverWalletLegacyResponse.ip +
    //    ":" +
    //    serverWalletLegacyResponse.port.toString());
    return serverWalletLegacyResponse;
  }

  Future<SimplePriceResponse> getSimplePrice(String currency) async {
      //print("getSimplePrice");
    SimplePriceResponse simplePriceResponse = new SimplePriceResponse();
    simplePriceResponse.currency = currency;

    HttpClient httpClient = new HttpClient();
    try {
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://api.coingecko.com/api/v3/simple/price?ids=uniris&vs_currencies=BTC"));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        SimplePriceBtcResponse simplePriceBtcResponse =
            simplePriceBtcResponseFromJson(reply);
        simplePriceResponse.btcPrice = simplePriceBtcResponse.uniris.btc;
      }

      request = await httpClient.getUrl(Uri.parse(
          "https://api.coingecko.com/api/v3/simple/price?ids=uniris&vs_currencies=" +
              currency));
      request.headers.set('content-type', 'application/json');
      response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        switch (currency.toUpperCase()) {
          case "ARS":
            SimplePriceArsResponse simplePriceLocalResponse =
                simplePriceArsResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.ars;
            break;
          case "AUD":
            SimplePriceAudResponse simplePriceLocalResponse =
                simplePriceAudResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.aud;
            break;
          case "BRL":
            SimplePriceBrlResponse simplePriceLocalResponse =
                simplePriceBrlResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.brl;
            break;
          case "CAD":
            SimplePriceCadResponse simplePriceLocalResponse =
                simplePriceCadResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.cad;
            break;
          case "CHF":
            SimplePriceChfResponse simplePriceLocalResponse =
                simplePriceChfResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.chf;
            break;
          case "CLP":
            SimplePriceClpResponse simplePriceLocalResponse =
                simplePriceClpResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.clp;
            break;
          case "CNY":
            SimplePriceCnyResponse simplePriceLocalResponse =
                simplePriceCnyResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.cny;
            break;
          case "CZK":
            SimplePriceCzkResponse simplePriceLocalResponse =
                simplePriceCzkResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.czk;
            break;
          case "DKK":
            SimplePriceDkkResponse simplePriceLocalResponse =
                simplePriceDkkResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.dkk;
            break;
          case "EUR":
            SimplePriceEurResponse simplePriceLocalResponse =
                simplePriceEurResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.eur;
            break;
          case "GBP":
            SimplePriceGbpResponse simplePriceLocalResponse =
                simplePriceGbpResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.gbp;
            break;
          case "HKD":
            SimplePriceHkdResponse simplePriceLocalResponse =
                simplePriceHkdResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.hkd;
            break;
          case "HUF":
            SimplePriceHufResponse simplePriceLocalResponse =
                simplePriceHufResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.huf;
            break;
          case "IDR":
            SimplePriceIdrResponse simplePriceLocalResponse =
                simplePriceIdrResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.idr;
            break;
          case "ILS":
            SimplePriceIlsResponse simplePriceLocalResponse =
                simplePriceIlsResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.ils;
            break;
          case "INR":
            SimplePriceInrResponse simplePriceLocalResponse =
                simplePriceInrResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.inr;
            break;
          case "JPY":
            SimplePriceJpyResponse simplePriceLocalResponse =
                simplePriceJpyResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.jpy;
            break;
          case "KRW":
            SimplePriceKrwResponse simplePriceLocalResponse =
                simplePriceKrwResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.krw;
            break;
          case "KWD":
            SimplePriceKwdResponse simplePriceLocalResponse =
                simplePriceKwdResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.kwd;
            break;
          case "MXN":
            SimplePriceMxnResponse simplePriceLocalResponse =
                simplePriceMxnResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.mxn;
            break;
          case "MYR":
            SimplePriceMyrResponse simplePriceLocalResponse =
                simplePriceMyrResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.myr;
            break;
          case "NOK":
            SimplePriceNokResponse simplePriceLocalResponse =
                simplePriceNokResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.nok;
            break;
          case "NZD":
            SimplePriceNzdResponse simplePriceLocalResponse =
                simplePriceNzdResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.nzd;
            break;
          case "PHP":
            SimplePricePhpResponse simplePriceLocalResponse =
                simplePricePhpResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.php;
            break;
          case "PKR":
            SimplePricePkrResponse simplePriceLocalResponse =
                simplePricePkrResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.pkr;
            break;
          case "PLN":
            SimplePricePlnResponse simplePriceLocalResponse =
                simplePricePlnResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.pln;
            break;
          case "RUB":
            SimplePriceRubResponse simplePriceLocalResponse =
                simplePriceRubResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.rub;
            break;
          case "SAR":
            SimplePriceSarResponse simplePriceLocalResponse =
                simplePriceSarResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.sar;
            break;
          case "SEK":
            SimplePriceSekResponse simplePriceLocalResponse =
                simplePriceSekResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.sek;
            break;
          case "SGD":
            SimplePriceSgdResponse simplePriceLocalResponse =
                simplePriceSgdResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.sgd;
            break;
          case "THB":
            SimplePriceThbResponse simplePriceLocalResponse =
                simplePriceThbResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.thb;
            break;
          case "TRY":
            SimplePriceTryResponse simplePriceLocalResponse =
                simplePriceTryResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.tryl;
            break;
          case "TWD":
            SimplePriceTwdResponse simplePriceLocalResponse =
                simplePriceTwdResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.twd;
            break;
          case "AED":
            SimplePriceAedResponse simplePriceLocalResponse =
                simplePriceAedResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.aed;
            break;
          case "ZAR":
            SimplePriceZarResponse simplePriceLocalResponse =
                simplePriceZarResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.zar;
            break;
          case "USD":
          default:
            SimplePriceUsdResponse simplePriceLocalResponse =
                simplePriceUsdResponseFromJson(reply);
            simplePriceResponse.localCurrencyPrice =
                simplePriceLocalResponse.uniris.usd;
            break;
        }
      }
      // Post to callbacks
      EventTaxiImpl.singleton().fire(PriceEvent(response: simplePriceResponse));
    } catch (e) {} finally {
      httpClient.close();
    }
    return simplePriceResponse;
  }

  Future<bool> isTokensBalance(String address) async {
    HttpClient httpClient = new HttpClient();
    try {
      String tokensApi = await sl.get<SharedPrefsUtil>().getTokensApi();
      Uri uri;
      try {
        uri = Uri.parse(tokensApi + address);
      } catch (FormatException) {
        return false;
      }

      HttpClientRequest request = await httpClient.getUrl(uri);
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        var tokensBalanceGetResponse = tokensBalanceGetResponseFromJson(reply);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<BisToken>> getTokensBalance(String address) async {
    List<BisToken> bisTokenList = new List<BisToken>();

    HttpClient httpClient = new HttpClient();
    try {
      String tokensApi = await sl.get<SharedPrefsUtil>().getTokensApi();
      HttpClientRequest request =
          await httpClient.getUrl(Uri.parse(tokensApi + address));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        var tokensBalanceGetResponse = tokensBalanceGetResponseFromJson(reply);

        for (int i = 0; i < tokensBalanceGetResponse.length; i++) {
          BisToken bisToken = new BisToken(
              tokenName: tokensBalanceGetResponse[i][0],
              tokensQuantity: tokensBalanceGetResponse[i][1]);
          bisTokenList.add(bisToken);
        }
      }
    } catch (e) {}
    return bisTokenList;
  }

  Future<List<TokenRef>> getTokensReflist() async {
    List<TokenRef> tokensRefList = new List<TokenRef>();

    HttpClient httpClient = new HttpClient();
    try {
      HttpClientRequest request = await httpClient
          .getUrl(Uri.parse("https://uco.today/api/tokens/"));
      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        String reply = await response.transform(utf8.decoder).join();
        var tokensRefListGetResponse = tokensListGetResponseFromJson(reply);

        for (int i = 0; i < tokensRefListGetResponse.length; i++) {
          TokenRef tokenRef = new TokenRef();
          tokenRef.token = tokensRefListGetResponse.keys.elementAt(i);
          tokenRef.creator = tokensRefListGetResponse.values.elementAt(i)[0];
          tokenRef.totalSupply =
              tokensRefListGetResponse.values.elementAt(i)[1];
          tokenRef.creationDate = DateTime.fromMillisecondsSinceEpoch(
              (tokensRefListGetResponse.values.elementAt(i)[2] * 1000).toInt());
          tokensRefList.add(tokenRef);
        }
      }
    } catch (e) {}
    return tokensRefList;
  }
}
