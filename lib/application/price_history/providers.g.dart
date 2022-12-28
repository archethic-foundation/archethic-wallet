// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

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

String _$_repositoryHash() => r'2d0970425bfa60ca8bd216a9118fb6c8502cc577';

/// See also [_repository].
final _repositoryProvider = Provider<PriceHistoryRepositoryInterface>(
  _repository,
  name: r'_repositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$_repositoryHash,
);
typedef _RepositoryRef = ProviderRef<PriceHistoryRepositoryInterface>;
String _$_intervalOptionHash() => r'1d96ed2fccef7118b031018144165de4749ec1b4';

/// See also [_intervalOption].
final _intervalOptionProvider = Provider<MarketPriceHistoryInterval>(
  _intervalOption,
  name: r'_intervalOptionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$_intervalOptionHash,
);
typedef _IntervalOptionRef = ProviderRef<MarketPriceHistoryInterval>;
String _$_priceHistoryHash() => r'53a8fb4fa9f1089577cc2150bd23d7ff77972298';

/// See also [_priceHistory].
class _PriceHistoryProvider extends FutureProvider<List<PriceHistoryValue>> {
  _PriceHistoryProvider({
    required this.scaleOption,
  }) : super(
          (ref) => _priceHistory(
            ref,
            scaleOption: scaleOption,
          ),
          from: _priceHistoryProvider,
          name: r'_priceHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$_priceHistoryHash,
        );

  final MarketPriceHistoryInterval scaleOption;

  @override
  bool operator ==(Object other) {
    return other is _PriceHistoryProvider && other.scaleOption == scaleOption;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, scaleOption.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _PriceHistoryRef = FutureProviderRef<List<PriceHistoryValue>>;

/// See also [_priceHistory].
final _priceHistoryProvider = _PriceHistoryFamily();

class _PriceHistoryFamily extends Family<AsyncValue<List<PriceHistoryValue>>> {
  _PriceHistoryFamily();

  _PriceHistoryProvider call({
    required MarketPriceHistoryInterval scaleOption,
  }) {
    return _PriceHistoryProvider(
      scaleOption: scaleOption,
    );
  }

  @override
  FutureProvider<List<PriceHistoryValue>> getProviderOverride(
    covariant _PriceHistoryProvider provider,
  ) {
    return call(
      scaleOption: provider.scaleOption,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_priceHistoryProvider';
}

String _$_priceEvolutionHash() => r'bcc3b22660c82056f10a536b6f8285b00e202ec6';

/// See also [_priceEvolution].
class _PriceEvolutionProvider extends FutureProvider<double> {
  _PriceEvolutionProvider({
    required this.scaleOption,
  }) : super(
          (ref) => _priceEvolution(
            ref,
            scaleOption: scaleOption,
          ),
          from: _priceEvolutionProvider,
          name: r'_priceEvolutionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$_priceEvolutionHash,
        );

  final MarketPriceHistoryInterval scaleOption;

  @override
  bool operator ==(Object other) {
    return other is _PriceEvolutionProvider && other.scaleOption == scaleOption;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, scaleOption.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _PriceEvolutionRef = FutureProviderRef<double>;

/// See also [_priceEvolution].
final _priceEvolutionProvider = _PriceEvolutionFamily();

class _PriceEvolutionFamily extends Family<AsyncValue<double>> {
  _PriceEvolutionFamily();

  _PriceEvolutionProvider call({
    required MarketPriceHistoryInterval scaleOption,
  }) {
    return _PriceEvolutionProvider(
      scaleOption: scaleOption,
    );
  }

  @override
  FutureProvider<double> getProviderOverride(
    covariant _PriceEvolutionProvider provider,
  ) {
    return call(
      scaleOption: provider.scaleOption,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_priceEvolutionProvider';
}
