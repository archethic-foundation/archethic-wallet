// ignore_for_file: cancel_subscriptions

/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/bus/balance_get_event.dart';
import 'package:core/bus/price_event.dart';
import 'package:core/bus/transactions_list_event.dart';
import 'package:core/model/ae_apps.dart';
import 'package:core/model/available_currency.dart';
import 'package:core/model/available_language.dart';
import 'package:core/model/available_networks.dart';
import 'package:core/model/balance_wallet.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/hive_db.dart';
import 'package:core/model/recent_transaction.dart';
import 'package:core/model/wallet.dart';
import 'package:core/service/app_service.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/vault.dart';
import 'package:core_ui/bus/chart_event.dart';
import 'package:core_ui/model/chart_infos.dart';
import 'package:core_ui/ui/themes/themes.dart';
import 'package:core_ui/util/app_util.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:fl_chart/fl_chart.dart';

// Project imports:
import 'package:aeuniverse/model/available_themes.dart';
import 'package:aeuniverse/ui/themes/theme_dark.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:aeuniverse/util/service_locator.dart';

import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show
        AddressService,
        ApiCoinsService,
        Balance,
        SimplePriceResponse,
        CoinsPriceResponse,
        CoinsCurrentDataResponse,
        OracleService,
        OracleUcoPrice,
        deriveAddress;

class _InheritedStateContainer extends InheritedWidget {
  const _InheritedStateContainer({
    required this.data,
    required super.child,
  });

  final StateContainerState data;

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

class StateContainer extends StatefulWidget {
  const StateContainer({super.key, required this.child});

  final Widget child;

  static StateContainerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()!
        .data;
  }

  @override
  State<StateContainer> createState() => StateContainerState();
}

class StateContainerState extends State<StateContainer> {
  // Minimum receive = 0.000001
  String receiveThreshold = BigInt.from(10).pow(24).toString();

  AppWallet? wallet;
  AppWallet? localWallet;
  bool recentTransactionsLoading = false;
  bool balanceLoading = false;
  String? currencyLocale;
  Locale deviceLocale = const Locale('en', 'US');
  AvailableCurrency curCurrency = AvailableCurrency(AvailableCurrencyEnum.USD);
  LanguageSetting curLanguage = LanguageSetting(AvailableLanguage.DEFAULT);
  NetworksSetting curNetwork = NetworksSetting(AvailableNetworks.AETestNet);
  BaseTheme curTheme = DarkTheme();

  AEApps currentAEApp = AEApps.bin;

  // Currently selected account
  Account selectedAccount = Account(
      name: 'AB', index: 0, lastAccess: 0, selected: true, genesisAddress: '0');
  // Two most recently used accounts
  Account? recentLast;
  Account? recentSecondLast;

  ChartInfos? chartInfos;
  String? idChartOption = '1d';

  bool useOracleUcoPrice = false;
  bool showBalance = false;

  List<Contact> contactsRef = List<Contact>.empty(growable: true);

  @override
  void initState() {
    super.initState();

    if (AppUtil.isDesktopMode()) {
      currentAEApp = AEApps.bin;
    } else {
      currentAEApp = AEApps.aewallet;
    }

    // Setup Service Provide
    setupServiceLocator();

    // Register RxBus
    _registerBus();

    Preferences.getInstance().then((Preferences _preferences) {
      setState(() {
        curCurrency = _preferences.getCurrency(deviceLocale);
        currencyLocale = curCurrency.getLocale().toString();
        curLanguage = _preferences.getLanguage();
        curNetwork = _preferences.getNetwork();
        showBalance = _preferences.getShowBalances();
      });
      updateTheme(_preferences.getTheme());
    });

    wallet = AppWallet();
    localWallet = AppWallet();
    sl.get<DBHelper>().getSelectedAccount().then((Account? account) {
      if (account != null) {
        localWallet!.accountBalance = BalanceWallet(
            account.balance == 0 ? 0 : double.tryParse(account.balance!),
            curCurrency);
        localWallet!.address =
            account.lastAddress == null ? '' : account.lastAddress!;
      } else {
        localWallet!.accountBalance = BalanceWallet(0.0, curCurrency);
        localWallet!.address = '';
      }
    });

    updateContacts();
  }

  // Subscriptions
  StreamSubscription<BalanceGetEvent>? _balanceGetEventSub;
  StreamSubscription<PriceEvent>? _priceEventSub;
  StreamSubscription<ChartEvent>? _chartEventSub;
  StreamSubscription<TransactionsListEvent>? _transactionsListEventSub;

