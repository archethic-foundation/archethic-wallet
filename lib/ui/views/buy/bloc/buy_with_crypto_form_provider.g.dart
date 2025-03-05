// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_with_crypto_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onrampTokenDisplayDataHash() =>
    r'2bd5397e94b8de307245531ffdb40e0a51f94f92';

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
String _$onrampTokenFromDisplayDataHash() =>
    r'44e4cf0bc673d297a25001112f882146d284d737';

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

/// See also [onrampTokenFromDisplayData].
@ProviderFor(onrampTokenFromDisplayData)
const onrampTokenFromDisplayDataProvider = OnrampTokenFromDisplayDataFamily();

/// See also [onrampTokenFromDisplayData].
class OnrampTokenFromDisplayDataFamily
    extends Family<AsyncValue<OnRampToken?>> {
  /// See also [onrampTokenFromDisplayData].
  const OnrampTokenFromDisplayDataFamily();

  /// See also [onrampTokenFromDisplayData].
  OnrampTokenFromDisplayDataProvider call(
    ({String iconUrl, String name, String symbol}) tokenDisplayData,
    String chainId,
  ) {
    return OnrampTokenFromDisplayDataProvider(
      tokenDisplayData,
      chainId,
    );
  }

  @override
  OnrampTokenFromDisplayDataProvider getProviderOverride(
    covariant OnrampTokenFromDisplayDataProvider provider,
  ) {
    return call(
      provider.tokenDisplayData,
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
  String? get name => r'onrampTokenFromDisplayDataProvider';
}

/// See also [onrampTokenFromDisplayData].
class OnrampTokenFromDisplayDataProvider
    extends AutoDisposeFutureProvider<OnRampToken?> {
  /// See also [onrampTokenFromDisplayData].
  OnrampTokenFromDisplayDataProvider(
    ({String iconUrl, String name, String symbol}) tokenDisplayData,
    String chainId,
  ) : this._internal(
          (ref) => onrampTokenFromDisplayData(
            ref as OnrampTokenFromDisplayDataRef,
            tokenDisplayData,
            chainId,
          ),
          from: onrampTokenFromDisplayDataProvider,
          name: r'onrampTokenFromDisplayDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onrampTokenFromDisplayDataHash,
          dependencies: OnrampTokenFromDisplayDataFamily._dependencies,
          allTransitiveDependencies:
              OnrampTokenFromDisplayDataFamily._allTransitiveDependencies,
          tokenDisplayData: tokenDisplayData,
          chainId: chainId,
        );

  OnrampTokenFromDisplayDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tokenDisplayData,
    required this.chainId,
  }) : super.internal();

  final ({String iconUrl, String name, String symbol}) tokenDisplayData;
  final String chainId;

  @override
  Override overrideWith(
    FutureOr<OnRampToken?> Function(OnrampTokenFromDisplayDataRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OnrampTokenFromDisplayDataProvider._internal(
        (ref) => create(ref as OnrampTokenFromDisplayDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tokenDisplayData: tokenDisplayData,
        chainId: chainId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OnRampToken?> createElement() {
    return _OnrampTokenFromDisplayDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnrampTokenFromDisplayDataProvider &&
        other.tokenDisplayData == tokenDisplayData &&
        other.chainId == chainId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tokenDisplayData.hashCode);
    hash = _SystemHash.combine(hash, chainId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnrampTokenFromDisplayDataRef
    on AutoDisposeFutureProviderRef<OnRampToken?> {
  /// The parameter `tokenDisplayData` of this provider.
  ({String iconUrl, String name, String symbol}) get tokenDisplayData;

  /// The parameter `chainId` of this provider.
  String get chainId;
}

class _OnrampTokenFromDisplayDataProviderElement
    extends AutoDisposeFutureProviderElement<OnRampToken?>
    with OnrampTokenFromDisplayDataRef {
  _OnrampTokenFromDisplayDataProviderElement(super.provider);

  @override
  ({String iconUrl, String name, String symbol}) get tokenDisplayData =>
      (origin as OnrampTokenFromDisplayDataProvider).tokenDisplayData;
  @override
  String get chainId => (origin as OnrampTokenFromDisplayDataProvider).chainId;
}

String _$buyWithCryptoFormHash() => r'b25c60ceb1beca4f443ec7f3add06359a7758279';

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
