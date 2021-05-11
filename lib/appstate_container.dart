// @dart=2.9

import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:hex/hex.dart';
import 'package:logger/logger.dart';
import 'package:uniris_lib_dart/model/response/coins_current_data_response.dart';
import 'package:uniris_lib_dart/model/response/coins_price_response.dart';
import 'package:uniris_lib_dart/model/response/simple_price_response.dart';
import 'package:uniris_lib_dart/services/api_coins_service.dart';
import 'package:uniris_mobile_wallet/model/balance.dart';
import 'package:uniris_mobile_wallet/model/chart_infos.dart';
import 'package:uniris_mobile_wallet/model/wallet.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uniris_mobile_wallet/network/model/response/address_txs_response.dart';
import 'package:uniris_mobile_wallet/service/app_service.dart';
import 'package:uniris_mobile_wallet/util/app_ffi/encrypt/crypter.dart';
import 'package:uniris_mobile_wallet/themes.dart';
import 'package:uniris_mobile_wallet/service_locator.dart';
import 'package:uniris_mobile_wallet/model/available_currency.dart';
import 'package:uniris_mobile_wallet/model/available_language.dart';
import 'package:uniris_mobile_wallet/model/address.dart';
import 'package:uniris_mobile_wallet/model/vault.dart';
import 'package:uniris_mobile_wallet/model/db/appdb.dart';
import 'package:uniris_mobile_wallet/model/db/account.dart';
import 'package:uniris_mobile_wallet/util/sharedprefsutil.dart';
import 'package:uniris_mobile_wallet/util/app_ffi/apputil.dart';
import 'package:uniris_mobile_wallet/bus/events.dart';

import 'util/sharedprefsutil.dart';

class _InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

class StateContainer extends StatefulWidget {
  final Widget child;

  StateContainer({@required this.child});

  static StateContainerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()
        .data;
  }

  @override
  StateContainerState createState() => StateContainerState();
}

class StateContainerState extends State<StateContainer> {
  final Logger log = sl.get<Logger>();

  // Minimum receive = 0.000001
  String receiveThreshold = BigInt.from(10).pow(24).toString();

  AppWallet wallet;
  String currencyLocale;
  Locale deviceLocale = Locale('en', 'US');
  AvailableCurrency curCurrency = AvailableCurrency(AvailableCurrencyEnum.USD);
  LanguageSetting curLanguage = LanguageSetting(AvailableLanguage.DEFAULT);
  BaseTheme curTheme = UnirisTheme();
  // Currently selected account
  Account selectedAccount =
      Account(id: 1, name: "AB", index: 0, lastAccess: 0, selected: true);
  // Two most recently used accounts
  Account recentLast;
  Account recentSecondLast;

  // When wallet is encrypted
  String encryptedSecret;

  ChartInfos chartInfos;

  @override
  void initState() {
    super.initState();
    // Register RxBus
    _registerBus();
    // Set currency locale here for the UI to access
    sl.get<SharedPrefsUtil>().getCurrency(deviceLocale).then((currency) {
      setState(() {
        currencyLocale = currency.getLocale().toString();
        curCurrency = currency;
      });
    });
    // Get default language setting
    sl.get<SharedPrefsUtil>().getLanguage().then((language) {
      setState(() {
        curLanguage = language;
      });
    });
  }

  // Subscriptions
  StreamSubscription<BalanceGetEvent> _balanceGetEventSub;
  StreamSubscription<PriceEvent> _priceEventSub;
  StreamSubscription<ChartEvent> _chartEventSub;
  StreamSubscription<AccountModifiedEvent> _accountModifiedSub;
  StreamSubscription<TransactionsListEvent> _transactionsListEventSub;

