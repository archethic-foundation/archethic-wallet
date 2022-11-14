/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/infrastructure/datasources/hive_preferences.dart';
import 'package:aewallet/model/chart_infos.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/hive_app_wallet_dto.dart';
import 'package:aewallet/model/data/price.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/service_locator.dart';
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
  ChartInfos? chartInfos = ChartInfos();
  String? idChartOption = '1h';
  int bottomBarCurrentPage = 1;
  PageController? bottomBarPageController = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();

    // Setup Service Provide
    setupServiceLocator().then((_) {
      HivePreferencesDatasource.getInstance()
          .then((HivePreferencesDatasource preferences) {
        setState(
          () {
            updateCurrency().then((_) {
              final index = preferences.getMainScreenCurrentPage();
              bottomBarPageController = PageController(
                initialPage: index,
              );
              bottomBarCurrentPage = index;
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

  // Change currency
  Future<void> updateCurrency() async {
    final appWallet = ref.read(SessionProviders.session).loggedIn?.wallet;

    if (appWallet == null) return;
    final currency = ref.read(SettingsProviders.settings).currency;

    final tokenPrice = await Price.getCurrency(currency.name);

    (await ref.read(AccountProviders.selectedAccount.future))!
        .balance!
        .tokenPrice = tokenPrice;
    sl.get<DBHelper>().saveAppWallet(HiveAppWalletDTO.fromModel(appWallet));
    await chartInfos!.updateCoinsChart(
      currency.name,
      option: idChartOption!,
    );
  }

  Future<void> requestUpdate({
    bool forceUpdateChart = true,
  }) async {
    final selectedCurrency = ref.read(SettingsProviders.settings).currency;

    final preferences = ref.read(SettingsProviders.settings);
    if (forceUpdateChart && preferences.showPriceChart) {
      await chartInfos!.updateCoinsChart(
        selectedCurrency.name,
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
