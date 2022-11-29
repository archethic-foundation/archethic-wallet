// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

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

String $_nftRepositoryHash() => r'16d6cf6b0939dbe4652c0e77ebfcf83d482c25a8';

/// See also [_nftRepository].
final _nftRepositoryProvider = Provider<NFTRepository>(
  _nftRepository,
  name: r'_nftRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_nftRepositoryHash,
);
typedef _NftRepositoryRef = ProviderRef<NFTRepository>;
String $_getNFTHash() => r'029894ec33279e2a6f2c6c20d0c2c100ca702c0b';

/// See also [_getNFT].
class _GetNFTProvider extends FutureProvider<TokenInformations?> {
  _GetNFTProvider(
    this.address,
    this.seed,
    this.name,
  ) : super(
          (ref) => _getNFT(
            ref,
            address,
            seed,
            name,
          ),
          from: _getNFTProvider,
          name: r'_getNFTProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_getNFTHash,
        );

  final String address;
  final String seed;
  final String name;

  @override
  bool operator ==(Object other) {
    return other is _GetNFTProvider &&
        other.address == address &&
        other.seed == seed &&
        other.name == name;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, seed.hashCode);
    hash = _SystemHash.combine(hash, name.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _GetNFTRef = FutureProviderRef<TokenInformations?>;

/// See also [_getNFT].
final _getNFTProvider = _GetNFTFamily();

class _GetNFTFamily extends Family<AsyncValue<TokenInformations?>> {
  _GetNFTFamily();

  _GetNFTProvider call(
    String address,
    String seed,
    String name,
  ) {
    return _GetNFTProvider(
      address,
      seed,
      name,
    );
  }

  @override
  FutureProvider<TokenInformations?> getProviderOverride(
    covariant _GetNFTProvider provider,
  ) {
    return call(
      provider.address,
      provider.seed,
      provider.name,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_getNFTProvider';
}
