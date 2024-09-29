// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_pool.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dexPoolRepositoryHash() => r'c7f209c6db8a3ce0d65efef356a1bf4936bdd49b';

/// See also [_dexPoolRepository].
@ProviderFor(_dexPoolRepository)
final _dexPoolRepositoryProvider = Provider<DexPoolRepository>.internal(
  _dexPoolRepository,
  name: r'_dexPoolRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dexPoolRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _DexPoolRepositoryRef = ProviderRef<DexPoolRepository>;
String _$getRatioHash() => r'abba9ea31dce22d923c8af35737879a5579b0c56';

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

/// See also [_getRatio].
@ProviderFor(_getRatio)
const _getRatioProvider = _GetRatioFamily();

/// See also [_getRatio].
class _GetRatioFamily extends Family<AsyncValue<double>> {
  /// See also [_getRatio].
  const _GetRatioFamily();

  /// See also [_getRatio].
  _GetRatioProvider call(
    String poolGenesisAddress,
    DexToken token,
  ) {
    return _GetRatioProvider(
      poolGenesisAddress,
      token,
    );
  }

  @override
  _GetRatioProvider getProviderOverride(
    covariant _GetRatioProvider provider,
  ) {
    return call(
      provider.poolGenesisAddress,
      provider.token,
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
  String? get name => r'_getRatioProvider';
}

/// See also [_getRatio].
class _GetRatioProvider extends AutoDisposeFutureProvider<double> {
  /// See also [_getRatio].
  _GetRatioProvider(
    String poolGenesisAddress,
    DexToken token,
  ) : this._internal(
          (ref) => _getRatio(
            ref as _GetRatioRef,
            poolGenesisAddress,
            token,
          ),
          from: _getRatioProvider,
          name: r'_getRatioProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getRatioHash,
          dependencies: _GetRatioFamily._dependencies,
          allTransitiveDependencies: _GetRatioFamily._allTransitiveDependencies,
          poolGenesisAddress: poolGenesisAddress,
          token: token,
        );

  _GetRatioProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.poolGenesisAddress,
    required this.token,
  }) : super.internal();

  final String poolGenesisAddress;
  final DexToken token;

  @override
  Override overrideWith(
    FutureOr<double> Function(_GetRatioRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetRatioProvider._internal(
        (ref) => create(ref as _GetRatioRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        poolGenesisAddress: poolGenesisAddress,
        token: token,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double> createElement() {
    return _GetRatioProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetRatioProvider &&
        other.poolGenesisAddress == poolGenesisAddress &&
        other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, poolGenesisAddress.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetRatioRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `poolGenesisAddress` of this provider.
  String get poolGenesisAddress;

  /// The parameter `token` of this provider.
  DexToken get token;
}

class _GetRatioProviderElement extends AutoDisposeFutureProviderElement<double>
    with _GetRatioRef {
  _GetRatioProviderElement(super.provider);

  @override
  String get poolGenesisAddress =>
      (origin as _GetRatioProvider).poolGenesisAddress;
  @override
  DexToken get token => (origin as _GetRatioProvider).token;
}

String _$estimatePoolTVLInFiatHash() =>
    r'd28a3661d785aa229bf702254a430f39f2c091ac';

/// See also [_estimatePoolTVLInFiat].
@ProviderFor(_estimatePoolTVLInFiat)
const _estimatePoolTVLInFiatProvider = _EstimatePoolTVLInFiatFamily();

/// See also [_estimatePoolTVLInFiat].
class _EstimatePoolTVLInFiatFamily extends Family<AsyncValue<double>> {
  /// See also [_estimatePoolTVLInFiat].
  const _EstimatePoolTVLInFiatFamily();

  /// See also [_estimatePoolTVLInFiat].
  _EstimatePoolTVLInFiatProvider call(
    DexPool? pool,
  ) {
    return _EstimatePoolTVLInFiatProvider(
      pool,
    );
  }

  @override
  _EstimatePoolTVLInFiatProvider getProviderOverride(
    covariant _EstimatePoolTVLInFiatProvider provider,
  ) {
    return call(
      provider.pool,
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
  String? get name => r'_estimatePoolTVLInFiatProvider';
}

/// See also [_estimatePoolTVLInFiat].
class _EstimatePoolTVLInFiatProvider extends AutoDisposeFutureProvider<double> {
  /// See also [_estimatePoolTVLInFiat].
  _EstimatePoolTVLInFiatProvider(
    DexPool? pool,
  ) : this._internal(
          (ref) => _estimatePoolTVLInFiat(
            ref as _EstimatePoolTVLInFiatRef,
            pool,
          ),
          from: _estimatePoolTVLInFiatProvider,
          name: r'_estimatePoolTVLInFiatProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$estimatePoolTVLInFiatHash,
          dependencies: _EstimatePoolTVLInFiatFamily._dependencies,
          allTransitiveDependencies:
              _EstimatePoolTVLInFiatFamily._allTransitiveDependencies,
          pool: pool,
        );

  _EstimatePoolTVLInFiatProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pool,
  }) : super.internal();

  final DexPool? pool;

  @override
  Override overrideWith(
    FutureOr<double> Function(_EstimatePoolTVLInFiatRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _EstimatePoolTVLInFiatProvider._internal(
        (ref) => create(ref as _EstimatePoolTVLInFiatRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pool: pool,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double> createElement() {
    return _EstimatePoolTVLInFiatProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _EstimatePoolTVLInFiatProvider && other.pool == pool;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pool.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _EstimatePoolTVLInFiatRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `pool` of this provider.
  DexPool? get pool;
}

class _EstimatePoolTVLInFiatProviderElement
    extends AutoDisposeFutureProviderElement<double>
    with _EstimatePoolTVLInFiatRef {
  _EstimatePoolTVLInFiatProviderElement(super.provider);

  @override
  DexPool? get pool => (origin as _EstimatePoolTVLInFiatProvider).pool;
}

String _$estimateStatsHash() => r'1596f71c4734a7d88204ddbbf4e7cf7c23b398b8';

/// See also [_estimateStats].
@ProviderFor(_estimateStats)
const _estimateStatsProvider = _EstimateStatsFamily();

/// See also [_estimateStats].
class _EstimateStatsFamily extends Family<AsyncValue<DexPool>> {
  /// See also [_estimateStats].
  const _EstimateStatsFamily();

  /// See also [_estimateStats].
  _EstimateStatsProvider call(
    DexPool pool,
  ) {
    return _EstimateStatsProvider(
      pool,
    );
  }

  @override
  _EstimateStatsProvider getProviderOverride(
    covariant _EstimateStatsProvider provider,
  ) {
    return call(
      provider.pool,
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
  String? get name => r'_estimateStatsProvider';
}

/// See also [_estimateStats].
class _EstimateStatsProvider extends AutoDisposeFutureProvider<DexPool> {
  /// See also [_estimateStats].
  _EstimateStatsProvider(
    DexPool pool,
  ) : this._internal(
          (ref) => _estimateStats(
            ref as _EstimateStatsRef,
            pool,
          ),
          from: _estimateStatsProvider,
          name: r'_estimateStatsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$estimateStatsHash,
          dependencies: _EstimateStatsFamily._dependencies,
          allTransitiveDependencies:
              _EstimateStatsFamily._allTransitiveDependencies,
          pool: pool,
        );

  _EstimateStatsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pool,
  }) : super.internal();

  final DexPool pool;

  @override
  Override overrideWith(
    FutureOr<DexPool> Function(_EstimateStatsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _EstimateStatsProvider._internal(
        (ref) => create(ref as _EstimateStatsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pool: pool,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DexPool> createElement() {
    return _EstimateStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _EstimateStatsProvider && other.pool == pool;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pool.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _EstimateStatsRef on AutoDisposeFutureProviderRef<DexPool> {
  /// The parameter `pool` of this provider.
  DexPool get pool;
}

class _EstimateStatsProviderElement
    extends AutoDisposeFutureProviderElement<DexPool> with _EstimateStatsRef {
  _EstimateStatsProviderElement(super.provider);

  @override
  DexPool get pool => (origin as _EstimateStatsProvider).pool;
}

String _$getPoolHash() => r'26868c3344f284923859a35949442996de5dce72';

/// See also [_getPool].
@ProviderFor(_getPool)
const _getPoolProvider = _GetPoolFamily();

/// See also [_getPool].
class _GetPoolFamily extends Family<AsyncValue<DexPool?>> {
  /// See also [_getPool].
  const _GetPoolFamily();

  /// See also [_getPool].
  _GetPoolProvider call(
    String genesisAddress,
  ) {
    return _GetPoolProvider(
      genesisAddress,
    );
  }

  @override
  _GetPoolProvider getProviderOverride(
    covariant _GetPoolProvider provider,
  ) {
    return call(
      provider.genesisAddress,
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
  String? get name => r'_getPoolProvider';
}

/// See also [_getPool].
class _GetPoolProvider extends FutureProvider<DexPool?> {
  /// See also [_getPool].
  _GetPoolProvider(
    String genesisAddress,
  ) : this._internal(
          (ref) => _getPool(
            ref as _GetPoolRef,
            genesisAddress,
          ),
          from: _getPoolProvider,
          name: r'_getPoolProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPoolHash,
          dependencies: _GetPoolFamily._dependencies,
          allTransitiveDependencies: _GetPoolFamily._allTransitiveDependencies,
          genesisAddress: genesisAddress,
        );

  _GetPoolProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.genesisAddress,
  }) : super.internal();

  final String genesisAddress;

  @override
  Override overrideWith(
    FutureOr<DexPool?> Function(_GetPoolRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetPoolProvider._internal(
        (ref) => create(ref as _GetPoolRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        genesisAddress: genesisAddress,
      ),
    );
  }

  @override
  FutureProviderElement<DexPool?> createElement() {
    return _GetPoolProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetPoolProvider && other.genesisAddress == genesisAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, genesisAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetPoolRef on FutureProviderRef<DexPool?> {
  /// The parameter `genesisAddress` of this provider.
  String get genesisAddress;
}

class _GetPoolProviderElement extends FutureProviderElement<DexPool?>
    with _GetPoolRef {
  _GetPoolProviderElement(super.provider);

  @override
  String get genesisAddress => (origin as _GetPoolProvider).genesisAddress;
}

String _$loadPoolCardHash() => r'21ed0fe3ccf716d80cfa5b6df85e8a33a310dd88';

/// See also [_loadPoolCard].
@ProviderFor(_loadPoolCard)
const _loadPoolCardProvider = _LoadPoolCardFamily();

/// See also [_loadPoolCard].
class _LoadPoolCardFamily extends Family<AsyncValue<DexPool>> {
  /// See also [_loadPoolCard].
  const _LoadPoolCardFamily();

  /// See also [_loadPoolCard].
  _LoadPoolCardProvider call(
    DexPool poolInput, {
    bool forceLoadFromBC = false,
  }) {
    return _LoadPoolCardProvider(
      poolInput,
      forceLoadFromBC: forceLoadFromBC,
    );
  }

  @override
  _LoadPoolCardProvider getProviderOverride(
    covariant _LoadPoolCardProvider provider,
  ) {
    return call(
      provider.poolInput,
      forceLoadFromBC: provider.forceLoadFromBC,
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
  String? get name => r'_loadPoolCardProvider';
}

/// See also [_loadPoolCard].
class _LoadPoolCardProvider extends AutoDisposeFutureProvider<DexPool> {
  /// See also [_loadPoolCard].
  _LoadPoolCardProvider(
    DexPool poolInput, {
    bool forceLoadFromBC = false,
  }) : this._internal(
          (ref) => _loadPoolCard(
            ref as _LoadPoolCardRef,
            poolInput,
            forceLoadFromBC: forceLoadFromBC,
          ),
          from: _loadPoolCardProvider,
          name: r'_loadPoolCardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$loadPoolCardHash,
          dependencies: _LoadPoolCardFamily._dependencies,
          allTransitiveDependencies:
              _LoadPoolCardFamily._allTransitiveDependencies,
          poolInput: poolInput,
          forceLoadFromBC: forceLoadFromBC,
        );

  _LoadPoolCardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.poolInput,
    required this.forceLoadFromBC,
  }) : super.internal();

  final DexPool poolInput;
  final bool forceLoadFromBC;

  @override
  Override overrideWith(
    FutureOr<DexPool> Function(_LoadPoolCardRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _LoadPoolCardProvider._internal(
        (ref) => create(ref as _LoadPoolCardRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        poolInput: poolInput,
        forceLoadFromBC: forceLoadFromBC,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DexPool> createElement() {
    return _LoadPoolCardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _LoadPoolCardProvider &&
        other.poolInput == poolInput &&
        other.forceLoadFromBC == forceLoadFromBC;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, poolInput.hashCode);
    hash = _SystemHash.combine(hash, forceLoadFromBC.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _LoadPoolCardRef on AutoDisposeFutureProviderRef<DexPool> {
  /// The parameter `poolInput` of this provider.
  DexPool get poolInput;

  /// The parameter `forceLoadFromBC` of this provider.
  bool get forceLoadFromBC;
}

class _LoadPoolCardProviderElement
    extends AutoDisposeFutureProviderElement<DexPool> with _LoadPoolCardRef {
  _LoadPoolCardProviderElement(super.provider);

  @override
  DexPool get poolInput => (origin as _LoadPoolCardProvider).poolInput;
  @override
  bool get forceLoadFromBC => (origin as _LoadPoolCardProvider).forceLoadFromBC;
}

String _$removePoolFromFavoriteHash() =>
    r'cd55b9e36199bddbf2e7490a3a88ffc329542531';

/// See also [_removePoolFromFavorite].
@ProviderFor(_removePoolFromFavorite)
const _removePoolFromFavoriteProvider = _RemovePoolFromFavoriteFamily();

/// See also [_removePoolFromFavorite].
class _RemovePoolFromFavoriteFamily extends Family<AsyncValue<void>> {
  /// See also [_removePoolFromFavorite].
  const _RemovePoolFromFavoriteFamily();

  /// See also [_removePoolFromFavorite].
  _RemovePoolFromFavoriteProvider call(
    String poolGenesisAddress,
  ) {
    return _RemovePoolFromFavoriteProvider(
      poolGenesisAddress,
    );
  }

  @override
  _RemovePoolFromFavoriteProvider getProviderOverride(
    covariant _RemovePoolFromFavoriteProvider provider,
  ) {
    return call(
      provider.poolGenesisAddress,
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
  String? get name => r'_removePoolFromFavoriteProvider';
}

/// See also [_removePoolFromFavorite].
class _RemovePoolFromFavoriteProvider extends AutoDisposeFutureProvider<void> {
  /// See also [_removePoolFromFavorite].
  _RemovePoolFromFavoriteProvider(
    String poolGenesisAddress,
  ) : this._internal(
          (ref) => _removePoolFromFavorite(
            ref as _RemovePoolFromFavoriteRef,
            poolGenesisAddress,
          ),
          from: _removePoolFromFavoriteProvider,
          name: r'_removePoolFromFavoriteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$removePoolFromFavoriteHash,
          dependencies: _RemovePoolFromFavoriteFamily._dependencies,
          allTransitiveDependencies:
              _RemovePoolFromFavoriteFamily._allTransitiveDependencies,
          poolGenesisAddress: poolGenesisAddress,
        );

  _RemovePoolFromFavoriteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.poolGenesisAddress,
  }) : super.internal();

  final String poolGenesisAddress;

  @override
  Override overrideWith(
    FutureOr<void> Function(_RemovePoolFromFavoriteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _RemovePoolFromFavoriteProvider._internal(
        (ref) => create(ref as _RemovePoolFromFavoriteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        poolGenesisAddress: poolGenesisAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _RemovePoolFromFavoriteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _RemovePoolFromFavoriteProvider &&
        other.poolGenesisAddress == poolGenesisAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, poolGenesisAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _RemovePoolFromFavoriteRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `poolGenesisAddress` of this provider.
  String get poolGenesisAddress;
}

class _RemovePoolFromFavoriteProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with _RemovePoolFromFavoriteRef {
  _RemovePoolFromFavoriteProviderElement(super.provider);

  @override
  String get poolGenesisAddress =>
      (origin as _RemovePoolFromFavoriteProvider).poolGenesisAddress;
}

String _$addPoolFromFavoriteHash() =>
    r'0221bf89306a03cd6d397e870662e90c1f4e9944';

/// See also [_addPoolFromFavorite].
@ProviderFor(_addPoolFromFavorite)
const _addPoolFromFavoriteProvider = _AddPoolFromFavoriteFamily();

/// See also [_addPoolFromFavorite].
class _AddPoolFromFavoriteFamily extends Family<AsyncValue<void>> {
  /// See also [_addPoolFromFavorite].
  const _AddPoolFromFavoriteFamily();

  /// See also [_addPoolFromFavorite].
  _AddPoolFromFavoriteProvider call(
    String poolGenesisAddress,
  ) {
    return _AddPoolFromFavoriteProvider(
      poolGenesisAddress,
    );
  }

  @override
  _AddPoolFromFavoriteProvider getProviderOverride(
    covariant _AddPoolFromFavoriteProvider provider,
  ) {
    return call(
      provider.poolGenesisAddress,
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
  String? get name => r'_addPoolFromFavoriteProvider';
}

/// See also [_addPoolFromFavorite].
class _AddPoolFromFavoriteProvider extends AutoDisposeFutureProvider<void> {
  /// See also [_addPoolFromFavorite].
  _AddPoolFromFavoriteProvider(
    String poolGenesisAddress,
  ) : this._internal(
          (ref) => _addPoolFromFavorite(
            ref as _AddPoolFromFavoriteRef,
            poolGenesisAddress,
          ),
          from: _addPoolFromFavoriteProvider,
          name: r'_addPoolFromFavoriteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addPoolFromFavoriteHash,
          dependencies: _AddPoolFromFavoriteFamily._dependencies,
          allTransitiveDependencies:
              _AddPoolFromFavoriteFamily._allTransitiveDependencies,
          poolGenesisAddress: poolGenesisAddress,
        );

  _AddPoolFromFavoriteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.poolGenesisAddress,
  }) : super.internal();

  final String poolGenesisAddress;

  @override
  Override overrideWith(
    FutureOr<void> Function(_AddPoolFromFavoriteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _AddPoolFromFavoriteProvider._internal(
        (ref) => create(ref as _AddPoolFromFavoriteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        poolGenesisAddress: poolGenesisAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _AddPoolFromFavoriteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _AddPoolFromFavoriteProvider &&
        other.poolGenesisAddress == poolGenesisAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, poolGenesisAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _AddPoolFromFavoriteRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `poolGenesisAddress` of this provider.
  String get poolGenesisAddress;
}

class _AddPoolFromFavoriteProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with _AddPoolFromFavoriteRef {
  _AddPoolFromFavoriteProviderElement(super.provider);

  @override
  String get poolGenesisAddress =>
      (origin as _AddPoolFromFavoriteProvider).poolGenesisAddress;
}

String _$getPoolListHash() => r'0b5d6ac07afcab5df0992846124a02d528ef1e57';

/// See also [_getPoolList].
@ProviderFor(_getPoolList)
final _getPoolListProvider = FutureProvider<List<DexPool>>.internal(
  _getPoolList,
  name: r'_getPoolListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getPoolListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetPoolListRef = FutureProviderRef<List<DexPool>>;
String _$getPoolListForSearchHash() =>
    r'02ca24d5dcfd684c97e91f994e58210a1f326693';

/// See also [_getPoolListForSearch].
@ProviderFor(_getPoolListForSearch)
const _getPoolListForSearchProvider = _GetPoolListForSearchFamily();

/// See also [_getPoolListForSearch].
class _GetPoolListForSearchFamily extends Family<List<DexPool>> {
  /// See also [_getPoolListForSearch].
  const _GetPoolListForSearchFamily();

  /// See also [_getPoolListForSearch].
  _GetPoolListForSearchProvider call(
    String searchText,
    List<DexPool> poolList,
  ) {
    return _GetPoolListForSearchProvider(
      searchText,
      poolList,
    );
  }

  @override
  _GetPoolListForSearchProvider getProviderOverride(
    covariant _GetPoolListForSearchProvider provider,
  ) {
    return call(
      provider.searchText,
      provider.poolList,
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
  String? get name => r'_getPoolListForSearchProvider';
}

/// See also [_getPoolListForSearch].
class _GetPoolListForSearchProvider extends AutoDisposeProvider<List<DexPool>> {
  /// See also [_getPoolListForSearch].
  _GetPoolListForSearchProvider(
    String searchText,
    List<DexPool> poolList,
  ) : this._internal(
          (ref) => _getPoolListForSearch(
            ref as _GetPoolListForSearchRef,
            searchText,
            poolList,
          ),
          from: _getPoolListForSearchProvider,
          name: r'_getPoolListForSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPoolListForSearchHash,
          dependencies: _GetPoolListForSearchFamily._dependencies,
          allTransitiveDependencies:
              _GetPoolListForSearchFamily._allTransitiveDependencies,
          searchText: searchText,
          poolList: poolList,
        );

  _GetPoolListForSearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.searchText,
    required this.poolList,
  }) : super.internal();

  final String searchText;
  final List<DexPool> poolList;

  @override
  Override overrideWith(
    List<DexPool> Function(_GetPoolListForSearchRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetPoolListForSearchProvider._internal(
        (ref) => create(ref as _GetPoolListForSearchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        searchText: searchText,
        poolList: poolList,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<DexPool>> createElement() {
    return _GetPoolListForSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetPoolListForSearchProvider &&
        other.searchText == searchText &&
        other.poolList == poolList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchText.hashCode);
    hash = _SystemHash.combine(hash, poolList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetPoolListForSearchRef on AutoDisposeProviderRef<List<DexPool>> {
  /// The parameter `searchText` of this provider.
  String get searchText;

  /// The parameter `poolList` of this provider.
  List<DexPool> get poolList;
}

class _GetPoolListForSearchProviderElement
    extends AutoDisposeProviderElement<List<DexPool>>
    with _GetPoolListForSearchRef {
  _GetPoolListForSearchProviderElement(super.provider);

  @override
  String get searchText => (origin as _GetPoolListForSearchProvider).searchText;
  @override
  List<DexPool> get poolList =>
      (origin as _GetPoolListForSearchProvider).poolList;
}

String _$getPoolTxListHash() => r'21276612997dfc24fdbb6ff6045bad49a4b95300';

/// See also [_getPoolTxList].
@ProviderFor(_getPoolTxList)
const _getPoolTxListProvider = _GetPoolTxListFamily();

/// See also [_getPoolTxList].
class _GetPoolTxListFamily extends Family<AsyncValue<List<DexPoolTx>>> {
  /// See also [_getPoolTxList].
  const _GetPoolTxListFamily();

  /// See also [_getPoolTxList].
  _GetPoolTxListProvider call(
    DexPool pool,
    String lastTransactionAddress,
  ) {
    return _GetPoolTxListProvider(
      pool,
      lastTransactionAddress,
    );
  }

  @override
  _GetPoolTxListProvider getProviderOverride(
    covariant _GetPoolTxListProvider provider,
  ) {
    return call(
      provider.pool,
      provider.lastTransactionAddress,
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
  String? get name => r'_getPoolTxListProvider';
}

/// See also [_getPoolTxList].
class _GetPoolTxListProvider
    extends AutoDisposeFutureProvider<List<DexPoolTx>> {
  /// See also [_getPoolTxList].
  _GetPoolTxListProvider(
    DexPool pool,
    String lastTransactionAddress,
  ) : this._internal(
          (ref) => _getPoolTxList(
            ref as _GetPoolTxListRef,
            pool,
            lastTransactionAddress,
          ),
          from: _getPoolTxListProvider,
          name: r'_getPoolTxListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPoolTxListHash,
          dependencies: _GetPoolTxListFamily._dependencies,
          allTransitiveDependencies:
              _GetPoolTxListFamily._allTransitiveDependencies,
          pool: pool,
          lastTransactionAddress: lastTransactionAddress,
        );

  _GetPoolTxListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pool,
    required this.lastTransactionAddress,
  }) : super.internal();

  final DexPool pool;
  final String lastTransactionAddress;

  @override
  Override overrideWith(
    FutureOr<List<DexPoolTx>> Function(_GetPoolTxListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetPoolTxListProvider._internal(
        (ref) => create(ref as _GetPoolTxListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pool: pool,
        lastTransactionAddress: lastTransactionAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DexPoolTx>> createElement() {
    return _GetPoolTxListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetPoolTxListProvider &&
        other.pool == pool &&
        other.lastTransactionAddress == lastTransactionAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pool.hashCode);
    hash = _SystemHash.combine(hash, lastTransactionAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetPoolTxListRef on AutoDisposeFutureProviderRef<List<DexPoolTx>> {
  /// The parameter `pool` of this provider.
  DexPool get pool;

  /// The parameter `lastTransactionAddress` of this provider.
  String get lastTransactionAddress;
}

class _GetPoolTxListProviderElement
    extends AutoDisposeFutureProviderElement<List<DexPoolTx>>
    with _GetPoolTxListRef {
  _GetPoolTxListProviderElement(super.provider);

  @override
  DexPool get pool => (origin as _GetPoolTxListProvider).pool;
  @override
  String get lastTransactionAddress =>
      (origin as _GetPoolTxListProvider).lastTransactionAddress;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
