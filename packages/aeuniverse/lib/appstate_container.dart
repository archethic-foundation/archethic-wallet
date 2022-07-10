/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:aeroot/main.dart';
import 'package:aeuniverse/ui/widgets/components/notification_icon_widget.dart';
import 'package:core/model/data/account.dart';
import 'package:core/model/data/app_wallet.dart';
import 'package:core/model/data/contact.dart';
import 'package:core/model/data/price.dart';
import 'package:core/model/primary_currency.dart';
import 'package:core/util/notifications_util.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/model/ae_apps.dart';
import 'package:core/model/available_currency.dart';
import 'package:core/model/available_language.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/service/app_service.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/vault.dart';
import 'package:core_ui/model/chart_infos.dart';
import 'package:core_ui/ui/themes/themes.dart';
import 'package:core_ui/util/screen_util.dart';

// Project imports:
import 'package:aeuniverse/model/available_networks.dart';
import 'package:aeuniverse/model/available_themes.dart';
import 'package:aeuniverse/ui/themes/theme_dark.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:aeuniverse/util/service_locator.dart';

import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show TransactionInput;

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
  AppWallet? appWallet;
  Price? price;
  Timer? timerCheckTransactionInputs;
  bool recentTransactionsLoading = false;
  bool balanceLoading = false;
  Locale deviceLocale = const Locale('en', 'US');
  AvailableCurrency curCurrency = AvailableCurrency(AvailableCurrencyEnum.USD);
  LanguageSetting curLanguage = LanguageSetting(AvailableLanguage.DEFAULT);
  PrimaryCurrencySetting curPrimaryCurrency =
      PrimaryCurrencySetting(AvailablePrimaryCurrency.NATIVE);
  NetworksSetting curNetwork =
      NetworksSetting(AvailableNetworks.ArchethicTestNet);
  BaseTheme curTheme = DarkTheme();

  AEApps currentAEApp = AEApps.bin;

  ChartInfos? chartInfos = ChartInfos();
  String? idChartOption = '24h';

  bool showBalance = false;
  bool showPriceChart = false;
  bool showBlog = false;
  bool activeVibrations = false;
  bool activeNotifications = false;

  NotificationIconWidget notificationIconWidget = NotificationIconWidget();

  @override
  void initState() {
    super.initState();

    if (ScreenUtil.isDesktopMode()) {
      currentAEApp = AEApps.bin;
    } else {
      currentAEApp = AEApps.aewallet;
    }

    // Setup Service Provide
    setupServiceLocator().then((_) {
      Preferences.getInstance().then((Preferences _preferences) {
        setState(() {
          curCurrency = _preferences.getCurrency(deviceLocale);
          updateCurrency(curCurrency).then((_) {
            curLanguage = _preferences.getLanguage();
            curPrimaryCurrency = _preferences.getPrimaryCurrency();
            curNetwork = _preferences.getNetwork();
            showBalance = _preferences.getShowBalances();
            showBlog = _preferences.getShowBlog();
            activeVibrations = _preferences.getActiveVibrations();
            activeNotifications = _preferences.getActiveNotifications();
            showPriceChart = _preferences.getShowPriceChart();
            updateTheme(_preferences.getTheme());
          });
        });
      });
    });
  }

  @override
  void dispose() {
    if (timerCheckTransactionInputs != null) {
      timerCheckTransactionInputs!.cancel();
    }
    super.dispose();
  }

  void checkTransactionInputs(String message) {
    if (appWallet != null) {
      timerCheckTransactionInputs =
          Timer.periodic(Duration(seconds: 30), (Timer t) async {
        List<Account>? accounts = appWallet!.appKeychain!.accounts;
        accounts!.forEach((Account account) async {
          final List<TransactionInput> transactionInputList = await sl
              .get<AppService>()
              .getTransactionInputs(
                  account.lastAddress!, 'from, amount, timestamp');

          if (transactionInputList.length > 0) {
            transactionInputList.forEach((TransactionInput transactionInput) {
              if (account.lastLoadingTransactionInputs == null ||
                  transactionInput.timestamp! >
                      account.lastLoadingTransactionInputs!) {
                account.updateLastLoadingTransactionInputs();
                if (transactionInput.from != account.lastAddress) {
                  NotificationsUtil.showNotification(
                      title: 'Archethic',
                      body: message
                          .replaceAll('%1', transactionInput.amount.toString())
                          .replaceAll('%2', 'UCO')
                          .replaceAll('%3', account.name!),
                      payload: account.name!);
                }
              }
            });
          }
        });
      });
    }
  }

  Future<List<Contact>> getContacts() async {
    return await sl.get<DBHelper>().getContacts();
  }

  // Change language
  void updateLanguage(LanguageSetting language) {
    setState(() {
      curLanguage = language;
    });
  }

  // Change primary currency
  void updatePrimaryCurrency(PrimaryCurrencySetting primaryCurrency) {
    setState(() {
      curPrimaryCurrency = primaryCurrency;
    });
  }

  // Change currency
  Future<void> updateCurrency(AvailableCurrency currency) async {
    if (appWallet != null) {
      Price tokenPrice = await Price.getCurrency(curCurrency.currency.name);
      appWallet!.appKeychain!.getAccountSelected()!.balance!.tokenPrice =
          tokenPrice;
      appWallet!.save();
      setState(() {
        price = tokenPrice;
        curCurrency = currency;
      });
      await chartInfos!.updateCoinsChart(curCurrency.currency.name);
    }
  }

  // Change theme
  Future<void> updateTheme(ThemeSetting theme) async {
    if (showPriceChart && chartInfos != null) {
      await chartInfos!.updateCoinsChart(curCurrency.currency.name);
    }
    setState(() {
      curTheme = theme.getTheme();
    });
  }

  Future<void> requestUpdate(
      {String? pagingAddress = '', bool forceUpdateChart = true}) async {
    await appWallet!.appKeychain!.getAccountSelected()!.updateLastAddress();

    setState(() {
      balanceLoading = true;
      recentTransactionsLoading = true;
    });

    Price tokenPrice = await Price.getCurrency(curCurrency.currency.name);
    await appWallet!.appKeychain!.getAccountSelected()!.updateBalance(
        curNetwork.getNetworkCryptoCurrencyLabel(),
        curCurrency.currency.name,
        tokenPrice);

    setState(() {
      balanceLoading = false;
    });

    String? seed = await getSeed();
    await appWallet!.appKeychain!
        .getAccountSelected()!
        .updateRecentTransactions(pagingAddress!, seed!);

    setState(() {
      recentTransactionsLoading = false;
    });

    if (forceUpdateChart && showPriceChart) {
      await chartInfos!.updateCoinsChart(curCurrency.currency.name);
    }
  }

  Future<void> logOut() async {
    if (timerCheckTransactionInputs != null) {
      timerCheckTransactionInputs!.cancel();
    }
    (await Vault.getInstance()).clearAll();
    (await Preferences.getInstance()).clearAll();
    sl.get<DBHelper>().clearAll();
    RestartWidget.restartApp(context);
  }

  Future<String?> getSeed() async {
    final Vault vault = await Vault.getInstance();
    String? seed = vault.getSeed();
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
