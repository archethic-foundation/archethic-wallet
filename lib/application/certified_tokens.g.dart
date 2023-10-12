// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certified_tokens.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$certifiedTokensRepositoryHash() =>
    r'bfb9f4584aabd06bb41eec37fa22d711aefcaa54';

/// See also [_certifiedTokensRepository].
@ProviderFor(_certifiedTokensRepository)
final _certifiedTokensRepositoryProvider =
    Provider<CertifiedTokensRepository>.internal(
  _certifiedTokensRepository,
  name: r'_certifiedTokensRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$certifiedTokensRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _CertifiedTokensRepositoryRef = ProviderRef<CertifiedTokensRepository>;
String _$getCertifiedTokensHash() =>
    r'24cb78dcd93ab6250ac6be32e05d51e5558be114';

/// See also [_getCertifiedTokens].
@ProviderFor(_getCertifiedTokens)
final _getCertifiedTokensProvider = FutureProvider<CertifiedTokens>.internal(
  _getCertifiedTokens,
  name: r'_getCertifiedTokensProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCertifiedTokensHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetCertifiedTokensRef = FutureProviderRef<CertifiedTokens>;
String _$getCertifiedTokensFromNetworkHash() =>
    r'87004e363bda55dd10bd13758b1f56b2c78f3978';

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

/// See also [_getCertifiedTokensFromNetwork].
@ProviderFor(_getCertifiedTokensFromNetwork)
const _getCertifiedTokensFromNetworkProvider =
    _GetCertifiedTokensFromNetworkFamily();

/// See also [_getCertifiedTokensFromNetwork].
class _GetCertifiedTokensFromNetworkFamily
    extends Family<AsyncValue<List<String>>> {
  /// See also [_getCertifiedTokensFromNetwork].
  const _GetCertifiedTokensFromNetworkFamily();

  /// See also [_getCertifiedTokensFromNetwork].
  _GetCertifiedTokensFromNetworkProvider call(
    AvailableNetworks network,
  ) {
    return _GetCertifiedTokensFromNetworkProvider(
      network,
    );
  }

  @override
  _GetCertifiedTokensFromNetworkProvider getProviderOverride(
    covariant _GetCertifiedTokensFromNetworkProvider provider,
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
  String? get name => r'_getCertifiedTokensFromNetworkProvider';
}

/// See also [_getCertifiedTokensFromNetwork].
class _GetCertifiedTokensFromNetworkProvider
    extends FutureProvider<List<String>> {
  /// See also [_getCertifiedTokensFromNetwork].
  _GetCertifiedTokensFromNetworkProvider(
    AvailableNetworks network,
  ) : this._internal(
          (ref) => _getCertifiedTokensFromNetwork(
            ref as _GetCertifiedTokensFromNetworkRef,
            network,
          ),
          from: _getCertifiedTokensFromNetworkProvider,
          name: r'_getCertifiedTokensFromNetworkProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCertifiedTokensFromNetworkHash,
          dependencies: _GetCertifiedTokensFromNetworkFamily._dependencies,
          allTransitiveDependencies:
              _GetCertifiedTokensFromNetworkFamily._allTransitiveDependencies,
          network: network,
        );

  _GetCertifiedTokensFromNetworkProvider._internal(
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
    FutureOr<List<String>> Function(_GetCertifiedTokensFromNetworkRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetCertifiedTokensFromNetworkProvider._internal(
        (ref) => create(ref as _GetCertifiedTokensFromNetworkRef),
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
  FutureProviderElement<List<String>> createElement() {
    return _GetCertifiedTokensFromNetworkProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetCertifiedTokensFromNetworkProvider &&
        other.network == network;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, network.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetCertifiedTokensFromNetworkRef on FutureProviderRef<List<String>> {
  /// The parameter `network` of this provider.
  AvailableNetworks get network;
}

class _GetCertifiedTokensFromNetworkProviderElement
    extends FutureProviderElement<List<String>>
    with _GetCertifiedTokensFromNetworkRef {
  _GetCertifiedTokensFromNetworkProviderElement(super.provider);

  @override
  AvailableNetworks get network =>
      (origin as _GetCertifiedTokensFromNetworkProvider).network;
}

String _$isCertifiedTokenHash() => r'ebf6019ca3928d9edbfb5220f4b48423169c92ef';

/// See also [_isCertifiedToken].
@ProviderFor(_isCertifiedToken)
const _isCertifiedTokenProvider = _IsCertifiedTokenFamily();

/// See also [_isCertifiedToken].
class _IsCertifiedTokenFamily extends Family<AsyncValue<bool>> {
  /// See also [_isCertifiedToken].
  const _IsCertifiedTokenFamily();

  /// See also [_isCertifiedToken].
  _IsCertifiedTokenProvider call(
    String address,
  ) {
    return _IsCertifiedTokenProvider(
      address,
    );
  }

  @override
  _IsCertifiedTokenProvider getProviderOverride(
    covariant _IsCertifiedTokenProvider provider,
  ) {
    return call(
      provider.address,
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
  String? get name => r'_isCertifiedTokenProvider';
}

/// See also [_isCertifiedToken].
class _IsCertifiedTokenProvider extends FutureProvider<bool> {
  /// See also [_isCertifiedToken].
  _IsCertifiedTokenProvider(
    String address,
  ) : this._internal(
          (ref) => _isCertifiedToken(
            ref as _IsCertifiedTokenRef,
            address,
          ),
          from: _isCertifiedTokenProvider,
          name: r'_isCertifiedTokenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isCertifiedTokenHash,
          dependencies: _IsCertifiedTokenFamily._dependencies,
          allTransitiveDependencies:
              _IsCertifiedTokenFamily._allTransitiveDependencies,
          address: address,
        );

  _IsCertifiedTokenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
  }) : super.internal();

  final String address;

  @override
  Override overrideWith(
    FutureOr<bool> Function(_IsCertifiedTokenRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _IsCertifiedTokenProvider._internal(
        (ref) => create(ref as _IsCertifiedTokenRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        address: address,
      ),
    );
  }

  @override
  FutureProviderElement<bool> createElement() {
    return _IsCertifiedTokenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _IsCertifiedTokenProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _IsCertifiedTokenRef on FutureProviderRef<bool> {
  /// The parameter `address` of this provider.
  String get address;
}

class _IsCertifiedTokenProviderElement extends FutureProviderElement<bool>
    with _IsCertifiedTokenRef {
  _IsCertifiedTokenProviderElement(super.provider);

  @override
  String get address => (origin as _IsCertifiedTokenProvider).address;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