  void _registerBus() {
    _balanceGetEventSub = EventTaxiImpl.singleton()
        .registerTo<BalanceGetEvent>()
        .listen((BalanceGetEvent event) {
      Preferences.getInstance().then((Preferences _preferences) {
        setState(() {
          curCurrency = _preferences.getCurrency(deviceLocale);
          currencyLocale = curCurrency.getLocale().toString();
        });
      });

      setState(() {
        if (wallet != null) {
          wallet!.accountBalance = event.response!;
          sl.get<DBHelper>().updateAccountBalance(selectedAccount,
              wallet!.accountBalance.networkCurrencyValue.toString());
        }
      });
    });

    _transactionsListEventSub = EventTaxiImpl.singleton()
        .registerTo<TransactionsListEvent>()
        .listen((TransactionsListEvent event) {
      wallet!.history.clear();

      // Iterate list in reverse (oldest to newest block)
      if (event.transaction != null) {
        for (RecentTransaction recentTransaction in event.transaction!) {
          setState(() {
            wallet!.history.add(recentTransaction);
          });
        }
        wallet!.history.reversed.toList();
      }
    });

    _priceEventSub = EventTaxiImpl.singleton()
        .registerTo<PriceEvent>()
        .listen((PriceEvent event) {
      setState(() {
        wallet!.accountBalance.localCurrencyPrice =
            event.response == null || event.response!.localCurrencyPrice == null
                ? 0
                : event.response!.localCurrencyPrice;
        localWallet!.accountBalance.localCurrencyPrice =
            event.response == null || event.response!.localCurrencyPrice == null
                ? 0
                : event.response!.localCurrencyPrice;
      });
    });

    _chartEventSub = EventTaxiImpl.singleton()
        .registerTo<ChartEvent>()
        .listen((ChartEvent event) {
      setState(() {
        chartInfos = event.chartInfos;
      });
    });
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  void _destroyBus() {
    if (_balanceGetEventSub != null) {
      _balanceGetEventSub!.cancel();
    }
    if (_priceEventSub != null) {
      _priceEventSub!.cancel();
    }
    if (_chartEventSub != null) {
      _chartEventSub!.cancel();
    }
    if (_transactionsListEventSub != null) {
      _transactionsListEventSub!.cancel();
    }
  }

  void updateContacts() {
    sl.get<DBHelper>().getContacts().then((List<Contact> contacts) {
      setState(() {
        contactsRef = contacts;
      });
    });
  }

  // Change language
  void updateLanguage(LanguageSetting language) {
    setState(() {
      curLanguage = language;
    });
  }

  // Change curency
  Future<void> updateCurrency(AvailableCurrency currency) async {
    SimplePriceResponse simplePriceResponse = SimplePriceResponse();
    useOracleUcoPrice = false;

    // if eur or usd, use Archethic Oracle
    if (currency.getIso4217Code() == 'EUR' ||
        currency.getIso4217Code() == 'USD') {
      try {
        final OracleUcoPrice oracleUcoPrice =
            await sl.get<OracleService>().getLastOracleUcoPrice();
        if (oracleUcoPrice.uco == null || oracleUcoPrice.uco!.eur == 0) {
          simplePriceResponse = await sl
              .get<ApiCoinsService>()
              .getSimplePrice(currency.getIso4217Code());
        } else {
          simplePriceResponse.currency = currency.getIso4217Code();
          if (currency.getIso4217Code() == 'EUR') {
            simplePriceResponse.localCurrencyPrice = oracleUcoPrice.uco!.eur;
            useOracleUcoPrice = true;
          } else {
            if (currency.getIso4217Code() == 'USD') {
              simplePriceResponse.localCurrencyPrice = oracleUcoPrice.uco!.usd;
              useOracleUcoPrice = true;
            } else {
              simplePriceResponse = await sl
                  .get<ApiCoinsService>()
                  .getSimplePrice(currency.getIso4217Code());
            }
          }
        }
      } catch (e) {
        simplePriceResponse = await sl
            .get<ApiCoinsService>()
            .getSimplePrice(currency.getIso4217Code());
      }
    } else {
      simplePriceResponse = await sl
          .get<ApiCoinsService>()
          .getSimplePrice(currency.getIso4217Code());
    }
    EventTaxiImpl.singleton().fire(PriceEvent(response: simplePriceResponse));
    requestUpdateCoinsChart(option: idChartOption!);
    setState(() {
      curCurrency = currency;
    });
  }

  // Change theme
  void updateTheme(ThemeSetting theme) {
    setState(() {
      curTheme = theme.getTheme();
    });
  }

  Future<void> requestUpdateBalance() async {
    final Balance balance = await sl
        .get<AppService>()
        .getBalanceGetResponse(selectedAccount.lastAddress!);
    final BalanceWallet balanceWallet = BalanceWallet(balance.uco, curCurrency);
    EventTaxiImpl.singleton().fire(BalanceGetEvent(response: balanceWallet));
  }

  Future<void> requestUpdatePrice() async {
    SimplePriceResponse simplePriceResponse = SimplePriceResponse();
    useOracleUcoPrice = false;
    // if eur or usd, use Archethic Oracle
    if (curCurrency.getIso4217Code() == 'EUR' ||
        curCurrency.getIso4217Code() == 'USD') {
      try {
        final OracleUcoPrice oracleUcoPrice =
            await sl.get<OracleService>().getLastOracleUcoPrice();
        if (oracleUcoPrice.uco == null || oracleUcoPrice.uco!.eur == 0) {
          simplePriceResponse = await sl
              .get<ApiCoinsService>()
              .getSimplePrice(curCurrency.getIso4217Code());
        } else {
          simplePriceResponse.currency = curCurrency.getIso4217Code();
          if (curCurrency.getIso4217Code() == 'EUR') {
            simplePriceResponse.localCurrencyPrice = oracleUcoPrice.uco!.eur;
            useOracleUcoPrice = true;
          } else {
            if (curCurrency.getIso4217Code() == 'USD') {
              simplePriceResponse.localCurrencyPrice = oracleUcoPrice.uco!.usd;
              useOracleUcoPrice = true;
            } else {
              simplePriceResponse = await sl
                  .get<ApiCoinsService>()
                  .getSimplePrice(curCurrency.getIso4217Code());
            }
          }
        }
      } catch (e) {
        simplePriceResponse = await sl
            .get<ApiCoinsService>()
            .getSimplePrice(curCurrency.getIso4217Code());
      }
    } else {
      simplePriceResponse = await sl
          .get<ApiCoinsService>()
          .getSimplePrice(curCurrency.getIso4217Code());
    }
    EventTaxiImpl.singleton().fire(PriceEvent(response: simplePriceResponse));
  }

  Future<void> requestUpdateRecentTransactions(int page) async {
    final List<RecentTransaction> recentTransactions = await sl
        .get<AppService>()
        .getRecentTransactions(selectedAccount.genesisAddress!,
            selectedAccount.lastAddress!, page);
    EventTaxiImpl.singleton()
        .fire(TransactionsListEvent(transaction: recentTransactions));
  }

  Future<void> requestUpdateCoinsChart({String option = '24h'}) async {
    int nbDays;
    idChartOption = option;
    switch (option) {
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
      case '24h':
      default:
        nbDays = 1;
        break;
    }
    try {
      final CoinsPriceResponse coinsPriceResponse = await sl
          .get<ApiCoinsService>()
          .getCoinsChart(curCurrency.getIso4217Code(), nbDays);
      chartInfos = ChartInfos();
      chartInfos!.minY = 9999999;
      chartInfos!.maxY = 0;
      final CoinsCurrentDataResponse coinsCurrentDataResponse =
          await sl.get<ApiCoinsService>().getCoinsCurrentData();
      if (coinsCurrentDataResponse
                  .marketData!.priceChangePercentage24HInCurrency![
              curCurrency.getIso4217Code().toLowerCase()] !=
          null) {
        chartInfos!.priceChangePercentage24h = coinsCurrentDataResponse
                .marketData!.priceChangePercentage24HInCurrency![
            curCurrency.getIso4217Code().toLowerCase()];
      } else {
        chartInfos!.priceChangePercentage24h =
            coinsCurrentDataResponse.marketData!.priceChangePercentage24H;
      }
      if (coinsCurrentDataResponse
                  .marketData!.priceChangePercentage14DInCurrency![
              curCurrency.getIso4217Code().toLowerCase()] !=
          null) {
        chartInfos!.priceChangePercentage14d = coinsCurrentDataResponse
                .marketData!.priceChangePercentage14DInCurrency![
            curCurrency.getIso4217Code().toLowerCase()];
      } else {
        chartInfos!.priceChangePercentage14d =
            coinsCurrentDataResponse.marketData!.priceChangePercentage14D;
      }
      if (coinsCurrentDataResponse
                  .marketData!.priceChangePercentage1YInCurrency![
              curCurrency.getIso4217Code().toLowerCase()] !=
          null) {
        chartInfos!.priceChangePercentage1y = coinsCurrentDataResponse
                .marketData!.priceChangePercentage1YInCurrency![
            curCurrency.getIso4217Code().toLowerCase()];
      } else {
        chartInfos!.priceChangePercentage1y =
            coinsCurrentDataResponse.marketData!.priceChangePercentage1Y;
      }
      if (coinsCurrentDataResponse
                  .marketData!.priceChangePercentage200DInCurrency![
              curCurrency.getIso4217Code().toLowerCase()] !=
          null) {
        chartInfos!.priceChangePercentage200d = coinsCurrentDataResponse
                .marketData!.priceChangePercentage200DInCurrency![
            curCurrency.getIso4217Code().toLowerCase()];
      } else {
        chartInfos!.priceChangePercentage200d =
            coinsCurrentDataResponse.marketData!.priceChangePercentage200D;
      }
      if (coinsCurrentDataResponse
                  .marketData!.priceChangePercentage30DInCurrency![
              curCurrency.getIso4217Code().toLowerCase()] !=
          null) {
        chartInfos!.priceChangePercentage30d = coinsCurrentDataResponse
                .marketData!.priceChangePercentage30DInCurrency![
            curCurrency.getIso4217Code().toLowerCase()];
      } else {
        chartInfos!.priceChangePercentage30d =
            coinsCurrentDataResponse.marketData!.priceChangePercentage30D;
      }
      if (coinsCurrentDataResponse
                  .marketData!.priceChangePercentage60DInCurrency![
              curCurrency.getIso4217Code().toLowerCase()] !=
          null) {
        chartInfos!.priceChangePercentage60d = coinsCurrentDataResponse
                .marketData!.priceChangePercentage60DInCurrency![
            curCurrency.getIso4217Code().toLowerCase()];
      } else {
        chartInfos!.priceChangePercentage60d =
            coinsCurrentDataResponse.marketData!.priceChangePercentage60D;
      }
      if (coinsCurrentDataResponse
                  .marketData!.priceChangePercentage7DInCurrency![
              curCurrency.getIso4217Code().toLowerCase()] !=
          null) {
        chartInfos!.priceChangePercentage7d = coinsCurrentDataResponse
                .marketData!.priceChangePercentage7DInCurrency![
            curCurrency.getIso4217Code().toLowerCase()];
      } else {
        chartInfos!.priceChangePercentage7d =
            coinsCurrentDataResponse.marketData!.priceChangePercentage7D;
      }
      final List<FlSpot> data = List<FlSpot>.empty(growable: true);
      for (int i = 0; i < coinsPriceResponse.prices!.length; i = i + 1) {
        final FlSpot chart = FlSpot(
            coinsPriceResponse.prices![i][0],
            double.tryParse(
                coinsPriceResponse.prices![i][1].toStringAsFixed(5))!);
        data.add(chart);
        if (chartInfos!.minY! > coinsPriceResponse.prices![i][1]) {
          chartInfos!.minY = coinsPriceResponse.prices![i][1];
        }

        if (chartInfos!.maxY! < coinsPriceResponse.prices![i][1]) {
          chartInfos!.maxY = coinsPriceResponse.prices![i][1];
        }
      }
      chartInfos!.data = data;
      chartInfos!.minX = coinsPriceResponse.prices![0][0];
      chartInfos!.maxX =
          coinsPriceResponse.prices![coinsPriceResponse.prices!.length - 1][0];
      EventTaxiImpl.singleton().fire(ChartEvent(chartInfos: chartInfos));
    } catch (e) {
      EventTaxiImpl.singleton().fire(ChartEvent(chartInfos: ChartInfos()));
    }
  }

  Future<void> requestUpdateLastAddress(Account account) async {
    final String seed = await getSeed();
    final String genesisAddress = deriveAddress(seed, 0);

    String lastAddress =
        await sl.get<AddressService>().lastAddressFromAddress(genesisAddress);
    if (lastAddress == '') {
      lastAddress = genesisAddress;
    }
    account.genesisAddress = genesisAddress;
    account.lastAddress = lastAddress;
    selectedAccount = account;

    setState(() {
      wallet = AppWallet(address: account.lastAddress);
    });
  }

  Future<void> requestUpdate({Account? account, int? page = 0}) async {
    await requestUpdateLastAddress(account!);
    setState(() {
      balanceLoading = true;
      recentTransactionsLoading = true;
    });
    await requestUpdateBalance();
    setState(() {
      balanceLoading = false;
    });
    await requestUpdatePrice();
    await requestUpdateRecentTransactions(page!);
    setState(() {
      recentTransactionsLoading = false;
    });
    await requestUpdateCoinsChart();

    sl.get<DBHelper>().getSelectedAccount().then((Account? account) {
      if (account != null) {
        localWallet!.accountBalance = BalanceWallet(
            double.tryParse(account.balance == null ? '0' : account.balance!),
            curCurrency);

        localWallet!.address =
            account.lastAddress == null ? '' : account.lastAddress!;
      } else {
        localWallet!.accountBalance = BalanceWallet(
            double.tryParse(account!.balance == null ? '0' : account.balance!),
            curCurrency);
        localWallet!.address = '';
      }
    });
  }

  void logOut() {
    setState(() {
      wallet = AppWallet();
    });
  }

  Future<String> getSeed() async {
    final Vault _vault = await Vault.getInstance();
    return _vault.getSeed()!;
  }

  /// Simple build method that just passes this state through
  /// your InheritedWidget
  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}
