// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_blockchain.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getBlockchainsListConfHash() =>
    r'aa40a923c255a19e7035f7ad0c1dd746bfabbdbd';

/// See also [_getBlockchainsListConf].
@ProviderFor(_getBlockchainsListConf)
final _getBlockchainsListConfProvider =
    AutoDisposeFutureProvider<List<DexBlockchain>>.internal(
  _getBlockchainsListConf,
  name: r'_getBlockchainsListConfProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getBlockchainsListConfHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetBlockchainsListConfRef
    = AutoDisposeFutureProviderRef<List<DexBlockchain>>;
String _$dexBlockchainsRepositoryHash() =>
    r'3a5adcf0e2f9fba36a78732fdd83e32878ef57b0';

/// See also [_dexBlockchainsRepository].
@ProviderFor(_dexBlockchainsRepository)
final _dexBlockchainsRepositoryProvider =
    AutoDisposeProvider<DexBlockchainsRepository>.internal(
  _dexBlockchainsRepository,
  name: r'_dexBlockchainsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dexBlockchainsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _DexBlockchainsRepositoryRef
    = AutoDisposeProviderRef<DexBlockchainsRepository>;
String _$getBlockchainsListHash() =>
    r'305b0bc65fb19f1418ef572ed3706c63898cd162';

/// See also [_getBlockchainsList].
@ProviderFor(_getBlockchainsList)
final _getBlockchainsListProvider =
    AutoDisposeFutureProvider<List<DexBlockchain>>.internal(
  _getBlockchainsList,
  name: r'_getBlockchainsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getBlockchainsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetBlockchainsListRef
    = AutoDisposeFutureProviderRef<List<DexBlockchain>>;
String _$getBlockchainFromEnvHash() =>
    r'dcf8032276cb97a764ba4423d2ef318da4f7ddd7';

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

/// See also [_getBlockchainFromEnv].
@ProviderFor(_getBlockchainFromEnv)
const _getBlockchainFromEnvProvider = _GetBlockchainFromEnvFamily();

/// See also [_getBlockchainFromEnv].
class _GetBlockchainFromEnvFamily extends Family<AsyncValue<DexBlockchain?>> {
  /// See also [_getBlockchainFromEnv].
  const _GetBlockchainFromEnvFamily();

  /// See also [_getBlockchainFromEnv].
  _GetBlockchainFromEnvProvider call(
    String env,
  ) {
    return _GetBlockchainFromEnvProvider(
      env,
    );
  }

  @override
  _GetBlockchainFromEnvProvider getProviderOverride(
    covariant _GetBlockchainFromEnvProvider provider,
  ) {
    return call(
      provider.env,
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
  String? get name => r'_getBlockchainFromEnvProvider';
}

/// See also [_getBlockchainFromEnv].
class _GetBlockchainFromEnvProvider
    extends AutoDisposeFutureProvider<DexBlockchain?> {
  /// See also [_getBlockchainFromEnv].
  _GetBlockchainFromEnvProvider(
    String env,
  ) : this._internal(
          (ref) => _getBlockchainFromEnv(
            ref as _GetBlockchainFromEnvRef,
            env,
          ),
          from: _getBlockchainFromEnvProvider,
          name: r'_getBlockchainFromEnvProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBlockchainFromEnvHash,
          dependencies: _GetBlockchainFromEnvFamily._dependencies,
          allTransitiveDependencies:
              _GetBlockchainFromEnvFamily._allTransitiveDependencies,
          env: env,
        );

  _GetBlockchainFromEnvProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.env,
  }) : super.internal();

  final String env;

  @override
  Override overrideWith(
    FutureOr<DexBlockchain?> Function(_GetBlockchainFromEnvRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetBlockchainFromEnvProvider._internal(
        (ref) => create(ref as _GetBlockchainFromEnvRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        env: env,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DexBlockchain?> createElement() {
    return _GetBlockchainFromEnvProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetBlockchainFromEnvProvider && other.env == env;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, env.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetBlockchainFromEnvRef on AutoDisposeFutureProviderRef<DexBlockchain?> {
  /// The parameter `env` of this provider.
  String get env;
}

class _GetBlockchainFromEnvProviderElement
    extends AutoDisposeFutureProviderElement<DexBlockchain?>
    with _GetBlockchainFromEnvRef {
  _GetBlockchainFromEnvProviderElement(super.provider);

  @override
  String get env => (origin as _GetBlockchainFromEnvProvider).env;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
