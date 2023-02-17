// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'primary_currency.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$convertedValueHash() => r'cd893e4a91d0ec60cbf774f975974e40d0e3daea';

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

typedef _ConvertedValueRef = AutoDisposeProviderRef<double>;

/// See also [_convertedValue].
@ProviderFor(_convertedValue)
const _convertedValueProvider = _ConvertedValueFamily();

/// See also [_convertedValue].
class _ConvertedValueFamily extends Family<double> {
  /// See also [_convertedValue].
  const _ConvertedValueFamily();

  /// See also [_convertedValue].
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
  _ConvertedValueProvider getProviderOverride(
    covariant _ConvertedValueProvider provider,
  ) {
    return call(
      amount: provider.amount,
      tokenPrice: provider.tokenPrice,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_convertedValueProvider';
}

/// See also [_convertedValue].
class _ConvertedValueProvider extends AutoDisposeProvider<double> {
  /// See also [_convertedValue].
  _ConvertedValueProvider({
    required this.amount,
    required this.tokenPrice,
  }) : super.internal(
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
                  : _$convertedValueHash,
          dependencies: _ConvertedValueFamily._dependencies,
          allTransitiveDependencies:
              _ConvertedValueFamily._allTransitiveDependencies,
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

String _$convertedValueLabelHash() =>
    r'a1293cbf8865714361f852a8ebb8c15c790f3dc3';
typedef _ConvertedValueLabelRef = AutoDisposeProviderRef<String>;

/// See also [_convertedValueLabel].
@ProviderFor(_convertedValueLabel)
const _convertedValueLabelProvider = _ConvertedValueLabelFamily();

/// See also [_convertedValueLabel].
class _ConvertedValueLabelFamily extends Family<String> {
  /// See also [_convertedValueLabel].
  const _ConvertedValueLabelFamily();

  /// See also [_convertedValueLabel].
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
  _ConvertedValueLabelProvider getProviderOverride(
    covariant _ConvertedValueLabelProvider provider,
  ) {
    return call(
      amount: provider.amount,
      tokenPrice: provider.tokenPrice,
      context: provider.context,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_convertedValueLabelProvider';
}

/// See also [_convertedValueLabel].
class _ConvertedValueLabelProvider extends AutoDisposeProvider<String> {
  /// See also [_convertedValueLabel].
  _ConvertedValueLabelProvider({
    required this.amount,
    required this.tokenPrice,
    required this.context,
  }) : super.internal(
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
                  : _$convertedValueLabelHash,
          dependencies: _ConvertedValueLabelFamily._dependencies,
          allTransitiveDependencies:
              _ConvertedValueLabelFamily._allTransitiveDependencies,
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

String _$selectedPrimaryCurrencyHash() =>
    r'76f1344bf25b37b1bf2bb5fbd6a951371e220965';

/// See also [_selectedPrimaryCurrency].
@ProviderFor(_selectedPrimaryCurrency)
final _selectedPrimaryCurrencyProvider =
    AutoDisposeProvider<AvailablePrimaryCurrency>.internal(
  _selectedPrimaryCurrency,
  name: r'_selectedPrimaryCurrencyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedPrimaryCurrencyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _SelectedPrimaryCurrencyRef
    = AutoDisposeProviderRef<AvailablePrimaryCurrency>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
