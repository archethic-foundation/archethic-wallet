// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$repositoryHash() => r'8108a17b41e83f8464f343ac68c6a7fbe0ccf09a';

/// See also [_repository].
@ProviderFor(_repository)
final _repositoryProvider = Provider<PriceHistoryRepositoryInterface>.internal(
  _repository,
  name: r'_repositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$repositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _RepositoryRef = ProviderRef<PriceHistoryRepositoryInterface>;
String _$intervalOptionHash() => r'4cd978430ce73fb54546b10a2cbc0c09ec602f58';

/// See also [_intervalOption].
@ProviderFor(_intervalOption)
final _intervalOptionProvider = Provider<MarketPriceHistoryInterval>.internal(
  _intervalOption,
  name: r'_intervalOptionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$intervalOptionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _IntervalOptionRef = ProviderRef<MarketPriceHistoryInterval>;
String _$priceHistoryHash() => r'34533b080c4536d59487a6886c8f0364b7dd5e7e';

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

typedef _PriceHistoryRef = FutureProviderRef<List<PriceHistoryValue>>;

/// See also [_priceHistory].
@ProviderFor(_priceHistory)
const _priceHistoryProvider = _PriceHistoryFamily();

/// See also [_priceHistory].
class _PriceHistoryFamily extends Family<AsyncValue<List<PriceHistoryValue>>> {
  /// See also [_priceHistory].
  const _PriceHistoryFamily();

  /// See also [_priceHistory].
  _PriceHistoryProvider call({
    required MarketPriceHistoryInterval scaleOption,
  }) {
    return _PriceHistoryProvider(
      scaleOption: scaleOption,
    );
  }

  @override
  _PriceHistoryProvider getProviderOverride(
    covariant _PriceHistoryProvider provider,
  ) {
    return call(
      scaleOption: provider.scaleOption,
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
  String? get name => r'_priceHistoryProvider';
}

/// See also [_priceHistory].
class _PriceHistoryProvider extends FutureProvider<List<PriceHistoryValue>> {
  /// See also [_priceHistory].
  _PriceHistoryProvider({
    required this.scaleOption,
  }) : super.internal(
          (ref) => _priceHistory(
            ref,
            scaleOption: scaleOption,
          ),
          from: _priceHistoryProvider,
          name: r'_priceHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$priceHistoryHash,
          dependencies: _PriceHistoryFamily._dependencies,
          allTransitiveDependencies:
              _PriceHistoryFamily._allTransitiveDependencies,
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

String _$priceEvolutionHash() => r'9a80fcd2803440801dc888c0e4c5bc316d20d0e4';
typedef _PriceEvolutionRef = FutureProviderRef<double>;

/// See also [_priceEvolution].
@ProviderFor(_priceEvolution)
const _priceEvolutionProvider = _PriceEvolutionFamily();

/// See also [_priceEvolution].
class _PriceEvolutionFamily extends Family<AsyncValue<double>> {
  /// See also [_priceEvolution].
  const _PriceEvolutionFamily();

  /// See also [_priceEvolution].
  _PriceEvolutionProvider call({
    required MarketPriceHistoryInterval scaleOption,
  }) {
    return _PriceEvolutionProvider(
      scaleOption: scaleOption,
    );
  }

  @override
  _PriceEvolutionProvider getProviderOverride(
    covariant _PriceEvolutionProvider provider,
  ) {
    return call(
      scaleOption: provider.scaleOption,
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
  String? get name => r'_priceEvolutionProvider';
}

/// See also [_priceEvolution].
class _PriceEvolutionProvider extends FutureProvider<double> {
  /// See also [_priceEvolution].
  _PriceEvolutionProvider({
    required this.scaleOption,
  }) : super.internal(
          (ref) => _priceEvolution(
            ref,
            scaleOption: scaleOption,
          ),
          from: _priceEvolutionProvider,
          name: r'_priceEvolutionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$priceEvolutionHash,
          dependencies: _PriceEvolutionFamily._dependencies,
          allTransitiveDependencies:
              _PriceEvolutionFamily._allTransitiveDependencies,
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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
