/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/hive_app_wallet_dto.dart';
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
  @override
  void initState() {
    super.initState();

    // Setup Service Provide
    setupServiceLocator().then((_) {
      updateCurrency().then(
        (_) => setState(
          () {},
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Change currency
  Future<void> updateCurrency() async {
    final appWallet = ref.read(SessionProviders.session).loggedIn?.wallet;

    if (appWallet == null) return;
    final currency = ref.read(SettingsProviders.settings).currency;

    sl.get<DBHelper>().saveAppWallet(HiveAppWalletDTO.fromModel(appWallet));
  }

  Future<void> requestUpdate({
    bool forceUpdateChart = true,
  }) async {}

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
