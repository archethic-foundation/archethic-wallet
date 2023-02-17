// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nftRepositoryHash() => r'c16cc640004fbaf88bbe6c50e643bbe5b8c577ed';

/// See also [_nftRepository].
@ProviderFor(_nftRepository)
final _nftRepositoryProvider = AutoDisposeProvider<NFTRepository>.internal(
  _nftRepository,
  name: r'_nftRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$nftRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _NftRepositoryRef = AutoDisposeProviderRef<NFTRepository>;
String _$getNFTHash() => r'bd8af3a8e0ab3eace21cb12d4b5fc266453014a6';

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

typedef _GetNFTRef = AutoDisposeFutureProviderRef<TokenInformations?>;

/// See also [_getNFT].
@ProviderFor(_getNFT)
const _getNFTProvider = _GetNFTFamily();

/// See also [_getNFT].
class _GetNFTFamily extends Family<AsyncValue<TokenInformations?>> {
  /// See also [_getNFT].
  const _GetNFTFamily();

  /// See also [_getNFT].
  _GetNFTProvider call(
    String address,
    KeychainServiceKeyPair keychainServiceKeyPair,
  ) {
    return _GetNFTProvider(
      address,
      keychainServiceKeyPair,
    );
  }

  @override
  _GetNFTProvider getProviderOverride(
    covariant _GetNFTProvider provider,
  ) {
    return call(
      provider.address,
      provider.keychainServiceKeyPair,
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
  String? get name => r'_getNFTProvider';
}

/// See also [_getNFT].
class _GetNFTProvider extends AutoDisposeFutureProvider<TokenInformations?> {
  /// See also [_getNFT].
  _GetNFTProvider(
    this.address,
    this.keychainServiceKeyPair,
  ) : super.internal(
          (ref) => _getNFT(
            ref,
            address,
            keychainServiceKeyPair,
          ),
          from: _getNFTProvider,
          name: r'_getNFTProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getNFTHash,
          dependencies: _GetNFTFamily._dependencies,
          allTransitiveDependencies: _GetNFTFamily._allTransitiveDependencies,
        );

  final String address;
  final KeychainServiceKeyPair keychainServiceKeyPair;

  @override
  bool operator ==(Object other) {
    return other is _GetNFTProvider &&
        other.address == address &&
        other.keychainServiceKeyPair == keychainServiceKeyPair;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, keychainServiceKeyPair.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
