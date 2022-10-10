// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_category_repository.dart';

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

String $nftCategoryRepositoryHash() =>
    r'6aa05863178dfb56daec7c43e24be2f184a9aa8f';

/// See also [nftCategoryRepository].
final nftCategoryRepositoryProvider =
    AutoDisposeProvider<NFTCategoryRepository>(
  nftCategoryRepository,
  name: r'nftCategoryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $nftCategoryRepositoryHash,
);
typedef NftCategoryRepositoryRef
    = AutoDisposeProviderRef<NFTCategoryRepository>;
String $fetchNftCategoryHash() => r'0134adb09087c4c74d9d681620d8d82632b10844';

/// See also [fetchNftCategory].
class FetchNftCategoryProvider extends AutoDisposeProvider<List<NftCategory>> {
  FetchNftCategoryProvider(
    this.context,
    this.account,
  ) : super(
          (ref) => fetchNftCategory(
            ref,
            context,
            account,
          ),
          from: fetchNftCategoryProvider,
          name: r'fetchNftCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $fetchNftCategoryHash,
        );

  final BuildContext context;
  final Account account;

  @override
  bool operator ==(Object other) {
    return other is FetchNftCategoryProvider &&
        other.context == context &&
        other.account == account;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, account.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef FetchNftCategoryRef = AutoDisposeProviderRef<List<NftCategory>>;

/// See also [fetchNftCategory].
final fetchNftCategoryProvider = FetchNftCategoryFamily();

class FetchNftCategoryFamily extends Family<List<NftCategory>> {
  FetchNftCategoryFamily();

  FetchNftCategoryProvider call(
    BuildContext context,
    Account account,
  ) {
    return FetchNftCategoryProvider(
      context,
      account,
    );
  }

  @override
  AutoDisposeProvider<List<NftCategory>> getProviderOverride(
    covariant FetchNftCategoryProvider provider,
  ) {
    return call(
      provider.context,
      provider.account,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'fetchNftCategoryProvider';
}

String $getNbNFTInCategoryHash() => r'd6a10ab3c92901d740ca2d374f5275fcf47ac985';

/// See also [getNbNFTInCategory].
class GetNbNFTInCategoryProvider extends AutoDisposeProvider<int> {
  GetNbNFTInCategoryProvider({
    required this.account,
    required this.categoryNftIndex,
  }) : super(
          (ref) => getNbNFTInCategory(
            ref,
            account: account,
            categoryNftIndex: categoryNftIndex,
          ),
          from: getNbNFTInCategoryProvider,
          name: r'getNbNFTInCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $getNbNFTInCategoryHash,
        );

  final Account account;
  final int categoryNftIndex;

  @override
  bool operator ==(Object other) {
    return other is GetNbNFTInCategoryProvider &&
        other.account == account &&
        other.categoryNftIndex == categoryNftIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, account.hashCode);
    hash = _SystemHash.combine(hash, categoryNftIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef GetNbNFTInCategoryRef = AutoDisposeProviderRef<int>;

/// See also [getNbNFTInCategory].
final getNbNFTInCategoryProvider = GetNbNFTInCategoryFamily();

class GetNbNFTInCategoryFamily extends Family<int> {
  GetNbNFTInCategoryFamily();

  GetNbNFTInCategoryProvider call({
    required Account account,
    required int categoryNftIndex,
  }) {
    return GetNbNFTInCategoryProvider(
      account: account,
      categoryNftIndex: categoryNftIndex,
    );
  }

  @override
  AutoDisposeProvider<int> getProviderOverride(
    covariant GetNbNFTInCategoryProvider provider,
  ) {
    return call(
      account: provider.account,
      categoryNftIndex: provider.categoryNftIndex,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'getNbNFTInCategoryProvider';
}
