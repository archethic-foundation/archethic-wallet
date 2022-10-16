// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'primary_currency.dart';

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

String $_selectedPrimaryCurrencyHash() =>
    r'193ba9f582b9284ef9c33a0c1b7865a8d68493c1';

/// See also [_selectedPrimaryCurrency].
final _selectedPrimaryCurrencyProvider = Provider<AvailablePrimaryCurrency>(
  _selectedPrimaryCurrency,
  name: r'_selectedPrimaryCurrencyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_selectedPrimaryCurrencyHash,
);
typedef _SelectedPrimaryCurrencyRef = ProviderRef<AvailablePrimaryCurrency>;
String $_selectPrimaryCurrencyHash() =>
    r'abb1cb32fec446dc9c9ec7c0bb4521eb373476e1';

/// See also [_selectPrimaryCurrency].
class _SelectPrimaryCurrencyProvider extends FutureProvider<void> {
  _SelectPrimaryCurrencyProvider({
    required this.primaryCurrency,
  }) : super(
          (ref) => _selectPrimaryCurrency(
            ref,
            primaryCurrency: primaryCurrency,
          ),
          from: _selectPrimaryCurrencyProvider,
          name: r'_selectPrimaryCurrencyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_selectPrimaryCurrencyHash,
        );

  final AvailablePrimaryCurrency primaryCurrency;

  @override
  bool operator ==(Object other) {
    return other is _SelectPrimaryCurrencyProvider &&
        other.primaryCurrency == primaryCurrency;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, primaryCurrency.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _SelectPrimaryCurrencyRef = FutureProviderRef<void>;

/// See also [_selectPrimaryCurrency].
final _selectPrimaryCurrencyProvider = _SelectPrimaryCurrencyFamily();

class _SelectPrimaryCurrencyFamily extends Family<AsyncValue<void>> {
  _SelectPrimaryCurrencyFamily();

  _SelectPrimaryCurrencyProvider call({
    required AvailablePrimaryCurrency primaryCurrency,
  }) {
    return _SelectPrimaryCurrencyProvider(
      primaryCurrency: primaryCurrency,
    );
  }

  @override
  FutureProvider<void> getProviderOverride(
    covariant _SelectPrimaryCurrencyProvider provider,
  ) {
    return call(
      primaryCurrency: provider.primaryCurrency,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_selectPrimaryCurrencyProvider';
}
