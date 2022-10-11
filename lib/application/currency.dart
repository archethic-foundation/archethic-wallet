import 'package:aewallet/application/language.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'currency.g.dart';

@Riverpod(keepAlive: true)
AvailableCurrency _selectedCurrency(_SelectedCurrencyRef ref) {
  final selectedLocale = ref.watch(LanguageProviders.selectedLocale);
  return ref
      .read(SettingsProviders.localSettingsRepository)
      .getCurrency(selectedLocale);
}

@Riverpod(keepAlive: true)
Future<void> _selectCurrency(
  _SelectCurrencyRef ref, {
  required AvailableCurrency currency,
}) async {
  await ref
      .read(SettingsProviders.localSettingsRepository)
      .setCurrency(currency);
  ref.invalidate(_selectedCurrencyProvider);
}

abstract class CurrencyProviders {
  static final selectedCurrency = _selectedCurrencyProvider;
  static final selectCurrency = _selectCurrencyProvider;
}
