/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

// Project imports:
import 'package:aewallet/main.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/model/chart_infos.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/app_wallet.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/data/price.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/ui/themes/theme_dark.dart';
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/notifications_util.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:aewallet/util/service_locator.dart';
import 'package:aewallet/util/vault.dart';

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
      PrimaryCurrencySetting(AvailablePrimaryCurrency.native);
  NetworksSetting curNetwork =
      NetworksSetting(AvailableNetworks.archethicMainNet);
  BaseTheme curTheme = DarkTheme();

  ChartInfos? chartInfos = ChartInfos();
  String? idChartOption = '1h';
  int bottomBarCurrentPage = 1;
  PageController? bottomBarPageController = PageController(initialPage: 1);

  bool showBalance = false;
  bool showPriceChart = false;
  bool showBlog = false;
  bool activeVibrations = false;
  bool activeNotifications = false;

  @override
  void initState() {
    super.initState();

    // Setup Service Provide
    setupServiceLocator().then((_) {
      Preferences.getInstance().then((Preferences preferences) {
        setState(() {
          curCurrency = preferences.getCurrency(deviceLocale);
          updateCurrency(curCurrency).then((_) {
            bottomBarPageController = PageController(
                initialPage: preferences.getMainScreenCurrentPage());
            curLanguage = preferences.getLanguage();
            curPrimaryCurrency = preferences.getPrimaryCurrency();
            curNetwork = preferences.getNetwork();
            showBalance = preferences.getShowBalances();
            showBlog = preferences.getShowBlog();
            activeVibrations = preferences.getActiveVibrations();
            activeNotifications = preferences.getActiveNotifications();
            showPriceChart = preferences.getShowPriceChart();
            updateTheme(preferences.getTheme());
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
    bottomBarPageController!.dispose();
    super.dispose();
  }

  void checkTransactionInputs(String message) {
    if (!kIsWeb &&
        (Platform.isIOS == true ||
            Platform.isAndroid == true ||
            Platform.isMacOS == true)) {
      if (appWallet != null) {
        timerCheckTransactionInputs =
            Timer.periodic(const Duration(seconds: 30), (Timer t) async {
          List<Account>? accounts = appWallet!.appKeychain!.accounts;
          accounts!.forEach((Account account) async {
            final List<TransactionInput> transactionInputList = await sl
                .get<AppService>()
                .getTransactionInputs(account.lastAddress!,
                    'from, amount, timestamp, tokenAddress ');

            if (transactionInputList.length > 0) {
              transactionInputList
                  .forEach((TransactionInput transactionInput) async {
                if (account.lastLoadingTransactionInputs == null ||
                    transactionInput.timestamp! >
                        account.lastLoadingTransactionInputs!) {
                  account.updateLastLoadingTransactionInputs();
                  if (transactionInput.from != account.lastAddress) {
                    String symbol = 'UCO';
                    if (transactionInput.tokenAddress != null) {
                      symbol = (await sl
                              .get<ApiService>()
                              .getToken(transactionInput.tokenAddress!))
                          .symbol!;
                    }
                    NotificationsUtil.showNotification(
                        title: 'Archethic',
                        body: message
                            .replaceAll('%1',
                                fromBigInt(transactionInput.amount).toString())
                            .replaceAll('%2', symbol)
                            .replaceAll('%3', account.name!),
                        payload: account.name!);
                    await requestUpdate(forceUpdateChart: false);
                  }
                }
              });
            }
          });
        });
      }
    }
  }

  Future<List<Contact>> getContacts() async {
    return await sl.get<DBHelper>().getContacts();
  }

  Future<List<Token>> getTokenFungibles() async {
    List<Token> tokensFungibles = <Token>[];
    List<Transaction> transactions = await sl
        .get<ApiService>()
        .networkTransactions('token', 1, request: 'address, data { content }');

    for (var transaction in transactions) {
      Token token = tokenFromJson(transaction.data!.content!);
      tokensFungibles.add(Token(
          address: transaction.address,
          name: token.name,
          supply: token.supply,
          type: 'fungible',
          symbol: token.symbol));
    }
    return tokensFungibles;
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
      await chartInfos!
          .updateCoinsChart(curCurrency.currency.name, option: idChartOption!);
    }
  }

  // Change theme
  Future<void> updateTheme(ThemeSetting theme) async {
    if (showPriceChart && chartInfos != null) {
      await chartInfos!
          .updateCoinsChart(curCurrency.currency.name, option: idChartOption!);
    }
    if (mounted) {
      setState(() {
        curTheme = theme.getTheme();
      });
    }
  }

  void updateState() {
    setState(() {});
  }

  Future<void> requestUpdate(
      {String? pagingAddress = '', bool forceUpdateChart = true}) async {
    await appWallet!.appKeychain!.getAccountSelected()!.updateLastAddress();

    await appWallet!.appKeychain!.getAccountSelected()!.updateFungiblesTokens();

    await appWallet!.appKeychain!.getAccountSelected()!.updateNFT();

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
      await chartInfos!
          .updateCoinsChart(curCurrency.currency.name, option: idChartOption!);
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
