/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'primary_currency.g.dart';

@Riverpod(keepAlive: true)
AvailablePrimaryCurrency _selectedPrimaryCurrency(
  _SelectedPrimaryCurrencyRef ref,
) {
  return ref
      .read(SettingsProviders.localSettingsRepository)
      .getPrimaryCurrency();
}

@Riverpod(keepAlive: true)
Future<void> _selectPrimaryCurrency(
  _SelectPrimaryCurrencyRef ref, {
  required AvailablePrimaryCurrency primaryCurrency,
}) async {
  await ref
      .read(SettingsProviders.localSettingsRepository)
      .setPrimaryCurrency(primaryCurrency);
  ref.invalidate(_selectedPrimaryCurrencyProvider);
}

abstract class PrimaryCurrencyProviders {
  static final selectedPrimaryCurrency = _selectedPrimaryCurrencyProvider;
  static final selectPrimaryCurrency = _selectPrimaryCurrencyProvider;
}
