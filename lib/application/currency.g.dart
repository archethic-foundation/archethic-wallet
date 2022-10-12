// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String $_selectedCurrencyHash() => r'95d5d20a11f8ac25fb9816ebfd2d3abf54117085';

/// See also [_selectedCurrency].
final _selectedCurrencyProvider = Provider<AvailableCurrency>(
  _selectedCurrency,
  name: r'_selectedCurrencyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_selectedCurrencyHash,
);
typedef _SelectedCurrencyRef = ProviderRef<AvailableCurrency>;
String $_selectCurrencyHash() => r'21c528a3776e12d8fe49deda14aef37d8668b905';

/// See also [_selectCurrency].
class _SelectCurrencyProvider extends FutureProvider<void> {
  _SelectCurrencyProvider({
    required this.currency,
  }) : super(
          (ref) => _selectCurrency(
            ref,
            currency: currency,
          ),
          from: _selectCurrencyProvider,
          name: r'_selectCurrencyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_selectCurrencyHash,
        );

  final AvailableCurrency currency;

  @override
  bool operator ==(Object other) {
    return other is _SelectCurrencyProvider && other.currency == currency;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, currency.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _SelectCurrencyRef = FutureProviderRef<void>;

/// See also [_selectCurrency].
final _selectCurrencyProvider = _SelectCurrencyFamily();

class _SelectCurrencyFamily extends Family<AsyncValue<void>> {
  _SelectCurrencyFamily();

  _SelectCurrencyProvider call({
    required AvailableCurrency currency,
  }) {
    return _SelectCurrencyProvider(
      currency: currency,
    );
  }

  @override
  FutureProvider<void> getProviderOverride(
    covariant _SelectCurrencyProvider provider,
  ) {
    return call(
      currency: provider.currency,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_selectCurrencyProvider';
}
