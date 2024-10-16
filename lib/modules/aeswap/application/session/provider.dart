/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
Environment environment(EnvironmentRef ref) {
  final network = ref.watch(
    SettingsProviders.settings.select(
      (settings) => settings.network,
    ),
  );
  return Environment.byEndpoint(network.getLink());
}
