import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    required AvailableCurrencyEnum currency,
    required AvailablePrimaryCurrency primaryCurrency,
    required AvailableLanguage language,
    required NetworksSetting network,
    required String languageSeed,
    required bool firstLaunch,
    required bool showBalances,
    required bool showBlog,
    required bool activeVibrations,
    required bool activeRPCServer,
    required bool activeNotifications,
    required int mainScreenCurrentPage,
    required bool showPriceChart,
    required MarketPriceHistoryInterval priceChartIntervalOption,
    required ThemeOptions theme,
  }) = _Settings;

  factory Settings.empty() => const Settings(
        activeNotifications: true,
        activeVibrations: true,
        activeRPCServer: true,
        firstLaunch: true,
        currency: AvailableCurrencyEnum.usd,
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
        showBlog: true,
        showPriceChart: true,
        priceChartIntervalOption: MarketPriceHistoryInterval.hour,
        theme: ThemeOptions.dark,
      );

  const Settings._();
}
