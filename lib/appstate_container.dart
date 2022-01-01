// ignore_for_file: cancel_subscriptions

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:event_taxi/event_taxi.dart';
import 'package:fl_chart/fl_chart.dart';

// Project imports:
import 'package:archethic_mobile_wallet/bus/events.dart';
import 'package:archethic_mobile_wallet/model/available_currency.dart';
import 'package:archethic_mobile_wallet/model/available_language.dart';
import 'package:archethic_mobile_wallet/model/available_themes.dart';
import 'package:archethic_mobile_wallet/model/chart_infos.dart';
import 'package:archethic_mobile_wallet/model/data/appdb.dart';
import 'package:archethic_mobile_wallet/model/data/hiveDB.dart';
import 'package:archethic_mobile_wallet/model/recent_transaction.dart';
import 'package:archethic_mobile_wallet/model/vault.dart';
import 'package:archethic_mobile_wallet/model/wallet.dart';
import 'package:archethic_mobile_wallet/service/app_service.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/ui/themes/theme_uniris.dart';
import 'package:archethic_mobile_wallet/ui/themes/themes.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/encrypt/crypter.dart';
import 'package:archethic_mobile_wallet/util/sharedprefsutil.dart';
import 'util/sharedprefsutil.dart';

import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show
        uint8ListToHex,
        AddressService,
        ApiCoinsService,
        Balance,
        SimplePriceResponse,
        CoinsPriceResponse,
        CoinsCurrentDataResponse,
        NftBalance;

class _InheritedStateContainer extends InheritedWidget {
  const _InheritedStateContainer({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final StateContainerState data;

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

class StateContainer extends StatefulWidget {
  const StateContainer({required this.child});

  final Widget child;

  static StateContainerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()!
        .data;
  }

  @override
  StateContainerState createState() => StateContainerState();
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
  BaseTheme curTheme = UnirisTheme();

  // Currently selected account
  Account selectedAccount = Account(
      name: 'AB', index: 0, lastAccess: 0, selected: true, genesisAddress: '0');
  // Two most recently used accounts
  Account? recentLast;
  Account? recentSecondLast;

  // When wallet is encrypted
  String? encryptedSecret;

  ChartInfos? chartInfos;

  List<Contact> contactsRef = List<Contact>.empty(growable: true);

  @override
  void initState() {
    super.initState();

    // Setup Service Provide
    setupServiceLocator();

    // Register RxBus
    _registerBus();

    wallet = AppWallet();
    localWallet = AppWallet();
    sl.get<DBHelper>().getSelectedAccount().then((Account? account) {
      localWallet!.accountBalance = Balance(
          nft: List<NftBalance>.empty(growable: true),
          uco:
              account!.balance == null ? 0 : double.tryParse(account.balance!));
      localWallet!.address = account.lastAddress!;
    });

    updateContacts();

    // Set currency locale here for the UI to access
    sl
        .get<SharedPrefsUtil>()
        .getCurrency(deviceLocale)
        .then((AvailableCurrency currency) {
      setState(() {
        currencyLocale = currency.getLocale().toString();
        curCurrency = currency;
      });
    });
    // Get default language setting
    sl.get<SharedPrefsUtil>().getLanguage().then((LanguageSetting language) {
      setState(() {
        curLanguage = language;
      });
    });
    // Get theme default
    sl.get<SharedPrefsUtil>().getTheme().then((theme) {
      updateTheme(theme);
    });
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
      sl
          .get<SharedPrefsUtil>()
          .getCurrency(deviceLocale)
          .then((AvailableCurrency currency) {
        setState(() {
          currencyLocale = currency.getLocale().toString();
          curCurrency = currency;
        });
      });
      setState(() {
        if (wallet != null) {
          wallet!.accountBalance = event.response!;
          sl.get<DBHelper>().updateAccountBalance(
              selectedAccount, wallet!.accountBalance.uco.toString());
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
        wallet!.btcPrice =
            event.response == null || event.response!.btcPrice == null
                ? '0'
                : event.response!.btcPrice.toString();
        localWallet!.btcPrice =
            event.response == null || event.response!.btcPrice == null
                ? '0'
                : event.response!.btcPrice.toString();
        wallet!.localCurrencyPrice =
            event.response == null || event.response!.localCurrencyPrice == null
                ? '0'
                : event.response!.localCurrencyPrice.toString();
        localWallet!.localCurrencyPrice =
            event.response == null || event.response!.localCurrencyPrice == null
                ? '0'
                : event.response!.localCurrencyPrice.toString();
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
    final SimplePriceResponse simplePriceResponse = await sl
        .get<ApiCoinsService>()
        .getSimplePrice(currency.getIso4217Code());
    EventTaxiImpl.singleton().fire(PriceEvent(response: simplePriceResponse));
    setState(() {
      curCurrency = currency;
    });
  }

  // Set encrypted secret
  void setEncryptedSecret(String secret) {
    setState(() {
      encryptedSecret = secret;
    });
  }

  // Reset encrypted secret
  void resetEncryptedSecret() {
    setState(() {
      encryptedSecret = null;
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
    EventTaxiImpl.singleton().fire(BalanceGetEvent(response: balance));
  }

  Future<void> requestUpdatePrice() async {
    final SimplePriceResponse simplePriceResponse = await sl
        .get<ApiCoinsService>()
        .getSimplePrice(curCurrency.getIso4217Code());
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

  Future<void> requestUpdateCoinsChart() async {
    final CoinsPriceResponse coinsPriceResponse = await sl
        .get<ApiCoinsService>()
        .getCoinsChart(curCurrency.getIso4217Code(), 1);
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
  }

  Future<void> requestUpdateLastAddress(Account account) async {
    final String seed = await getSeed();
    final String genesisAddress =
        sl.get<AddressService>().deriveAddress(seed, 0);

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
      localWallet!.accountBalance = Balance(
          nft: List<NftBalance>.empty(growable: true),
          uco: double.tryParse(account!.balance!));
      localWallet!.address = account.lastAddress!;
    });
  }

  void logOut() {
    setState(() {
      wallet = AppWallet();
      encryptedSecret = null;
    });
    sl.get<DBHelper>().dropAccounts();
  }

  Future<String> getSeed() async {
    String seed;
    if (encryptedSecret != null) {
      seed = uint8ListToHex(AppCrypt.decrypt(
          encryptedSecret, await sl.get<Vault>().getSessionKey()));
    } else {
      seed = (await sl.get<Vault>().getSeed())!;
    }
    return seed;
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
