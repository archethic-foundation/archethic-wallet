// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onramp.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onRampRepositoryHash() => r'b80651db185aa6c54ad6917dc79658245d4f0fd9';

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
String _$onrampSetupHash() => r'a1d1c7cf18e50bc7444cc0c47262101f546ec5a8';

/// See also [onrampSetup].
@ProviderFor(onrampSetup)
final onrampSetupProvider =
    AutoDisposeFutureProvider<({List<OnRampChain> chains})>.internal(
  onrampSetup,
  name: r'onrampSetupProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$onrampSetupHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnrampSetupRef
    = AutoDisposeFutureProviderRef<({List<OnRampChain> chains})>;
String _$onrampChainsForTokenHash() =>
    r'730e2f4d451d1bd715d5f1eafce81d61d026a971';

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
    String tokenSymbol,
  ) {
    return OnrampChainsForTokenProvider(
      tokenSymbol,
    );
  }

  @override
  OnrampChainsForTokenProvider getProviderOverride(
    covariant OnrampChainsForTokenProvider provider,
  ) {
    return call(
      provider.tokenSymbol,
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
    String tokenSymbol,
  ) : this._internal(
          (ref) => onrampChainsForToken(
            ref as OnrampChainsForTokenRef,
            tokenSymbol,
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
          tokenSymbol: tokenSymbol,
        );

  OnrampChainsForTokenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tokenSymbol,
  }) : super.internal();

  final String tokenSymbol;

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
        tokenSymbol: tokenSymbol,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<OnRampChain>> createElement() {
    return _OnrampChainsForTokenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnrampChainsForTokenProvider &&
        other.tokenSymbol == tokenSymbol;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tokenSymbol.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnrampChainsForTokenRef
    on AutoDisposeFutureProviderRef<List<OnRampChain>> {
  /// The parameter `tokenSymbol` of this provider.
  String get tokenSymbol;
}

class _OnrampChainsForTokenProviderElement
    extends AutoDisposeFutureProviderElement<List<OnRampChain>>
    with OnrampChainsForTokenRef {
  _OnrampChainsForTokenProviderElement(super.provider);

  @override
  String get tokenSymbol =>
      (origin as OnrampChainsForTokenProvider).tokenSymbol;
}

String _$onrampChainsHash() => r'b4b16737b32e3893dc607a0f7522cb9493285be8';

/// See also [onrampChains].
@ProviderFor(onrampChains)
final onrampChainsProvider =
    AutoDisposeFutureProvider<List<OnRampChain>>.internal(
  onrampChains,
  name: r'onrampChainsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$onrampChainsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnrampChainsRef = AutoDisposeFutureProviderRef<List<OnRampChain>>;
String _$onrampTokensHash() => r'1dcfab2e7885ed236af28463a7947fc78a7eb292';

/// See also [onrampTokens].
@ProviderFor(onrampTokens)
final onrampTokensProvider =
    AutoDisposeFutureProvider<List<OnRampToken>>.internal(
  onrampTokens,
  name: r'onrampTokensProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$onrampTokensHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnrampTokensRef = AutoDisposeFutureProviderRef<List<OnRampToken>>;
String _$onrampTokenHash() => r'886c49c125e3a0b7775d6f840b8cfe81adcbfff2';

/// See also [onrampToken].
@ProviderFor(onrampToken)
const onrampTokenProvider = OnrampTokenFamily();

/// See also [onrampToken].
class OnrampTokenFamily extends Family<AsyncValue<OnRampToken?>> {
  /// See also [onrampToken].
  const OnrampTokenFamily();

  /// See also [onrampToken].
  OnrampTokenProvider call(
    String id,
  ) {
    return OnrampTokenProvider(
      id,
    );
  }

  @override
  OnrampTokenProvider getProviderOverride(
    covariant OnrampTokenProvider provider,
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
  String? get name => r'onrampTokenProvider';
}

/// See also [onrampToken].
class OnrampTokenProvider extends AutoDisposeFutureProvider<OnRampToken?> {
  /// See also [onrampToken].
  OnrampTokenProvider(
    String id,
  ) : this._internal(
          (ref) => onrampToken(
            ref as OnrampTokenRef,
            id,
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
          id: id,
        );

  OnrampTokenProvider._internal(
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
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OnRampToken?> createElement() {
    return _OnrampTokenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnrampTokenProvider && other.id == id;
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
mixin OnrampTokenRef on AutoDisposeFutureProviderRef<OnRampToken?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _OnrampTokenProviderElement
    extends AutoDisposeFutureProviderElement<OnRampToken?> with OnrampTokenRef {
  _OnrampTokenProviderElement(super.provider);

  @override
  String get id => (origin as OnrampTokenProvider).id;
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
String _$onrampTransfersHash() => r'f1438a897518042f99358023b7562cbaf0a8fd27';

/// See also [onrampTransfers].
@ProviderFor(onrampTransfers)
final onrampTransfersProvider =
    AutoDisposeStreamProvider<List<OnRampTransfer>>.internal(
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
typedef OnrampTransfersRef = AutoDisposeStreamProviderRef<List<OnRampTransfer>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
