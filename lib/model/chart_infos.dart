/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/asset_history_interval.dart';
import 'package:aewallet/util/get_it_instance.dart';

import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show ApiCoinsService, CoinsPriceResponse, CoinsCurrentDataResponse;

class ChartInfos {
  ChartInfos(
      {this.data,
      this.priceChangePercentage1h,
      this.priceChangePercentage24h,
      this.priceChangePercentage14d,
      this.priceChangePercentage1y,
      this.priceChangePercentage200d,
      this.priceChangePercentage30d,
      this.priceChangePercentage60d,
      this.priceChangePercentage7d});

  List<AssetHistoryInterval>? data;
  double? priceChangePercentage1h = 0;
  double? priceChangePercentage14d = 0;
  double? priceChangePercentage1y = 0;
  double? priceChangePercentage200d = 0;
  double? priceChangePercentage30d = 0;
  double? priceChangePercentage60d = 0;
  double? priceChangePercentage7d = 0;
  double? priceChangePercentage24h = 0;

  double? getPriceChangePercentage(String duration) {
    switch (duration) {
      case '1h':
        return priceChangePercentage1h;
      case '24h':
        return priceChangePercentage24h;
      case '14d':
        return priceChangePercentage14d;
      case '1y':
        return priceChangePercentage1y;
      case '200d':
        return priceChangePercentage200d;
      case '30d':
        return priceChangePercentage30d;
      case '60d':
        return priceChangePercentage60d;
      case '7d':
        return priceChangePercentage7d;
      default:
        return priceChangePercentage1h;
    }
  }

  static String getChartOptionLabel(BuildContext context, String duration) {
    switch (duration) {
      case '1h':
        return AppLocalization.of(context)!.chartOptionLabel1h;
      case '24h':
        return AppLocalization.of(context)!.chartOptionLabel24h;
      case '14d':
        return AppLocalization.of(context)!.chartOptionLabel14d;
      case '1y':
        return AppLocalization.of(context)!.chartOptionLabel1y;
      case '200d':
        return AppLocalization.of(context)!.chartOptionLabel200d;
      case '30d':
        return AppLocalization.of(context)!.chartOptionLabel30d;
      case '60d':
        return AppLocalization.of(context)!.chartOptionLabel60d;
      case '7d':
        return AppLocalization.of(context)!.chartOptionLabel7d;
      default:
        return AppLocalization.of(context)!.chartOptionLabel1h;
    }
  }

