// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_with_crypto_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onrampTokenDisplayDataHash() =>
    r'9782b709c1184ff7e5ae1c78b146b7d939970ff6';

/// See also [onrampTokenDisplayData].
@ProviderFor(onrampTokenDisplayData)
final onrampTokenDisplayDataProvider =
    AutoDisposeFutureProvider<List<OnRampTokenDisplayData>>.internal(
  onrampTokenDisplayData,
  name: r'onrampTokenDisplayDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onrampTokenDisplayDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnrampTokenDisplayDataRef
    = AutoDisposeFutureProviderRef<List<OnRampTokenDisplayData>>;
String _$onrampTokenAvailableForChainHash() =>
    r'ad36ad8a2e89d50043cf3c434b1fdf38d2c878ff';

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

/// See also [onrampTokenAvailableForChain].
@ProviderFor(onrampTokenAvailableForChain)
const onrampTokenAvailableForChainProvider =
    OnrampTokenAvailableForChainFamily();

/// See also [onrampTokenAvailableForChain].
class OnrampTokenAvailableForChainFamily extends Family<AsyncValue<bool>> {
  /// See also [onrampTokenAvailableForChain].
  const OnrampTokenAvailableForChainFamily();

  /// See also [onrampTokenAvailableForChain].
  OnrampTokenAvailableForChainProvider call(
    String tokenId,
    String chainId,
  ) {
    return OnrampTokenAvailableForChainProvider(
      tokenId,
      chainId,
    );
  }

  @override
  OnrampTokenAvailableForChainProvider getProviderOverride(
    covariant OnrampTokenAvailableForChainProvider provider,
  ) {
    return call(
      provider.tokenId,
      provider.chainId,
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
  String? get name => r'onrampTokenAvailableForChainProvider';
}

/// See also [onrampTokenAvailableForChain].
class OnrampTokenAvailableForChainProvider
    extends AutoDisposeFutureProvider<bool> {
  /// See also [onrampTokenAvailableForChain].
  OnrampTokenAvailableForChainProvider(
    String tokenId,
    String chainId,
  ) : this._internal(
          (ref) => onrampTokenAvailableForChain(
            ref as OnrampTokenAvailableForChainRef,
            tokenId,
            chainId,
          ),
          from: onrampTokenAvailableForChainProvider,
          name: r'onrampTokenAvailableForChainProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onrampTokenAvailableForChainHash,
          dependencies: OnrampTokenAvailableForChainFamily._dependencies,
          allTransitiveDependencies:
              OnrampTokenAvailableForChainFamily._allTransitiveDependencies,
          tokenId: tokenId,
          chainId: chainId,
        );

  OnrampTokenAvailableForChainProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tokenId,
    required this.chainId,
  }) : super.internal();

  final String tokenId;
  final String chainId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(OnrampTokenAvailableForChainRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OnrampTokenAvailableForChainProvider._internal(
        (ref) => create(ref as OnrampTokenAvailableForChainRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tokenId: tokenId,
        chainId: chainId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _OnrampTokenAvailableForChainProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnrampTokenAvailableForChainProvider &&
        other.tokenId == tokenId &&
        other.chainId == chainId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tokenId.hashCode);
    hash = _SystemHash.combine(hash, chainId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnrampTokenAvailableForChainRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `tokenId` of this provider.
  String get tokenId;

  /// The parameter `chainId` of this provider.
  String get chainId;
}

class _OnrampTokenAvailableForChainProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with OnrampTokenAvailableForChainRef {
  _OnrampTokenAvailableForChainProviderElement(super.provider);

  @override
  String get tokenId =>
      (origin as OnrampTokenAvailableForChainProvider).tokenId;
  @override
  String get chainId =>
      (origin as OnrampTokenAvailableForChainProvider).chainId;
}

String _$buyWithCryptoFormHash() => r'a3dd2702aa0eccea27c350fd7a844383bdf16cc7';

/// See also [BuyWithCryptoForm].
@ProviderFor(BuyWithCryptoForm)
final buyWithCryptoFormProvider = AutoDisposeAsyncNotifierProvider<
    BuyWithCryptoForm, BuyWithCryptoFormState>.internal(
  BuyWithCryptoForm.new,
  name: r'buyWithCryptoFormProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$buyWithCryptoFormHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BuyWithCryptoForm = AutoDisposeAsyncNotifier<BuyWithCryptoFormState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
