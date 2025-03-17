// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banxa.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isBanxaWebviewSupportedHash() =>
    r'dc6594e93b9b9683c7e1ec393a3b1498c9c855d4';

/// See also [isBanxaWebviewSupported].
@ProviderFor(isBanxaWebviewSupported)
final isBanxaWebviewSupportedProvider = AutoDisposeProvider<bool>.internal(
  isBanxaWebviewSupported,
  name: r'isBanxaWebviewSupportedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isBanxaWebviewSupportedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsBanxaWebviewSupportedRef = AutoDisposeProviderRef<bool>;
String _$banxaWebpageUriHash() => r'49fd1bb4f3111c95719e1f49c44b7c32be035f72';

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

/// See also [banxaWebpageUri].
@ProviderFor(banxaWebpageUri)
const banxaWebpageUriProvider = BanxaWebpageUriFamily();

/// See also [banxaWebpageUri].
class BanxaWebpageUriFamily extends Family<Uri> {
  /// See also [banxaWebpageUri].
  const BanxaWebpageUriFamily();

  /// See also [banxaWebpageUri].
  BanxaWebpageUriProvider call({
    required String tokenId,
    required String chainId,
    required String depositAddress,
  }) {
    return BanxaWebpageUriProvider(
      tokenId: tokenId,
      chainId: chainId,
      depositAddress: depositAddress,
    );
  }

  @override
  BanxaWebpageUriProvider getProviderOverride(
    covariant BanxaWebpageUriProvider provider,
  ) {
    return call(
      tokenId: provider.tokenId,
      chainId: provider.chainId,
      depositAddress: provider.depositAddress,
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
  String? get name => r'banxaWebpageUriProvider';
}

/// See also [banxaWebpageUri].
class BanxaWebpageUriProvider extends AutoDisposeProvider<Uri> {
  /// See also [banxaWebpageUri].
  BanxaWebpageUriProvider({
    required String tokenId,
    required String chainId,
    required String depositAddress,
  }) : this._internal(
          (ref) => banxaWebpageUri(
            ref as BanxaWebpageUriRef,
            tokenId: tokenId,
            chainId: chainId,
            depositAddress: depositAddress,
          ),
          from: banxaWebpageUriProvider,
          name: r'banxaWebpageUriProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$banxaWebpageUriHash,
          dependencies: BanxaWebpageUriFamily._dependencies,
          allTransitiveDependencies:
              BanxaWebpageUriFamily._allTransitiveDependencies,
          tokenId: tokenId,
          chainId: chainId,
          depositAddress: depositAddress,
        );

  BanxaWebpageUriProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tokenId,
    required this.chainId,
    required this.depositAddress,
  }) : super.internal();

  final String tokenId;
  final String chainId;
  final String depositAddress;

  @override
  Override overrideWith(
    Uri Function(BanxaWebpageUriRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BanxaWebpageUriProvider._internal(
        (ref) => create(ref as BanxaWebpageUriRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tokenId: tokenId,
        chainId: chainId,
        depositAddress: depositAddress,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Uri> createElement() {
    return _BanxaWebpageUriProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BanxaWebpageUriProvider &&
        other.tokenId == tokenId &&
        other.chainId == chainId &&
        other.depositAddress == depositAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tokenId.hashCode);
    hash = _SystemHash.combine(hash, chainId.hashCode);
    hash = _SystemHash.combine(hash, depositAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BanxaWebpageUriRef on AutoDisposeProviderRef<Uri> {
  /// The parameter `tokenId` of this provider.
  String get tokenId;

  /// The parameter `chainId` of this provider.
  String get chainId;

  /// The parameter `depositAddress` of this provider.
  String get depositAddress;
}

class _BanxaWebpageUriProviderElement extends AutoDisposeProviderElement<Uri>
    with BanxaWebpageUriRef {
  _BanxaWebpageUriProviderElement(super.provider);

  @override
  String get tokenId => (origin as BanxaWebpageUriProvider).tokenId;
  @override
  String get chainId => (origin as BanxaWebpageUriProvider).chainId;
  @override
  String get depositAddress =>
      (origin as BanxaWebpageUriProvider).depositAddress;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
