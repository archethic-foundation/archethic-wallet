// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onramp.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onrampFeatureFlagHash() => r'f9cff88010409bd61de5c7eb2b1aa1dfc1eeb104';

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
String _$onRampRepositoryHash() => r'3a0ab814fabaa91aad56ba972d64775c4c0410e0';

/// See also [onRampRepository].
@ProviderFor(onRampRepository)
final onRampRepositoryProvider =
    AutoDisposeFutureProvider<OnRampRepository>.internal(
  onRampRepository,
  name: r'onRampRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onRampRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnRampRepositoryRef = AutoDisposeFutureProviderRef<OnRampRepository>;
String _$onrampEvmSetupHash() => r'fe5573674ed4a395ad5f7ea8fbabcb8096dcec72';

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
String _$onrampChainsForTokenHash() =>
    r'616a87fc7caba8621ed71d34c953f0b691c2da24';

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

String _$onrampMaxAmountHash() => r'6e6447236f8389a401837c88adcad7b68e03bd33';

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
    r'8491366902a1869c3f1868dd712c452e7b27432e';

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
String _$onrampTransfersHash() => r'5a4fd5fbed8e0cb0130edae737fc0953128b8445';

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
String _$onrampProviderRepositoryHash() =>
    r'176fb88df0f5b5f5e80f76a29127850352a7998d';

/// See also [onrampProviderRepository].
@ProviderFor(onrampProviderRepository)
const onrampProviderRepositoryProvider = OnrampProviderRepositoryFamily();

/// See also [onrampProviderRepository].
class OnrampProviderRepositoryFamily extends Family<OnRampProviderRepository> {
  /// See also [onrampProviderRepository].
  const OnrampProviderRepositoryFamily();

  /// See also [onrampProviderRepository].
  OnrampProviderRepositoryProvider call(
    OnRampProvider onRampProvider,
  ) {
    return OnrampProviderRepositoryProvider(
      onRampProvider,
    );
  }

  @override
  OnrampProviderRepositoryProvider getProviderOverride(
    covariant OnrampProviderRepositoryProvider provider,
  ) {
    return call(
      provider.onRampProvider,
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
  String? get name => r'onrampProviderRepositoryProvider';
}

/// See also [onrampProviderRepository].
class OnrampProviderRepositoryProvider
    extends AutoDisposeProvider<OnRampProviderRepository> {
  /// See also [onrampProviderRepository].
  OnrampProviderRepositoryProvider(
    OnRampProvider onRampProvider,
  ) : this._internal(
          (ref) => onrampProviderRepository(
            ref as OnrampProviderRepositoryRef,
            onRampProvider,
          ),
          from: onrampProviderRepositoryProvider,
          name: r'onrampProviderRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onrampProviderRepositoryHash,
          dependencies: OnrampProviderRepositoryFamily._dependencies,
          allTransitiveDependencies:
              OnrampProviderRepositoryFamily._allTransitiveDependencies,
          onRampProvider: onRampProvider,
        );

  OnrampProviderRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.onRampProvider,
  }) : super.internal();

  final OnRampProvider onRampProvider;

  @override
  Override overrideWith(
    OnRampProviderRepository Function(OnrampProviderRepositoryRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OnrampProviderRepositoryProvider._internal(
        (ref) => create(ref as OnrampProviderRepositoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        onRampProvider: onRampProvider,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<OnRampProviderRepository> createElement() {
    return _OnrampProviderRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnrampProviderRepositoryProvider &&
        other.onRampProvider == onRampProvider;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, onRampProvider.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnrampProviderRepositoryRef
    on AutoDisposeProviderRef<OnRampProviderRepository> {
  /// The parameter `onRampProvider` of this provider.
  OnRampProvider get onRampProvider;
}

class _OnrampProviderRepositoryProviderElement
    extends AutoDisposeProviderElement<OnRampProviderRepository>
    with OnrampProviderRepositoryRef {
  _OnrampProviderRepositoryProviderElement(super.provider);

  @override
  OnRampProvider get onRampProvider =>
      (origin as OnrampProviderRepositoryProvider).onRampProvider;
}

String _$onrampProviderTokensHash() =>
    r'c261834b7f4bfd89384777313b5d1e3838fccf05';

/// See also [onrampProviderTokens].
@ProviderFor(onrampProviderTokens)
const onrampProviderTokensProvider = OnrampProviderTokensFamily();

/// See also [onrampProviderTokens].
class OnrampProviderTokensFamily
    extends Family<AsyncValue<List<OnRampProviderToken>>> {
  /// See also [onrampProviderTokens].
  const OnrampProviderTokensFamily();

  /// See also [onrampProviderTokens].
  OnrampProviderTokensProvider call(
    OnRampProvider onRampProvider,
  ) {
    return OnrampProviderTokensProvider(
      onRampProvider,
    );
  }

  @override
  OnrampProviderTokensProvider getProviderOverride(
    covariant OnrampProviderTokensProvider provider,
  ) {
    return call(
      provider.onRampProvider,
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
  String? get name => r'onrampProviderTokensProvider';
}

/// See also [onrampProviderTokens].
class OnrampProviderTokensProvider
    extends AutoDisposeFutureProvider<List<OnRampProviderToken>> {
  /// See also [onrampProviderTokens].
  OnrampProviderTokensProvider(
    OnRampProvider onRampProvider,
  ) : this._internal(
          (ref) => onrampProviderTokens(
            ref as OnrampProviderTokensRef,
            onRampProvider,
          ),
          from: onrampProviderTokensProvider,
          name: r'onrampProviderTokensProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onrampProviderTokensHash,
          dependencies: OnrampProviderTokensFamily._dependencies,
          allTransitiveDependencies:
              OnrampProviderTokensFamily._allTransitiveDependencies,
          onRampProvider: onRampProvider,
        );

  OnrampProviderTokensProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.onRampProvider,
  }) : super.internal();

  final OnRampProvider onRampProvider;

  @override
  Override overrideWith(
    FutureOr<List<OnRampProviderToken>> Function(
            OnrampProviderTokensRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OnrampProviderTokensProvider._internal(
        (ref) => create(ref as OnrampProviderTokensRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        onRampProvider: onRampProvider,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<OnRampProviderToken>> createElement() {
    return _OnrampProviderTokensProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnrampProviderTokensProvider &&
        other.onRampProvider == onRampProvider;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, onRampProvider.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnrampProviderTokensRef
    on AutoDisposeFutureProviderRef<List<OnRampProviderToken>> {
  /// The parameter `onRampProvider` of this provider.
  OnRampProvider get onRampProvider;
}

class _OnrampProviderTokensProviderElement
    extends AutoDisposeFutureProviderElement<List<OnRampProviderToken>>
    with OnrampProviderTokensRef {
  _OnrampProviderTokensProviderElement(super.provider);

  @override
  OnRampProvider get onRampProvider =>
      (origin as OnrampProviderTokensProvider).onRampProvider;
}

String _$onrampProviderFavoriteTokenHash() =>
    r'7c1d9eff6b05caeae12366463d9c02982ca40073';

/// See also [onrampProviderFavoriteToken].
@ProviderFor(onrampProviderFavoriteToken)
const onrampProviderFavoriteTokenProvider = OnrampProviderFavoriteTokenFamily();

/// See also [onrampProviderFavoriteToken].
class OnrampProviderFavoriteTokenFamily
    extends Family<AsyncValue<OnRampProviderToken?>> {
  /// See also [onrampProviderFavoriteToken].
  const OnrampProviderFavoriteTokenFamily();

  /// See also [onrampProviderFavoriteToken].
  OnrampProviderFavoriteTokenProvider call(
    OnRampProvider onRampProvider,
  ) {
    return OnrampProviderFavoriteTokenProvider(
      onRampProvider,
    );
  }

  @override
  OnrampProviderFavoriteTokenProvider getProviderOverride(
    covariant OnrampProviderFavoriteTokenProvider provider,
  ) {
    return call(
      provider.onRampProvider,
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
  String? get name => r'onrampProviderFavoriteTokenProvider';
}

/// See also [onrampProviderFavoriteToken].
class OnrampProviderFavoriteTokenProvider
    extends AutoDisposeFutureProvider<OnRampProviderToken?> {
  /// See also [onrampProviderFavoriteToken].
  OnrampProviderFavoriteTokenProvider(
    OnRampProvider onRampProvider,
  ) : this._internal(
          (ref) => onrampProviderFavoriteToken(
            ref as OnrampProviderFavoriteTokenRef,
            onRampProvider,
          ),
          from: onrampProviderFavoriteTokenProvider,
          name: r'onrampProviderFavoriteTokenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onrampProviderFavoriteTokenHash,
          dependencies: OnrampProviderFavoriteTokenFamily._dependencies,
          allTransitiveDependencies:
              OnrampProviderFavoriteTokenFamily._allTransitiveDependencies,
          onRampProvider: onRampProvider,
        );

  OnrampProviderFavoriteTokenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.onRampProvider,
  }) : super.internal();

  final OnRampProvider onRampProvider;

  @override
  Override overrideWith(
    FutureOr<OnRampProviderToken?> Function(
            OnrampProviderFavoriteTokenRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OnrampProviderFavoriteTokenProvider._internal(
        (ref) => create(ref as OnrampProviderFavoriteTokenRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        onRampProvider: onRampProvider,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OnRampProviderToken?> createElement() {
    return _OnrampProviderFavoriteTokenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnrampProviderFavoriteTokenProvider &&
        other.onRampProvider == onRampProvider;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, onRampProvider.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnrampProviderFavoriteTokenRef
    on AutoDisposeFutureProviderRef<OnRampProviderToken?> {
  /// The parameter `onRampProvider` of this provider.
  OnRampProvider get onRampProvider;
}

class _OnrampProviderFavoriteTokenProviderElement
    extends AutoDisposeFutureProviderElement<OnRampProviderToken?>
    with OnrampProviderFavoriteTokenRef {
  _OnrampProviderFavoriteTokenProviderElement(super.provider);

  @override
  OnRampProvider get onRampProvider =>
      (origin as OnrampProviderFavoriteTokenProvider).onRampProvider;
}

String _$onRampProviderOrdersHash() =>
    r'78ce12699b9382a93a86c57a2265b2f70efccb9d';

/// See also [OnRampProviderOrders].
@ProviderFor(OnRampProviderOrders)
final onRampProviderOrdersProvider = AutoDisposeNotifierProvider<
    OnRampProviderOrders, List<OnRampProviderOrder>>.internal(
  OnRampProviderOrders.new,
  name: r'onRampProviderOrdersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onRampProviderOrdersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OnRampProviderOrders = AutoDisposeNotifier<List<OnRampProviderOrder>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
