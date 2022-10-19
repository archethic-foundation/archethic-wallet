/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedPrimaryCurrencyNotifier
    extends StateNotifier<AvailablePrimaryCurrency> {
  SelectedPrimaryCurrencyNotifier(this.ref)
      : super(
          const AvailablePrimaryCurrency(AvailablePrimaryCurrencyEnum.native),
        ) {
    _loadInitialValue();
  }

  final Ref ref;

  Future<void> _loadInitialValue() async {
    state = ref
        .read(SettingsProviders.localSettingsRepository)
        .getPrimaryCurrency();
  }

  Future<void> selectPrimaryCurrency({
    required AvailablePrimaryCurrency primaryCurrency,
  }) async {
    await ref
        .read(SettingsProviders.localSettingsRepository)
        .setPrimaryCurrency(primaryCurrency);
    state = primaryCurrency;
  }

  Future<void> switchSelectedPrimaryCurrency() async {
    await selectPrimaryCurrency(
      primaryCurrency: AvailablePrimaryCurrency(
        state.primaryCurrency == AvailablePrimaryCurrencyEnum.native
            ? AvailablePrimaryCurrencyEnum.fiat
            : AvailablePrimaryCurrencyEnum.native,
      ),
    );
  }
}

final _selectedPrimaryCurrencyProvider = StateNotifierProvider<
    SelectedPrimaryCurrencyNotifier, AvailablePrimaryCurrency>(
  SelectedPrimaryCurrencyNotifier.new,
);

// @Riverpod(keepAlive: true)
// AvailablePrimaryCurrency _selectedPrimaryCurrency(
//   _SelectedPrimaryCurrencyRef ref,
// ) {
//   return ref
//       .read(SettingsProviders.localSettingsRepository)
//       .getPrimaryCurrency();
// }

// @Riverpod(keepAlive: true)
// Future<void> _selectPrimaryCurrency(
//   _SelectPrimaryCurrencyRef ref, {
//   required AvailablePrimaryCurrency primaryCurrency,
// }) async {
//   await ref
//       .read(SettingsProviders.localSettingsRepository)
//       .setPrimaryCurrency(primaryCurrency);
//   ref.refresh(_selectedPrimaryCurrencyProvider);
// }

abstract class PrimaryCurrencyProviders {
  static final selectedPrimaryCurrency = _selectedPrimaryCurrencyProvider;
}
