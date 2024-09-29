/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/modules/aeswap/application/session/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
Environment environment(EnvironmentRef ref) => ref.watch(
      sessionAESwapNotifierProvider.select(
        (sessionAESwap) => sessionAESwap.environment,
      ),
    );

// TODO: Try to delete this provider
@Riverpod(keepAlive: true)
class SessionAESwapNotifier extends _$SessionAESwapNotifier {
  SessionAESwapNotifier();

  @override
  SessionAESwap build() {
    final network = ref.watch(
      SettingsProviders.settings.select(
        (settings) => settings.network,
      ),
    );
    final environment = Environment.byEndpoint(network.getLink());

    return SessionAESwap(
      environment: environment,
    );
  }

  Future<void> update(
    FutureOr<SessionAESwap> Function(SessionAESwap previous) func,
  ) async {
    state = await func(state);
  }
}