  // Register RX event listeners
  void _registerBus() {
    _balanceGetEventSub =
        EventTaxiImpl.singleton().registerTo<BalanceGetEvent>().listen((event) {
      //print("listen BalanceGetEvent");
      handleAddressResponse(event.response);
    });

    _transactionsListEventSub = EventTaxiImpl.singleton()
        .registerTo<TransactionsListEvent>()
        .listen((event) {
      //print("listen TransactionsListEvent");
      AddressTxsResponse addressTxsResponse = new AddressTxsResponse();
      addressTxsResponse.result =
          new List<AddressTxsResponseResult>.empty(growable: true);
      for (int i = event.response.length - 1; i >= 0; i--) {
        AddressTxsResponseResult addressTxResponseResult =
            new AddressTxsResponseResult();
        addressTxResponseResult.populate(
            event.response[i], selectedAccount.address);
        addressTxsResponse.result.add(addressTxResponseResult);
      }

      wallet.history.clear();

      // Iterate list in reverse (oldest to newest block)
      if (addressTxsResponse != null && addressTxsResponse.result != null) {
        for (AddressTxsResponseResult item in addressTxsResponse.result) {
          setState(() {
            wallet.history.insert(0, item);
          });
        }
      }

      setState(() {
        wallet.historyLoading = false;
        wallet.loading = false;
      });

      EventTaxiImpl.singleton().fire(HistoryHomeEvent(items: wallet.history));
    });

    _priceEventSub =
        EventTaxiImpl.singleton().registerTo<PriceEvent>().listen((event) {
      setState(() {
        wallet.btcPrice = event.response.btcPrice.toString();
        wallet.localCurrencyPrice =
            event.response.localCurrencyPrice.toString();
      });
    });

    _chartEventSub =
        EventTaxiImpl.singleton().registerTo<ChartEvent>().listen((event) {
      setState(() {
        chartInfos = event.chartInfos;
      });
    });

    // Account has been deleted or name changed
    _accountModifiedSub = EventTaxiImpl.singleton()
        .registerTo<AccountModifiedEvent>()
        .listen((event) {
      if (!event.deleted) {
        if (event.account.index == selectedAccount.index) {
          setState(() {
            selectedAccount.name = event.account.name;
          });
        } else {
          updateRecentlyUsedAccounts();
        }
      } else {
        // Remove account
        updateRecentlyUsedAccounts().then((_) {
          if (event.account.index == selectedAccount.index &&
              recentLast != null) {
            sl.get<DBHelper>().changeAccount(recentLast);
            setState(() {
              selectedAccount = recentLast;
            });
            EventTaxiImpl.singleton()
                .fire(AccountChangedEvent(account: recentLast, noPop: true));
          } else if (event.account.index == selectedAccount.index &&
              recentSecondLast != null) {
            sl.get<DBHelper>().changeAccount(recentSecondLast);
            setState(() {
              selectedAccount = recentSecondLast;
            });
            EventTaxiImpl.singleton().fire(
                AccountChangedEvent(account: recentSecondLast, noPop: true));
          } else if (event.account.index == selectedAccount.index) {
            getSeed().then((seed) {
              sl.get<DBHelper>().getMainAccount(seed).then((mainAccount) {
                sl.get<DBHelper>().changeAccount(mainAccount);
                setState(() {
                  selectedAccount = mainAccount;
                });
                EventTaxiImpl.singleton().fire(
                    AccountChangedEvent(account: mainAccount, noPop: true));
              });
            });
          }
        });
        updateRecentlyUsedAccounts();
      }
    });
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  void _destroyBus() {
    if (_balanceGetEventSub != null) {
      _balanceGetEventSub.cancel();
    }
    if (_priceEventSub != null) {
      _priceEventSub.cancel();
    }
    if (_chartEventSub != null) {
      _chartEventSub.cancel();
    }
    if (_accountModifiedSub != null) {
      _accountModifiedSub.cancel();
    }
    if (_transactionsListEventSub != null) {
      _transactionsListEventSub.cancel();
    }
  }

  // Update the global wallet instance with a new address
  Future<void> updateWallet({Account account}) async {
    //print("updateWallet");
    String address;
    address = AppUtil().seedToAddress(await getSeed(), account.index);
    account.address = address;
    selectedAccount = account;
    updateRecentlyUsedAccounts();

    setState(() {
      wallet = AppWallet(address: address, loading: true);
      requestUpdate();
    });
  }

  Future<void> updateRecentlyUsedAccounts() async {
    List<Account> otherAccounts =
        await sl.get<DBHelper>().getRecentlyUsedAccounts(await getSeed());
    if (otherAccounts != null && otherAccounts.length > 0) {
      if (otherAccounts.length > 1) {
        setState(() {
          recentLast = otherAccounts[0];
          recentSecondLast = otherAccounts[1];
        });
      } else {
        setState(() {
          recentLast = otherAccounts[0];
          recentSecondLast = null;
        });
      }
    } else {
      setState(() {
        recentLast = null;
        recentSecondLast = null;
      });
    }
  }

  // Change language
  void updateLanguage(LanguageSetting language) {
    setState(() {
      curLanguage = language;
    });
  }

  // Change curency
  void updateCurrency(AvailableCurrency currency) async {
    SimplePriceResponse simplePriceResponse = await sl
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

  /// Handle address response
  void handleAddressResponse(Balance response) {
    // Set currency locale here for the UI to access
    sl.get<SharedPrefsUtil>().getCurrency(deviceLocale).then((currency) {
      setState(() {
        currencyLocale = currency.getLocale().toString();
        curCurrency = currency;
      });
    });
    setState(() {
      if (wallet != null) {
        if (response == null) {
          wallet.accountBalance =
              new Balance(nftList: null, uco: 0);
        } else {
          wallet.accountBalance = response;
          sl.get<DBHelper>().updateAccountBalance(
              selectedAccount, wallet.accountBalance.toString());
        }
      }
    });
  }

  Future<void> requestUpdate() async {
    //print("requestUpdate");
    if (wallet != null &&
        wallet.address != null &&
        Address(wallet.address).isValid()) {
      String endpoint = await sl.get<SharedPrefsUtil>().getEndpoint();
      try {
        sl
            .get<AppService>()
            .getBalanceGetResponse(selectedAccount.address, endpoint, true);

        SimplePriceResponse simplePriceResponse = await sl
            .get<ApiCoinsService>()
            .getSimplePrice(curCurrency.getIso4217Code());
        EventTaxiImpl.singleton()
            .fire(PriceEvent(response: simplePriceResponse));

        CoinsPriceResponse coinsPriceResponse = await sl
            .get<ApiCoinsService>()
            .getCoinsChart(curCurrency.getIso4217Code(), 1);
        chartInfos = new ChartInfos();
        chartInfos.minY = 9999999;
        chartInfos.maxY = 0;
        CoinsCurrentDataResponse coinsCurrentDataResponse = await sl
            .get<ApiCoinsService>().getCoinsCurrentData();
        if(coinsCurrentDataResponse.marketData.priceChangePercentage24HInCurrency[curCurrency.getIso4217Code().toLowerCase()] != null)
        {
          chartInfos.priceChangePercentage24h = coinsCurrentDataResponse.marketData.priceChangePercentage24HInCurrency[curCurrency.getIso4217Code().toLowerCase()];
        }
        else
        {
          chartInfos.priceChangePercentage24h = coinsCurrentDataResponse.marketData.priceChangePercentage24H;
        }
        List<FlSpot> data = new List<FlSpot>.empty(growable: true);
        for (int i = 0; i < coinsPriceResponse.prices.length; i = i + 1) {
          FlSpot chart = FlSpot(
              coinsPriceResponse.prices[i][0], double.tryParse(coinsPriceResponse.prices[i][1].toStringAsFixed(5)));
          data.add(chart);
          if (chartInfos.minY > coinsPriceResponse.prices[i][1]) {
            chartInfos.minY = coinsPriceResponse.prices[i][1];
          }

          if (chartInfos.maxY < coinsPriceResponse.prices[i][1]) {
            chartInfos.maxY = coinsPriceResponse.prices[i][1];
          }
        }
        chartInfos.data = data;
        chartInfos.minX = coinsPriceResponse.prices[0][0];
        chartInfos.maxX =
            coinsPriceResponse.prices[coinsPriceResponse.prices.length - 1][0];
        EventTaxiImpl.singleton().fire(ChartEvent(chartInfos: chartInfos));
      } catch (e) {}
    }
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
      seed = HEX.encode(AppCrypt.decrypt(
          encryptedSecret, await sl.get<Vault>().getSessionKey()));
    } else {
      seed = await sl.get<Vault>().getSeed();
    }
    return seed;
  }

  // Simple build method that just passes this state through
  // your InheritedWidget
  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}
