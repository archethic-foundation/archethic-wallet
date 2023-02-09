import 'dart:io';

import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/domain/models/settings.dart';
import 'package:aewallet/domain/repositories/settings.dart';
import 'package:aewallet/infrastructure/repositories/settings.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class SettingsProviders {
  static final _repository = Provider<SettingsRepositoryInterface>(
    (ref) => SettingsRepository(),
  );

  static final settings = StateNotifierProvider<SettingsNotifier, Settings>(
    SettingsNotifier.new,
  );
}

class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier(this.ref) : super(Settings.empty());

  Ref ref;

  Future<void> initialize() async {
    final locale = ref.read(LanguageProviders.selectedLocale);
    state = await ref.read(SettingsProviders._repository).getSettings(locale);
  }

  Future<void> reset() => _update(
        state.copyWith(
          activeNotifications: !kIsWeb &&
              (Platform.isIOS == true ||
                  Platform.isAndroid == true ||
                  Platform.isLinux == true ||
                  Platform.isMacOS == true),
          activeVibrations: true,
          currency: AvailableCurrencyEnum.usd,
          language: AvailableLanguage.systemDefault,
          mainScreenCurrentPage: 2,
          primaryCurrency: const AvailablePrimaryCurrency(
            AvailablePrimaryCurrencyEnum.native,
          ),
          showBalances: true,
          showBlog: true,
          showPriceChart: true,
          theme: ThemeOptions.dark,
        ),
      );

  Future<void> _update(Settings settings) async {
    await ref.read(SettingsProviders._repository).setSettings(settings);
    state = settings;
  }

  Future<void> setShowBalances(bool showBalances) => _update(
        state.copyWith(showBalances: showBalances),
      );

  Future<void> setShowBlog(bool showBlog) => _update(
        state.copyWith(showBlog: showBlog),
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

  Future<void> selectTheme(ThemeOptions theme) => _update(
        state.copyWith(
          theme: theme,
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
