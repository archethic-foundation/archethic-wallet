// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verified_tokens.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$verifiedTokensRepositoryHash() =>
    r'a5536a493a63ddbd1102cb6e91c31a402641f749';

/// See also [_verifiedTokensRepository].
@ProviderFor(_verifiedTokensRepository)
final _verifiedTokensRepositoryProvider =
    Provider<VerifiedTokensRepository>.internal(
  _verifiedTokensRepository,
  name: r'_verifiedTokensRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$verifiedTokensRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _VerifiedTokensRepositoryRef = ProviderRef<VerifiedTokensRepository>;
String _$getVerifiedTokensHash() => r'fdd8866488e517f410a06ff21dbafbbdc420d431';

/// See also [_getVerifiedTokens].
@ProviderFor(_getVerifiedTokens)
final _getVerifiedTokensProvider = FutureProvider<VerifiedTokens>.internal(
  _getVerifiedTokens,
  name: r'_getVerifiedTokensProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getVerifiedTokensHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetVerifiedTokensRef = FutureProviderRef<VerifiedTokens>;
String _$getVerifiedTokensFromNetworkHash() =>
    r'2fa668047a8eb298967cceda206c4ba848025cce';

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

/// See also [_getVerifiedTokensFromNetwork].
@ProviderFor(_getVerifiedTokensFromNetwork)
const _getVerifiedTokensFromNetworkProvider =
    _GetVerifiedTokensFromNetworkFamily();

/// See also [_getVerifiedTokensFromNetwork].
class _GetVerifiedTokensFromNetworkFamily
    extends Family<AsyncValue<List<String>>> {
  /// See also [_getVerifiedTokensFromNetwork].
  const _GetVerifiedTokensFromNetworkFamily();

  /// See also [_getVerifiedTokensFromNetwork].
  _GetVerifiedTokensFromNetworkProvider call(
    AvailableNetworks network,
  ) {
    return _GetVerifiedTokensFromNetworkProvider(
      network,
    );
  }

  @override
  _GetVerifiedTokensFromNetworkProvider getProviderOverride(
    covariant _GetVerifiedTokensFromNetworkProvider provider,
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
  String? get name => r'_getVerifiedTokensFromNetworkProvider';
}

/// See also [_getVerifiedTokensFromNetwork].
class _GetVerifiedTokensFromNetworkProvider
    extends FutureProvider<List<String>> {
  /// See also [_getVerifiedTokensFromNetwork].
  _GetVerifiedTokensFromNetworkProvider(
    AvailableNetworks network,
  ) : this._internal(
          (ref) => _getVerifiedTokensFromNetwork(
            ref as _GetVerifiedTokensFromNetworkRef,
            network,
          ),
          from: _getVerifiedTokensFromNetworkProvider,
          name: r'_getVerifiedTokensFromNetworkProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getVerifiedTokensFromNetworkHash,
          dependencies: _GetVerifiedTokensFromNetworkFamily._dependencies,
          allTransitiveDependencies:
              _GetVerifiedTokensFromNetworkFamily._allTransitiveDependencies,
          network: network,
        );

  _GetVerifiedTokensFromNetworkProvider._internal(
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
    FutureOr<List<String>> Function(_GetVerifiedTokensFromNetworkRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetVerifiedTokensFromNetworkProvider._internal(
        (ref) => create(ref as _GetVerifiedTokensFromNetworkRef),
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
    return _GetVerifiedTokensFromNetworkProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetVerifiedTokensFromNetworkProvider &&
        other.network == network;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, network.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetVerifiedTokensFromNetworkRef on FutureProviderRef<List<String>> {
  /// The parameter `network` of this provider.
  AvailableNetworks get network;
}

class _GetVerifiedTokensFromNetworkProviderElement
    extends FutureProviderElement<List<String>>
    with _GetVerifiedTokensFromNetworkRef {
  _GetVerifiedTokensFromNetworkProviderElement(super.provider);

  @override
  AvailableNetworks get network =>
      (origin as _GetVerifiedTokensFromNetworkProvider).network;
}

String _$isVerifiedTokenHash() => r'49675ea9c1c497b6d5b7c85c8079aafb3b46f092';

/// See also [_isVerifiedToken].
@ProviderFor(_isVerifiedToken)
const _isVerifiedTokenProvider = _IsVerifiedTokenFamily();

/// See also [_isVerifiedToken].
class _IsVerifiedTokenFamily extends Family<AsyncValue<bool>> {
  /// See also [_isVerifiedToken].
  const _IsVerifiedTokenFamily();

  /// See also [_isVerifiedToken].
  _IsVerifiedTokenProvider call(
    String address,
  ) {
    return _IsVerifiedTokenProvider(
      address,
    );
  }

  @override
  _IsVerifiedTokenProvider getProviderOverride(
    covariant _IsVerifiedTokenProvider provider,
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
  String? get name => r'_isVerifiedTokenProvider';
}

/// See also [_isVerifiedToken].
class _IsVerifiedTokenProvider extends FutureProvider<bool> {
  /// See also [_isVerifiedToken].
  _IsVerifiedTokenProvider(
    String address,
  ) : this._internal(
          (ref) => _isVerifiedToken(
            ref as _IsVerifiedTokenRef,
            address,
          ),
          from: _isVerifiedTokenProvider,
          name: r'_isVerifiedTokenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isVerifiedTokenHash,
          dependencies: _IsVerifiedTokenFamily._dependencies,
          allTransitiveDependencies:
              _IsVerifiedTokenFamily._allTransitiveDependencies,
          address: address,
        );

  _IsVerifiedTokenProvider._internal(
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
    FutureOr<bool> Function(_IsVerifiedTokenRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _IsVerifiedTokenProvider._internal(
        (ref) => create(ref as _IsVerifiedTokenRef),
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
    return _IsVerifiedTokenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _IsVerifiedTokenProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _IsVerifiedTokenRef on FutureProviderRef<bool> {
  /// The parameter `address` of this provider.
  String get address;
}

class _IsVerifiedTokenProviderElement extends FutureProviderElement<bool>
    with _IsVerifiedTokenRef {
  _IsVerifiedTokenProviderElement(super.provider);

  @override
  String get address => (origin as _IsVerifiedTokenProvider).address;
}

String _$verifiedTokensNotifierHash() =>
    r'10e04193cf6739956d6b71b4d938a690a32e1b5a';

/// See also [_VerifiedTokensNotifier].
@ProviderFor(_VerifiedTokensNotifier)
final _verifiedTokensNotifierProvider =
    NotifierProvider<_VerifiedTokensNotifier, List<String>>.internal(
  _VerifiedTokensNotifier.new,
  name: r'_verifiedTokensNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$verifiedTokensNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VerifiedTokensNotifier = Notifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
