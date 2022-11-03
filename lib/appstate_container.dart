/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/model/chart_infos.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/data/price.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:aewallet/util/service_locator.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _InheritedStateContainer extends InheritedWidget {
  const _InheritedStateContainer({
    required this.data,
    required super.child,
  });

  final StateContainerState data;

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

class StateContainer extends ConsumerStatefulWidget {
  const StateContainer({super.key, required this.child});

  final Widget child;

  static StateContainerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()!
        .data;
  }

  @override
  ConsumerState<StateContainer> createState() => StateContainerState();
}

class StateContainerState extends ConsumerState<StateContainer> {
  Price? price;
  bool recentTransactionsLoading = false;
  late NetworksSetting curNetwork;

  ChartInfos? chartInfos = ChartInfos();
  String? idChartOption = '1h';
  int bottomBarCurrentPage = 1;
  PageController? bottomBarPageController = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();

    // Setup Service Provide
    setupServiceLocator().then((_) {
      Preferences.getInstance().then((Preferences preferences) {
        setState(
          () {
            updateCurrency().then((_) {
              final index = preferences.getMainScreenCurrentPage();
              bottomBarPageController = PageController(
                initialPage: index,
              );
              bottomBarCurrentPage = index;
              curNetwork = preferences.getNetwork();
            });
          },
        );
      });
    });
  }

  @override
  void dispose() {
    bottomBarPageController!.dispose();
    super.dispose();
  }

  Future<List<Contact>> getContacts() async {
    return sl.get<DBHelper>().getContacts();
  }

  Future<List<Token>> getTokenFungibles() async {
    final tokensFungibles = <Token>[];
    final transactions = await sl
        .get<ApiService>()
        .networkTransactions('token', 1, request: 'address, data { content }');

    for (final transaction in transactions) {
      final token = tokenFromJson(transaction.data!.content!);
      tokensFungibles.add(
        Token(
          address: transaction.address,
          name: token.name,
          supply: token.supply,
          type: 'fungible',
          symbol: token.symbol,
        ),
      );
    }
    return tokensFungibles;
  }

  // Change currency
  Future<void> updateCurrency() async {
    final appWallet = ref.read(SessionProviders.session).loggedIn?.wallet;

    if (appWallet == null) return;
    final currency = ref.read(CurrencyProviders.selectedCurrency);

    final tokenPrice = await Price.getCurrency(currency.currency.name);

    ref.read(AccountProviders.selectedAccount)!.balance!.tokenPrice =
        tokenPrice;
    appWallet.save();
    setState(() {
      price = tokenPrice;
    });
    await chartInfos!.updateCoinsChart(
      currency.currency.name,
      option: idChartOption!,
    );
  }

  // Change theme
  Future<void> updateTheme(ThemeSetting theme) async {
    final currency = ref.read(CurrencyProviders.selectedCurrency);
    final preferences = ref.watch(SettingsProviders.settings);

    if (preferences.showPriceChart && chartInfos != null) {
      await chartInfos!
          .updateCoinsChart(currency.currency.name, option: idChartOption!);
    }
  }

  Future<void> requestUpdate({
    bool forceUpdateChart = true,
  }) async {
    final selectedAccount = ref.read(AccountProviders.selectedAccount);
    if (selectedAccount == null) return;

    setState(() {
      recentTransactionsLoading = true;
    });

    final selectedCurrency = ref.read(CurrencyProviders.selectedCurrency);

    // TODO(Chralu): SessionProviders.recentTransaction should automatically refresh.
    setState(() {
      recentTransactionsLoading = false;
    });

    final preferences = ref.read(SettingsProviders.settings);
    if (forceUpdateChart && preferences.showPriceChart) {
      await chartInfos!.updateCoinsChart(
        selectedCurrency.currency.name,
        option: idChartOption!,
      );
    }
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
