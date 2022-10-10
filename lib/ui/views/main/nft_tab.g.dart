// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_tab.dart';

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

String $fetchNftCategoryHash() => r'3154ca2a6c117268b45fbdda322c1f8a26ab38bf';

/// See also [fetchNftCategory].
class FetchNftCategoryProvider extends AutoDisposeProvider<List<NftCategory>> {
  FetchNftCategoryProvider({
    required this.account,
    required this.context,
  }) : super(
          (ref) => fetchNftCategory(
            ref,
            account: account,
            context: context,
          ),
          from: fetchNftCategoryProvider,
          name: r'fetchNftCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $fetchNftCategoryHash,
        );

  final Account account;
  final BuildContext context;

  @override
  bool operator ==(Object other) {
    return other is FetchNftCategoryProvider &&
        other.account == account &&
        other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, account.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef FetchNftCategoryRef = AutoDisposeProviderRef<List<NftCategory>>;

/// See also [fetchNftCategory].
final fetchNftCategoryProvider = FetchNftCategoryFamily();

class FetchNftCategoryFamily extends Family<List<NftCategory>> {
  FetchNftCategoryFamily();

  FetchNftCategoryProvider call({
    required Account account,
    required BuildContext context,
  }) {
    return FetchNftCategoryProvider(
      account: account,
      context: context,
    );
  }

  @override
  AutoDisposeProvider<List<NftCategory>> getProviderOverride(
    covariant FetchNftCategoryProvider provider,
  ) {
    return call(
      account: provider.account,
      context: provider.context,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'fetchNftCategoryProvider';
}
