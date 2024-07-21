import 'dart:ui';

import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/domain/models/settings.dart';
import 'package:aewallet/domain/repositories/settings.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/universal_platform.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class SettingsProviders {
  static final settings = StateNotifierProvider<SettingsNotifier, Settings>(
    SettingsNotifier.new,
  );
}

class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier(this.ref) : super(Settings.empty());

  Ref ref;

  Future<void> initialize(Locale locale) async {
    state = await sl.get<SettingsRepositoryInterface>().getSettings(locale);
  }

  Future<void> reset() => _update(
        state.copyWith(
          activeNotifications: UniversalPlatform.isIOS ||
              UniversalPlatform.isAndroid ||
              UniversalPlatform.isLinux ||
              UniversalPlatform.isMacOS,
          activeVibrations: true,
          activeRPCServer: true,
          currency: AvailableCurrencyEnum.usd,
          language: AvailableLanguage.english,
          mainScreenCurrentPage: 2,
          primaryCurrency: const AvailablePrimaryCurrency(
            AvailablePrimaryCurrencyEnum.native,
          ),
          showBalances: true,
          showPriceChart: true,
        ),
      );

  Future<void> _update(Settings settings) async {
    await sl.get<SettingsRepositoryInterface>().setSettings(settings);
    state = settings;
  }

  Future<void> setShowBalances(bool showBalances) => _update(
        state.copyWith(showBalances: showBalances),
      );

  Future<void> setShowPriceChart(bool showPriceChart) => _update(
        state.copyWith(showPriceChart: showPriceChart),
      );

  Future<void> setActiveNotifications(bool activeNotifications) => _update(
        state.copyWith(activeNotifications: activeNotifications),
      );

  Future<void> setActiveVibrations(bool activeVibrations) => _update(
        state.copyWith(activeVibrations: activeVibrations),
      );

  Future<void> setActiveRPCServer(bool activeRPCServer) => _update(
        state.copyWith(activeRPCServer: activeRPCServer),
      );

  Future<void> setNetwork(NetworksSetting selectedNetworkSettings) => _update(
        state.copyWith(network: selectedNetworkSettings),
      );

  Future<void> setNetworkDevEndpoint(String networkDevEndpoint) => _update(
        state.copyWith(
          network: NetworksSetting(
            network: state.network.network,
            networkDevEndpoint: networkDevEndpoint,
          ),
        ),
      );

  Future<void> selectCurrency(AvailableCurrency currency) => _update(
        state.copyWith(
          currency: currency.currency,
        ),
      );

  Future<void> selectPrimaryCurrency(
    AvailablePrimaryCurrency primaryCurrency,
  ) =>
      _update(
        state.copyWith(
          primaryCurrency: primaryCurrency,
        ),
      );

  Future<void> switchSelectedPrimaryCurrency() => selectPrimaryCurrency(
        AvailablePrimaryCurrency(
          state.primaryCurrency.primaryCurrency ==
                  AvailablePrimaryCurrencyEnum.native
              ? AvailablePrimaryCurrencyEnum.fiat
              : AvailablePrimaryCurrencyEnum.native,
        ),
      );

  Future<void> selectLanguage(AvailableLanguage language) => _update(
        state.copyWith(
          language: language,
        ),
      );

  Future<void> resetMainScreenCurrentPage() => _update(
        state.copyWith(
          mainScreenCurrentPage: 2,
        ),
      );

  Future<void> setMainScreenCurrentPage(int index) => _update(
        state.copyWith(
          mainScreenCurrentPage: index,
        ),
      );

  Future<void> setLanguageSeed(String languageSeed) => _update(
        state.copyWith(
          languageSeed: languageSeed,
        ),
      );

  Future<void> setPriceChartInterval(
    MarketPriceHistoryInterval chartIntervalOption,
  ) =>
      _update(
        state.copyWith(
          priceChartIntervalOption: chartIntervalOption,
        ),
      );
}
