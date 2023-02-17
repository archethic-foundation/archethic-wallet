// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_price.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$remoteRepositoriesHash() =>
    r'362a295c805d83fbba9037ae975c2d6fca22130d';

/// See also [_remoteRepositories].
@ProviderFor(_remoteRepositories)
final _remoteRepositoriesProvider =
    Provider<List<MarketRepositoryInterface>>.internal(
  _remoteRepositories,
  name: r'_remoteRepositoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$remoteRepositoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _RemoteRepositoriesRef = ProviderRef<List<MarketRepositoryInterface>>;
String _$localRepositoryHash() => r'7efe0044701d7e08d9349e6a071111974c3fcf94';

/// See also [_localRepository].
@ProviderFor(_localRepository)
final _localRepositoryProvider =
    Provider<MarketLocalRepositoryInterface>.internal(
  _localRepository,
  name: r'_localRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _LocalRepositoryRef = ProviderRef<MarketLocalRepositoryInterface>;
String _$currencyMarketPriceHash() =>
    r'ca31fb7c63400231dc1b5c0e00398daf3c4d67d3';

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

typedef _CurrencyMarketPriceRef = FutureProviderRef<MarketPrice>;

/// See also [_currencyMarketPrice].
@ProviderFor(_currencyMarketPrice)
const _currencyMarketPriceProvider = _CurrencyMarketPriceFamily();

/// See also [_currencyMarketPrice].
class _CurrencyMarketPriceFamily extends Family<AsyncValue<MarketPrice>> {
  /// See also [_currencyMarketPrice].
  const _CurrencyMarketPriceFamily();

  /// See also [_currencyMarketPrice].
  _CurrencyMarketPriceProvider call({
    required AvailableCurrencyEnum currency,
  }) {
    return _CurrencyMarketPriceProvider(
      currency: currency,
    );
  }

  @override
  _CurrencyMarketPriceProvider getProviderOverride(
    covariant _CurrencyMarketPriceProvider provider,
  ) {
    return call(
      currency: provider.currency,
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
  String? get name => r'_currencyMarketPriceProvider';
}

/// See also [_currencyMarketPrice].
class _CurrencyMarketPriceProvider extends FutureProvider<MarketPrice> {
  /// See also [_currencyMarketPrice].
  _CurrencyMarketPriceProvider({
    required this.currency,
  }) : super.internal(
          (ref) => _currencyMarketPrice(
            ref,
            currency: currency,
          ),
          from: _currencyMarketPriceProvider,
          name: r'_currencyMarketPriceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currencyMarketPriceHash,
          dependencies: _CurrencyMarketPriceFamily._dependencies,
          allTransitiveDependencies:
              _CurrencyMarketPriceFamily._allTransitiveDependencies,
        );

  final AvailableCurrencyEnum currency;

  @override
  bool operator ==(Object other) {
    return other is _CurrencyMarketPriceProvider && other.currency == currency;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, currency.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$selectedCurrencyMarketPriceHash() =>
    r'9cef0636024c92796b2436dd8af6e1a5dfe5a314';

/// See also [_selectedCurrencyMarketPrice].
@ProviderFor(_selectedCurrencyMarketPrice)
final _selectedCurrencyMarketPriceProvider =
    FutureProvider<MarketPrice>.internal(
  _selectedCurrencyMarketPrice,
  name: r'_selectedCurrencyMarketPriceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedCurrencyMarketPriceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _SelectedCurrencyMarketPriceRef = FutureProviderRef<MarketPrice>;
String _$convertedToSelectedCurrencyHash() =>
    r'0914ae92d570d894e9d964b736d753f3a2bfe8fc';
typedef _ConvertedToSelectedCurrencyRef = AutoDisposeFutureProviderRef<double>;

/// See also [_convertedToSelectedCurrency].
@ProviderFor(_convertedToSelectedCurrency)
const _convertedToSelectedCurrencyProvider =
    _ConvertedToSelectedCurrencyFamily();

/// See also [_convertedToSelectedCurrency].
class _ConvertedToSelectedCurrencyFamily extends Family<AsyncValue<double>> {
  /// See also [_convertedToSelectedCurrency].
  const _ConvertedToSelectedCurrencyFamily();

  /// See also [_convertedToSelectedCurrency].
  _ConvertedToSelectedCurrencyProvider call({
    required double nativeAmount,
  }) {
    return _ConvertedToSelectedCurrencyProvider(
      nativeAmount: nativeAmount,
    );
  }

  @override
  _ConvertedToSelectedCurrencyProvider getProviderOverride(
    covariant _ConvertedToSelectedCurrencyProvider provider,
  ) {
    return call(
      nativeAmount: provider.nativeAmount,
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
  String? get name => r'_convertedToSelectedCurrencyProvider';
}

/// See also [_convertedToSelectedCurrency].
class _ConvertedToSelectedCurrencyProvider
    extends AutoDisposeFutureProvider<double> {
  /// See also [_convertedToSelectedCurrency].
  _ConvertedToSelectedCurrencyProvider({
    required this.nativeAmount,
  }) : super.internal(
          (ref) => _convertedToSelectedCurrency(
            ref,
            nativeAmount: nativeAmount,
          ),
          from: _convertedToSelectedCurrencyProvider,
          name: r'_convertedToSelectedCurrencyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$convertedToSelectedCurrencyHash,
          dependencies: _ConvertedToSelectedCurrencyFamily._dependencies,
          allTransitiveDependencies:
              _ConvertedToSelectedCurrencyFamily._allTransitiveDependencies,
        );

  final double nativeAmount;

  @override
  bool operator ==(Object other) {
    return other is _ConvertedToSelectedCurrencyProvider &&
        other.nativeAmount == nativeAmount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, nativeAmount.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