  Future<void> updateCoinsChart(String currencyIso4217Code,
      {String option = '1h'}) async {
    int nbDays = 0;
    int nbHours = 0;
    switch (option) {
      case '1h':
        nbHours = 1;
        break;
      case '24h':
        nbDays = 1;
        break;
      case '7d':
        nbDays = 7;
        break;
      case '14d':
        nbDays = 14;
        break;
      case '30d':
        nbDays = 30;
        break;
      case '60d':
        nbDays = 60;
        break;
      case '200d':
        nbDays = 200;
        break;
      case '1y':
        nbDays = 365;
        break;
      default:
        nbHours = 1;
        break;
    }
    try {
      final CoinsCurrentDataResponse coinsCurrentDataResponse =
          await sl.get<ApiCoinsService>().getCoinsCurrentData(marketData: true);
      if (coinsCurrentDataResponse
                  .marketData!.priceChangePercentage24HInCurrency![
              currencyIso4217Code.toLowerCase()] !=
          null) {
        priceChangePercentage24h = coinsCurrentDataResponse
                .marketData!.priceChangePercentage24HInCurrency![
            currencyIso4217Code.toLowerCase()];
      } else {
        priceChangePercentage24h =
            coinsCurrentDataResponse.marketData!.priceChangePercentage24H;
      }
      if (coinsCurrentDataResponse
                  .marketData!.priceChangePercentage14DInCurrency![
              currencyIso4217Code.toLowerCase()] !=
          null) {
        priceChangePercentage14d = coinsCurrentDataResponse
                .marketData!.priceChangePercentage14DInCurrency![
            currencyIso4217Code.toLowerCase()];
      } else {
        priceChangePercentage14d =
            coinsCurrentDataResponse.marketData!.priceChangePercentage14D;
      }
      if (coinsCurrentDataResponse
                  .marketData!.priceChangePercentage1YInCurrency![
              currencyIso4217Code.toLowerCase()] !=
          null) {
        priceChangePercentage1y = coinsCurrentDataResponse
                .marketData!.priceChangePercentage1YInCurrency![
            currencyIso4217Code.toLowerCase()];
      } else {
        priceChangePercentage1y =
            coinsCurrentDataResponse.marketData!.priceChangePercentage1Y;
      }
      if (coinsCurrentDataResponse
                  .marketData!.priceChangePercentage200DInCurrency![
              currencyIso4217Code.toLowerCase()] !=
          null) {
        priceChangePercentage200d = coinsCurrentDataResponse
                .marketData!.priceChangePercentage200DInCurrency![
            currencyIso4217Code.toLowerCase()];
      } else {
        priceChangePercentage200d =
            coinsCurrentDataResponse.marketData!.priceChangePercentage200D;
      }
      if (coinsCurrentDataResponse
                  .marketData!.priceChangePercentage30DInCurrency![
              currencyIso4217Code.toLowerCase()] !=
          null) {
        priceChangePercentage30d = coinsCurrentDataResponse
                .marketData!.priceChangePercentage30DInCurrency![
            currencyIso4217Code.toLowerCase()];
      } else {
        priceChangePercentage30d =
            coinsCurrentDataResponse.marketData!.priceChangePercentage30D;
      }
      if (coinsCurrentDataResponse
                  .marketData!.priceChangePercentage60DInCurrency![
              currencyIso4217Code.toLowerCase()] !=
          null) {
        priceChangePercentage60d = coinsCurrentDataResponse
                .marketData!.priceChangePercentage60DInCurrency![
            currencyIso4217Code.toLowerCase()];
      } else {
        priceChangePercentage60d =
            coinsCurrentDataResponse.marketData!.priceChangePercentage60D;
      }
      if (coinsCurrentDataResponse
                  .marketData!.priceChangePercentage7DInCurrency![
              currencyIso4217Code.toLowerCase()] !=
          null) {
        priceChangePercentage7d = coinsCurrentDataResponse
                .marketData!.priceChangePercentage7DInCurrency![
            currencyIso4217Code.toLowerCase()];
      } else {
        priceChangePercentage7d =
            coinsCurrentDataResponse.marketData!.priceChangePercentage7D;
      }
      priceChangePercentage1h = 0;
      final CoinsPriceResponse coinsPriceResponse;
      if (nbHours > 0) {
        DateTime now = DateTime.now();
        int from =
            now.subtract(const Duration(hours: 1)).millisecondsSinceEpoch ~/
                Duration.millisecondsPerSecond;

        int to = now.millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
        coinsPriceResponse = await sl
            .get<ApiCoinsService>()
            .getCoinsChartRange(currencyIso4217Code, from, to);

        priceChangePercentage1h = ((coinsPriceResponse.prices!.last[1] /
                    coinsPriceResponse.prices!.first[1]) -
                1) *
            100;
      } else {
        coinsPriceResponse = await sl
            .get<ApiCoinsService>()
            .getCoinsChart(currencyIso4217Code, nbDays);
      }

      final List<AssetHistoryInterval> assetHistoryIntervalList =
          List<AssetHistoryInterval>.empty(growable: true);
      for (int i = 0; i < coinsPriceResponse.prices!.length; i = i + 1) {
        AssetHistoryInterval assetHistoryInterval = AssetHistoryInterval(
            price: coinsPriceResponse.prices![i][1],
            time: DateTime.fromMillisecondsSinceEpoch(
                coinsPriceResponse.prices![i][0].toInt()));
        assetHistoryIntervalList.add(assetHistoryInterval);
      }
      data = assetHistoryIntervalList;
    } catch (e) {}
  }
}
