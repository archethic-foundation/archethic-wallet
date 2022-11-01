// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_price.dart';

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

String $_marketPriceRepositoryHash() =>
    r'4d696077766b2b62620a67805e57212c93470547';

/// See also [_marketPriceRepository].
final _marketPriceRepositoryProvider =
    AutoDisposeProvider<MarketPriceRepository>(
  _marketPriceRepository,
  name: r'_marketPriceRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_marketPriceRepositoryHash,
);
typedef _MarketPriceRepositoryRef
    = AutoDisposeProviderRef<MarketPriceRepository>;
String $_getUCOMarketPriceHash() => r'fbff76c4ffd04a20fe5a566d48572924ffde28e0';

/// See also [_getUCOMarketPrice].
class _GetUCOMarketPriceProvider extends AutoDisposeProvider<MarketPrice?> {
  _GetUCOMarketPriceProvider({
    required this.currency,
  }) : super(
          (ref) => _getUCOMarketPrice(
            ref,
            currency: currency,
          ),
          from: _getUCOMarketPriceProvider,
          name: r'_getUCOMarketPriceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_getUCOMarketPriceHash,
        );

  final String currency;

  @override
  bool operator ==(Object other) {
    return other is _GetUCOMarketPriceProvider && other.currency == currency;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, currency.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _GetUCOMarketPriceRef = AutoDisposeProviderRef<MarketPrice?>;

/// See also [_getUCOMarketPrice].
final _getUCOMarketPriceProvider = _GetUCOMarketPriceFamily();

class _GetUCOMarketPriceFamily extends Family<MarketPrice?> {
  _GetUCOMarketPriceFamily();

  _GetUCOMarketPriceProvider call({
    required String currency,
  }) {
    return _GetUCOMarketPriceProvider(
      currency: currency,
    );
  }

  @override
  AutoDisposeProvider<MarketPrice?> getProviderOverride(
    covariant _GetUCOMarketPriceProvider provider,
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
  String? get name => r'_getUCOMarketPriceProvider';
}
