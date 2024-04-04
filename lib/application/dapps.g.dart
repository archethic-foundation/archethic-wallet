// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dapps.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dAppsRepositoryHash() => r'e0ff90bd27811981cdb0a797ef97c22f93c5e479';

/// See also [_dAppsRepository].
@ProviderFor(_dAppsRepository)
final _dAppsRepositoryProvider = AutoDisposeProvider<DAppsRepository>.internal(
  _dAppsRepository,
  name: r'_dAppsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dAppsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _DAppsRepositoryRef = AutoDisposeProviderRef<DAppsRepository>;
String _$getDAppsHash() => r'8e11b7174686c6a8b35f02d60a25e9d3c84f1255';

/// See also [_getDApps].
@ProviderFor(_getDApps)
final _getDAppsProvider = AutoDisposeFutureProvider<List<DApps>>.internal(
  _getDApps,
  name: r'_getDAppsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getDAppsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetDAppsRef = AutoDisposeFutureProviderRef<List<DApps>>;
String _$getDAppsFromNetworkHash() =>
    r'300ed4b91a71a313f395098f0abfbbfc42118540';

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

/// See also [_getDAppsFromNetwork].
@ProviderFor(_getDAppsFromNetwork)
const _getDAppsFromNetworkProvider = _GetDAppsFromNetworkFamily();

/// See also [_getDAppsFromNetwork].
class _GetDAppsFromNetworkFamily extends Family<AsyncValue<List<DApps>>> {
  /// See also [_getDAppsFromNetwork].
  const _GetDAppsFromNetworkFamily();

  /// See also [_getDAppsFromNetwork].
  _GetDAppsFromNetworkProvider call(
    AvailableNetworks network,
  ) {
    return _GetDAppsFromNetworkProvider(
      network,
    );
  }

  @override
  _GetDAppsFromNetworkProvider getProviderOverride(
    covariant _GetDAppsFromNetworkProvider provider,
  ) {
    return call(
      provider.network,
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
  String? get name => r'_getDAppsFromNetworkProvider';
}

/// See also [_getDAppsFromNetwork].
class _GetDAppsFromNetworkProvider
    extends AutoDisposeFutureProvider<List<DApps>> {
  /// See also [_getDAppsFromNetwork].
  _GetDAppsFromNetworkProvider(
    AvailableNetworks network,
  ) : this._internal(
          (ref) => _getDAppsFromNetwork(
            ref as _GetDAppsFromNetworkRef,
            network,
          ),
          from: _getDAppsFromNetworkProvider,
          name: r'_getDAppsFromNetworkProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDAppsFromNetworkHash,
          dependencies: _GetDAppsFromNetworkFamily._dependencies,
          allTransitiveDependencies:
              _GetDAppsFromNetworkFamily._allTransitiveDependencies,
          network: network,
        );

  _GetDAppsFromNetworkProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.network,
  }) : super.internal();

  final AvailableNetworks network;

  @override
  Override overrideWith(
    FutureOr<List<DApps>> Function(_GetDAppsFromNetworkRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetDAppsFromNetworkProvider._internal(
        (ref) => create(ref as _GetDAppsFromNetworkRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        network: network,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DApps>> createElement() {
    return _GetDAppsFromNetworkProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetDAppsFromNetworkProvider && other.network == network;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, network.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetDAppsFromNetworkRef on AutoDisposeFutureProviderRef<List<DApps>> {
  /// The parameter `network` of this provider.
  AvailableNetworks get network;
}

class _GetDAppsFromNetworkProviderElement
    extends AutoDisposeFutureProviderElement<List<DApps>>
    with _GetDAppsFromNetworkRef {
  _GetDAppsFromNetworkProviderElement(super.provider);

  @override
  AvailableNetworks get network =>
      (origin as _GetDAppsFromNetworkProvider).network;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
