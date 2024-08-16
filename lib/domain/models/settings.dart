import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    required AvailablePrimaryCurrency primaryCurrency,
    required AvailableLanguage language,
    required NetworksSetting network,
    required String languageSeed,
    required bool firstLaunch,
    required bool showBalances,
    required bool activeVibrations,
    required bool activeRPCServer,
    required int mainScreenCurrentPage,
    required bool showPriceChart,
    required MarketPriceHistoryInterval priceChartIntervalOption,
  }) = _Settings;

  factory Settings.empty() => const Settings(
        activeVibrations: true,
        activeRPCServer: true,
        firstLaunch: true,
        language: AvailableLanguage.english,
        languageSeed: '',
        mainScreenCurrentPage: 2,
        network: NetworksSetting(
          network: AvailableNetworks.archethicMainNet,
          networkDevEndpoint: '',
        ),
        primaryCurrency:
            AvailablePrimaryCurrency(AvailablePrimaryCurrencyEnum.native),
        showBalances: true,
        showPriceChart: true,
        priceChartIntervalOption: MarketPriceHistoryInterval.hour,
      );

  const Settings._();
}
