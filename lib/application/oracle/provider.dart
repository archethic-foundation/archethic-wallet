/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';
import 'dart:developer';

import 'package:aewallet/application/oracle/state.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class _ArchethicOracleUCONotifier extends Notifier<ArchethicOracleUCO> {
  ArchethicOracle? archethicOracle;

  @override
  ArchethicOracleUCO build() {
    ref.onDispose(() {
      log('dispose ArchethicOracleUCONotifier');
      if (archethicOracle != null) {
        sl
            .get<OracleService>()
            .closeOracleUpdatesSubscription(archethicOracle!);
      }
    });
    return const ArchethicOracleUCO();
  }

  Future<void> init() async {
    await _getValue();
    await _subscribe();
  }

  Future<void> _getValue() async {
    final oracleUcoPrice = await sl.get<OracleService>().getOracleData();
    _fillInfo(oracleUcoPrice);
  }

  Future<void> _subscribe() async {
    archethicOracle = await sl
        .get<OracleService>()
        .subscribeToOracleUpdates((oracleUcoPrice) {
      _fillInfo(oracleUcoPrice!);
    });
  }

  void _fillInfo(OracleUcoPrice oracleUcoPrice) {
    log('Oracle: ${oracleUcoPrice.timestamp}, ${oracleUcoPrice.uco}');
    state = state.copyWith(
      timestamp: oracleUcoPrice.timestamp ?? 0,
      eur: oracleUcoPrice.uco!.eur ?? 0,
      usd: oracleUcoPrice.uco!.usd ?? 0,
    );
  }
}

abstract class ArchethicOracleUCOProviders {
  static final archethicOracleUCO = _archethicOracleUCONotifierProvider;
}
