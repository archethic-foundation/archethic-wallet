// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onramp.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onrampFeatureFlagHash() => r'4bd38f457dc1d53e8f9fd9bb2000d21b83cf8cc6';

/// See also [onrampFeatureFlag].
@ProviderFor(onrampFeatureFlag)
final onrampFeatureFlagProvider =
    AutoDisposeProvider<({bool fromCrypto, bool fromFiat})>.internal(
  onrampFeatureFlag,
  name: r'onrampFeatureFlagProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onrampFeatureFlagHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnrampFeatureFlagRef
    = AutoDisposeProviderRef<({bool fromCrypto, bool fromFiat})>;
String _$onRampRepositoryHash() => r'a705241a7f5defb511cbd70ffd9c0d216015455f';

/// See also [_onRampRepository].
@ProviderFor(_onRampRepository)
final _onRampRepositoryProvider =
    AutoDisposeFutureProvider<OnRampRepository>.internal(
  _onRampRepository,
  name: r'_onRampRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onRampRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef _OnRampRepositoryRef = AutoDisposeFutureProviderRef<OnRampRepository>;
String _$onrampEvmSetupHash() => r'29655d47c06f16ab9affd394248747eaa1d5ea49';

/// See also [onrampEvmSetup].
@ProviderFor(onrampEvmSetup)
final onrampEvmSetupProvider = AutoDisposeFutureProvider<OnRampSetup>.internal(
  onrampEvmSetup,
  name: r'onrampEvmSetupProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onrampEvmSetupHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnrampEvmSetupRef = AutoDisposeFutureProviderRef<OnRampSetup>;
String _$onrampProviderSetupHash() =>
    r'82d12f5d90e4978618c3bc9600c4a579cea57688';

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

/// See also [onrampProviderSetup].
@ProviderFor(onrampProviderSetup)
const onrampProviderSetupProvider = OnrampProviderSetupFamily();

/// See also [onrampProviderSetup].
class OnrampProviderSetupFamily extends Family<AsyncValue<OnRampProvider>> {
  /// See also [onrampProviderSetup].
  const OnrampProviderSetupFamily();

  /// See also [onrampProviderSetup].
  OnrampProviderSetupProvider call(
    String providerId,
  ) {
    return OnrampProviderSetupProvider(
      providerId,
    );
  }

  @override
  OnrampProviderSetupProvider getProviderOverride(
    covariant OnrampProviderSetupProvider provider,
  ) {
    return call(
      provider.providerId,
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
  String? get name => r'onrampProviderSetupProvider';
}

/// See also [onrampProviderSetup].
class OnrampProviderSetupProvider
    extends AutoDisposeFutureProvider<OnRampProvider> {
  /// See also [onrampProviderSetup].
  OnrampProviderSetupProvider(
    String providerId,
  ) : this._internal(
          (ref) => onrampProviderSetup(
            ref as OnrampProviderSetupRef,
            providerId,
          ),
          from: onrampProviderSetupProvider,
          name: r'onrampProviderSetupProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onrampProviderSetupHash,
          dependencies: OnrampProviderSetupFamily._dependencies,
          allTransitiveDependencies:
              OnrampProviderSetupFamily._allTransitiveDependencies,
          providerId: providerId,
        );

  OnrampProviderSetupProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.providerId,
  }) : super.internal();

  final String providerId;

  @override
  Override overrideWith(
    FutureOr<OnRampProvider> Function(OnrampProviderSetupRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OnrampProviderSetupProvider._internal(
        (ref) => create(ref as OnrampProviderSetupRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        providerId: providerId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OnRampProvider> createElement() {
    return _OnrampProviderSetupProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnrampProviderSetupProvider &&
        other.providerId == providerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, providerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnrampProviderSetupRef on AutoDisposeFutureProviderRef<OnRampProvider> {
  /// The parameter `providerId` of this provider.
  String get providerId;
}

class _OnrampProviderSetupProviderElement
    extends AutoDisposeFutureProviderElement<OnRampProvider>
    with OnrampProviderSetupRef {
  _OnrampProviderSetupProviderElement(super.provider);

  @override
  String get providerId => (origin as OnrampProviderSetupProvider).providerId;
}

String _$onrampProviderFavoriteSetupHash() =>
    r'9d3f9d2d2ee5c033d792b9fa2e6652bd68e17245';

/// See also [onrampProviderFavoriteSetup].
@ProviderFor(onrampProviderFavoriteSetup)
const onrampProviderFavoriteSetupProvider = OnrampProviderFavoriteSetupFamily();

/// See also [onrampProviderFavoriteSetup].
class OnrampProviderFavoriteSetupFamily
    extends Family<AsyncValue<({String chainId, String tokenId})?>> {
  /// See also [onrampProviderFavoriteSetup].
  const OnrampProviderFavoriteSetupFamily();

  /// See also [onrampProviderFavoriteSetup].
  OnrampProviderFavoriteSetupProvider call(
    String providerId,
  ) {
    return OnrampProviderFavoriteSetupProvider(
      providerId,
    );
  }

  @override
  OnrampProviderFavoriteSetupProvider getProviderOverride(
    covariant OnrampProviderFavoriteSetupProvider provider,
  ) {
    return call(
      provider.providerId,
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
  String? get name => r'onrampProviderFavoriteSetupProvider';
}

/// See also [onrampProviderFavoriteSetup].
class OnrampProviderFavoriteSetupProvider
    extends AutoDisposeFutureProvider<({String chainId, String tokenId})?> {
  /// See also [onrampProviderFavoriteSetup].
  OnrampProviderFavoriteSetupProvider(
    String providerId,
  ) : this._internal(
          (ref) => onrampProviderFavoriteSetup(
            ref as OnrampProviderFavoriteSetupRef,
            providerId,
          ),
          from: onrampProviderFavoriteSetupProvider,
          name: r'onrampProviderFavoriteSetupProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onrampProviderFavoriteSetupHash,
          dependencies: OnrampProviderFavoriteSetupFamily._dependencies,
          allTransitiveDependencies:
              OnrampProviderFavoriteSetupFamily._allTransitiveDependencies,
          providerId: providerId,
        );

  OnrampProviderFavoriteSetupProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.providerId,
  }) : super.internal();

  final String providerId;

  @override
  Override overrideWith(
    FutureOr<({String chainId, String tokenId})?> Function(
            OnrampProviderFavoriteSetupRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OnrampProviderFavoriteSetupProvider._internal(
        (ref) => create(ref as OnrampProviderFavoriteSetupRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        providerId: providerId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<({String chainId, String tokenId})?>
      createElement() {
    return _OnrampProviderFavoriteSetupProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnrampProviderFavoriteSetupProvider &&
        other.providerId == providerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, providerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnrampProviderFavoriteSetupRef
    on AutoDisposeFutureProviderRef<({String chainId, String tokenId})?> {
  /// The parameter `providerId` of this provider.
  String get providerId;
}

class _OnrampProviderFavoriteSetupProviderElement
    extends AutoDisposeFutureProviderElement<
        ({String chainId, String tokenId})?>
    with OnrampProviderFavoriteSetupRef {
  _OnrampProviderFavoriteSetupProviderElement(super.provider);

  @override
  String get providerId =>
      (origin as OnrampProviderFavoriteSetupProvider).providerId;
}

String _$onrampChainsForTokenHash() =>
    r'616a87fc7caba8621ed71d34c953f0b691c2da24';

/// See also [onrampChainsForToken].
@ProviderFor(onrampChainsForToken)
const onrampChainsForTokenProvider = OnrampChainsForTokenFamily();

/// See also [onrampChainsForToken].
class OnrampChainsForTokenFamily extends Family<AsyncValue<List<OnRampChain>>> {
  /// See also [onrampChainsForToken].
  const OnrampChainsForTokenFamily();

  /// See also [onrampChainsForToken].
  OnrampChainsForTokenProvider call(
    String tokenId,
  ) {
    return OnrampChainsForTokenProvider(
      tokenId,
    );
  }

  @override
  OnrampChainsForTokenProvider getProviderOverride(
    covariant OnrampChainsForTokenProvider provider,
  ) {
    return call(
      provider.tokenId,
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
  String? get name => r'onrampChainsForTokenProvider';
}

/// See also [onrampChainsForToken].
class OnrampChainsForTokenProvider
    extends AutoDisposeFutureProvider<List<OnRampChain>> {
  /// See also [onrampChainsForToken].
  OnrampChainsForTokenProvider(
    String tokenId,
  ) : this._internal(
          (ref) => onrampChainsForToken(
            ref as OnrampChainsForTokenRef,
            tokenId,
          ),
          from: onrampChainsForTokenProvider,
          name: r'onrampChainsForTokenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onrampChainsForTokenHash,
          dependencies: OnrampChainsForTokenFamily._dependencies,
          allTransitiveDependencies:
              OnrampChainsForTokenFamily._allTransitiveDependencies,
          tokenId: tokenId,
        );

  OnrampChainsForTokenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tokenId,
  }) : super.internal();

  final String tokenId;

  @override
  Override overrideWith(
    FutureOr<List<OnRampChain>> Function(OnrampChainsForTokenRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OnrampChainsForTokenProvider._internal(
        (ref) => create(ref as OnrampChainsForTokenRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tokenId: tokenId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<OnRampChain>> createElement() {
    return _OnrampChainsForTokenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnrampChainsForTokenProvider && other.tokenId == tokenId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tokenId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnrampChainsForTokenRef
    on AutoDisposeFutureProviderRef<List<OnRampChain>> {
  /// The parameter `tokenId` of this provider.
  String get tokenId;
}

class _OnrampChainsForTokenProviderElement
    extends AutoDisposeFutureProviderElement<List<OnRampChain>>
    with OnrampChainsForTokenRef {
  _OnrampChainsForTokenProviderElement(super.provider);

  @override
  String get tokenId => (origin as OnrampChainsForTokenProvider).tokenId;
}

String _$onrampTokensDisplayDataHash() =>
    r'b70661f56e9071a7fab01d79a697891920bcc410';

/// See also [onrampTokensDisplayData].
@ProviderFor(onrampTokensDisplayData)
final onrampTokensDisplayDataProvider =
    AutoDisposeFutureProvider<List<OnRampTokenDisplayData>>.internal(
  onrampTokensDisplayData,
  name: r'onrampTokensDisplayDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onrampTokensDisplayDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnrampTokensDisplayDataRef
    = AutoDisposeFutureProviderRef<List<OnRampTokenDisplayData>>;
String _$onrampTokenDisplayDataHash() =>
    r'fd4aa4a3fec52654406167e6f6acf806da7b8848';

/// See also [onrampTokenDisplayData].
@ProviderFor(onrampTokenDisplayData)
const onrampTokenDisplayDataProvider = OnrampTokenDisplayDataFamily();

/// See also [onrampTokenDisplayData].
class OnrampTokenDisplayDataFamily
    extends Family<AsyncValue<OnRampTokenDisplayData?>> {
  /// See also [onrampTokenDisplayData].
  const OnrampTokenDisplayDataFamily();

  /// See also [onrampTokenDisplayData].
  OnrampTokenDisplayDataProvider call(
    String id,
  ) {
    return OnrampTokenDisplayDataProvider(
      id,
    );
  }

  @override
  OnrampTokenDisplayDataProvider getProviderOverride(
    covariant OnrampTokenDisplayDataProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'onrampTokenDisplayDataProvider';
}

/// See also [onrampTokenDisplayData].
class OnrampTokenDisplayDataProvider
    extends AutoDisposeFutureProvider<OnRampTokenDisplayData?> {
  /// See also [onrampTokenDisplayData].
  OnrampTokenDisplayDataProvider(
    String id,
  ) : this._internal(
          (ref) => onrampTokenDisplayData(
            ref as OnrampTokenDisplayDataRef,
            id,
          ),
          from: onrampTokenDisplayDataProvider,
          name: r'onrampTokenDisplayDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onrampTokenDisplayDataHash,
          dependencies: OnrampTokenDisplayDataFamily._dependencies,
          allTransitiveDependencies:
              OnrampTokenDisplayDataFamily._allTransitiveDependencies,
          id: id,
        );

  OnrampTokenDisplayDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<OnRampTokenDisplayData?> Function(
            OnrampTokenDisplayDataRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OnrampTokenDisplayDataProvider._internal(
        (ref) => create(ref as OnrampTokenDisplayDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OnRampTokenDisplayData?> createElement() {
    return _OnrampTokenDisplayDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnrampTokenDisplayDataProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnrampTokenDisplayDataRef
    on AutoDisposeFutureProviderRef<OnRampTokenDisplayData?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _OnrampTokenDisplayDataProviderElement
    extends AutoDisposeFutureProviderElement<OnRampTokenDisplayData?>
    with OnrampTokenDisplayDataRef {
  _OnrampTokenDisplayDataProviderElement(super.provider);

  @override
  String get id => (origin as OnrampTokenDisplayDataProvider).id;
}

String _$onrampTokenFeesHash() => r'748a7f6d4b3518d4d6fb802d63d6d78c66261906';

/// See also [onrampTokenFees].
@ProviderFor(onrampTokenFees)
const onrampTokenFeesProvider = OnrampTokenFeesFamily();

/// See also [onrampTokenFees].
class OnrampTokenFeesFamily extends Family<AsyncValue<double?>> {
  /// See also [onrampTokenFees].
  const OnrampTokenFeesFamily();

  /// See also [onrampTokenFees].
  OnrampTokenFeesProvider call(
    String id,
  ) {
    return OnrampTokenFeesProvider(
      id,
    );
  }

  @override
  OnrampTokenFeesProvider getProviderOverride(
    covariant OnrampTokenFeesProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'onrampTokenFeesProvider';
}

/// See also [onrampTokenFees].
class OnrampTokenFeesProvider extends AutoDisposeFutureProvider<double?> {
  /// See also [onrampTokenFees].
  OnrampTokenFeesProvider(
    String id,
  ) : this._internal(
          (ref) => onrampTokenFees(
            ref as OnrampTokenFeesRef,
            id,
          ),
          from: onrampTokenFeesProvider,
          name: r'onrampTokenFeesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onrampTokenFeesHash,
          dependencies: OnrampTokenFeesFamily._dependencies,
          allTransitiveDependencies:
              OnrampTokenFeesFamily._allTransitiveDependencies,
          id: id,
        );

  OnrampTokenFeesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<double?> Function(OnrampTokenFeesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OnrampTokenFeesProvider._internal(
        (ref) => create(ref as OnrampTokenFeesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double?> createElement() {
    return _OnrampTokenFeesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnrampTokenFeesProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnrampTokenFeesRef on AutoDisposeFutureProviderRef<double?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _OnrampTokenFeesProviderElement
    extends AutoDisposeFutureProviderElement<double?> with OnrampTokenFeesRef {
  _OnrampTokenFeesProviderElement(super.provider);

  @override
  String get id => (origin as OnrampTokenFeesProvider).id;
}

String _$onrampTokenHash() => r'8a55a68257abf950c38665bd2c1584e9b429a58b';

/// See also [onrampToken].
@ProviderFor(onrampToken)
const onrampTokenProvider = OnrampTokenFamily();

/// See also [onrampToken].
class OnrampTokenFamily extends Family<AsyncValue<OnRampToken?>> {
  /// See also [onrampToken].
  const OnrampTokenFamily();

  /// See also [onrampToken].
  OnrampTokenProvider call(
    String chainId,
    String tokenId,
  ) {
    return OnrampTokenProvider(
      chainId,
      tokenId,
    );
  }

  @override
  OnrampTokenProvider getProviderOverride(
    covariant OnrampTokenProvider provider,
  ) {
    return call(
      provider.chainId,
      provider.tokenId,
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
  String? get name => r'onrampTokenProvider';
}

/// See also [onrampToken].
class OnrampTokenProvider extends AutoDisposeFutureProvider<OnRampToken?> {
  /// See also [onrampToken].
  OnrampTokenProvider(
    String chainId,
    String tokenId,
  ) : this._internal(
          (ref) => onrampToken(
            ref as OnrampTokenRef,
            chainId,
            tokenId,
          ),
          from: onrampTokenProvider,
          name: r'onrampTokenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onrampTokenHash,
          dependencies: OnrampTokenFamily._dependencies,
          allTransitiveDependencies:
              OnrampTokenFamily._allTransitiveDependencies,
          chainId: chainId,
          tokenId: tokenId,
        );

  OnrampTokenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chainId,
    required this.tokenId,
  }) : super.internal();

  final String chainId;
  final String tokenId;

  @override
  Override overrideWith(
    FutureOr<OnRampToken?> Function(OnrampTokenRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OnrampTokenProvider._internal(
        (ref) => create(ref as OnrampTokenRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chainId: chainId,
        tokenId: tokenId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OnRampToken?> createElement() {
    return _OnrampTokenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnrampTokenProvider &&
        other.chainId == chainId &&
        other.tokenId == tokenId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chainId.hashCode);
    hash = _SystemHash.combine(hash, tokenId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnrampTokenRef on AutoDisposeFutureProviderRef<OnRampToken?> {
  /// The parameter `chainId` of this provider.
  String get chainId;

  /// The parameter `tokenId` of this provider.
  String get tokenId;
}

class _OnrampTokenProviderElement
    extends AutoDisposeFutureProviderElement<OnRampToken?> with OnrampTokenRef {
  _OnrampTokenProviderElement(super.provider);

  @override
  String get chainId => (origin as OnrampTokenProvider).chainId;
  @override
  String get tokenId => (origin as OnrampTokenProvider).tokenId;
}

String _$onrampMaxAmountHash() => r'947d22bd1a39591b7e2048250088636c19baa0e4';

/// See also [onrampMaxAmount].
@ProviderFor(onrampMaxAmount)
final onrampMaxAmountProvider = AutoDisposeFutureProvider<num>.internal(
  onrampMaxAmount,
  name: r'onrampMaxAmountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onrampMaxAmountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnrampMaxAmountRef = AutoDisposeFutureProviderRef<num>;
String _$onrampDepositAddressHash() =>
    r'b1b94d3b7cdf2cc4c4cc3200d0171bfc1e498f26';

/// See also [onrampDepositAddress].
@ProviderFor(onrampDepositAddress)
final onrampDepositAddressProvider = AutoDisposeFutureProvider<String>.internal(
  onrampDepositAddress,
  name: r'onrampDepositAddressProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onrampDepositAddressHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnrampDepositAddressRef = AutoDisposeFutureProviderRef<String>;
String _$onrampTransfersHash() => r'bd8214a58e4cbd5bc7a24cc2872c4ed895ccad57';

/// See also [onrampTransfers].
@ProviderFor(onrampTransfers)
final onrampTransfersProvider =
    AutoDisposeStreamProvider<List<OnRampDeposit>>.internal(
  onrampTransfers,
  name: r'onrampTransfersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onrampTransfersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnrampTransfersRef = AutoDisposeStreamProviderRef<List<OnRampDeposit>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
