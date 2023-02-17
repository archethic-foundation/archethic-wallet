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

String $_convertedValueHash() => r'cd893e4a91d0ec60cbf774f975974e40d0e3daea';

/// See also [_convertedValue].
class _ConvertedValueProvider extends AutoDisposeProvider<double> {
  _ConvertedValueProvider({
    required this.amount,
    required this.tokenPrice,
  }) : super(
          (ref) => _convertedValue(
            ref,
            amount: amount,
            tokenPrice: tokenPrice,
          ),
          from: _convertedValueProvider,
          name: r'_convertedValueProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_convertedValueHash,
        );

  final double amount;
  final double tokenPrice;

  @override
  bool operator ==(Object other) {
    return other is _ConvertedValueProvider &&
        other.amount == amount &&
        other.tokenPrice == tokenPrice;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);
    hash = _SystemHash.combine(hash, tokenPrice.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _ConvertedValueRef = AutoDisposeProviderRef<double>;

/// See also [_convertedValue].
final _convertedValueProvider = _ConvertedValueFamily();

class _ConvertedValueFamily extends Family<double> {
  _ConvertedValueFamily();

  _ConvertedValueProvider call({
    required double amount,
    required double tokenPrice,
  }) {
    return _ConvertedValueProvider(
      amount: amount,
      tokenPrice: tokenPrice,
    );
  }

  @override
  AutoDisposeProvider<double> getProviderOverride(
    covariant _ConvertedValueProvider provider,
  ) {
    return call(
      amount: provider.amount,
      tokenPrice: provider.tokenPrice,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_convertedValueProvider';
}

String $_convertedValueLabelHash() =>
    r'a1293cbf8865714361f852a8ebb8c15c790f3dc3';

/// See also [_convertedValueLabel].
class _ConvertedValueLabelProvider extends AutoDisposeProvider<String> {
  _ConvertedValueLabelProvider({
    required this.amount,
    required this.tokenPrice,
    required this.context,
  }) : super(
          (ref) => _convertedValueLabel(
            ref,
            amount: amount,
            tokenPrice: tokenPrice,
            context: context,
          ),
          from: _convertedValueLabelProvider,
          name: r'_convertedValueLabelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_convertedValueLabelHash,
        );

  final double amount;
  final double tokenPrice;
  final BuildContext context;

  @override
  bool operator ==(Object other) {
    return other is _ConvertedValueLabelProvider &&
        other.amount == amount &&
        other.tokenPrice == tokenPrice &&
        other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);
    hash = _SystemHash.combine(hash, tokenPrice.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _ConvertedValueLabelRef = AutoDisposeProviderRef<String>;

/// See also [_convertedValueLabel].
final _convertedValueLabelProvider = _ConvertedValueLabelFamily();

class _ConvertedValueLabelFamily extends Family<String> {
  _ConvertedValueLabelFamily();

  _ConvertedValueLabelProvider call({
    required double amount,
    required double tokenPrice,
    required BuildContext context,
  }) {
    return _ConvertedValueLabelProvider(
      amount: amount,
      tokenPrice: tokenPrice,
      context: context,
    );
  }

  @override
  AutoDisposeProvider<String> getProviderOverride(
    covariant _ConvertedValueLabelProvider provider,
  ) {
    return call(
      amount: provider.amount,
      tokenPrice: provider.tokenPrice,
      context: provider.context,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_convertedValueLabelProvider';
}

String $_selectedPrimaryCurrencyHash() =>
    r'76f1344bf25b37b1bf2bb5fbd6a951371e220965';

/// See also [_selectedPrimaryCurrency].
final _selectedPrimaryCurrencyProvider =
    AutoDisposeProvider<AvailablePrimaryCurrency>(
  _selectedPrimaryCurrency,
  name: r'_selectedPrimaryCurrencyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_selectedPrimaryCurrencyHash,
);
typedef _SelectedPrimaryCurrencyRef
    = AutoDisposeProviderRef<AvailablePrimaryCurrency>;
