// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_category.dart';

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

String _$_nftCategoryRepositoryHash() =>
    r'a38f8405031299f092dbef55597261545db4103c';

/// See also [_nftCategoryRepository].
final _nftCategoryRepositoryProvider =
    AutoDisposeProvider<NFTCategoryRepository>(
  _nftCategoryRepository,
  name: r'_nftCategoryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$_nftCategoryRepositoryHash,
);
typedef _NftCategoryRepositoryRef
    = AutoDisposeProviderRef<NFTCategoryRepository>;
String _$_selectedAccountNftCategoriesHash() =>
    r'14c939211bff7bc3c39aedd5aa134a7cac928c4f';

/// See also [_selectedAccountNftCategories].
class _SelectedAccountNftCategoriesProvider
    extends AutoDisposeFutureProvider<List<NftCategory>> {
  _SelectedAccountNftCategoriesProvider({
    required this.context,
  }) : super(
          (ref) => _selectedAccountNftCategories(
            ref,
            context: context,
          ),
          from: _selectedAccountNftCategoriesProvider,
          name: r'_selectedAccountNftCategoriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$_selectedAccountNftCategoriesHash,
        );

  final BuildContext context;

  @override
  bool operator ==(Object other) {
    return other is _SelectedAccountNftCategoriesProvider &&
        other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _SelectedAccountNftCategoriesRef
    = AutoDisposeFutureProviderRef<List<NftCategory>>;

/// See also [_selectedAccountNftCategories].
final _selectedAccountNftCategoriesProvider =
    _SelectedAccountNftCategoriesFamily();

class _SelectedAccountNftCategoriesFamily
    extends Family<AsyncValue<List<NftCategory>>> {
  _SelectedAccountNftCategoriesFamily();

  _SelectedAccountNftCategoriesProvider call({
    required BuildContext context,
  }) {
    return _SelectedAccountNftCategoriesProvider(
      context: context,
    );
  }

  @override
  AutoDisposeFutureProvider<List<NftCategory>> getProviderOverride(
    covariant _SelectedAccountNftCategoriesProvider provider,
  ) {
    return call(
      context: provider.context,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_selectedAccountNftCategoriesProvider';
}

String _$_fetchNftCategoryHash() => r'cd908e74d75cc876b704d525b019fcee83b43504';

/// See also [_fetchNftCategory].
class _FetchNftCategoryProvider extends AutoDisposeProvider<List<NftCategory>> {
  _FetchNftCategoryProvider({
    required this.context,
    required this.account,
  }) : super(
          (ref) => _fetchNftCategory(
            ref,
            context: context,
            account: account,
          ),
          from: _fetchNftCategoryProvider,
          name: r'_fetchNftCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$_fetchNftCategoryHash,
        );

  final BuildContext context;
  final Account account;

  @override
  bool operator ==(Object other) {
    return other is _FetchNftCategoryProvider &&
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

typedef _FetchNftCategoryRef = AutoDisposeProviderRef<List<NftCategory>>;

/// See also [_fetchNftCategory].
final _fetchNftCategoryProvider = _FetchNftCategoryFamily();

class _FetchNftCategoryFamily extends Family<List<NftCategory>> {
  _FetchNftCategoryFamily();

  _FetchNftCategoryProvider call({
    required BuildContext context,
    required Account account,
  }) {
    return _FetchNftCategoryProvider(
      context: context,
      account: account,
    );
  }

  @override
  AutoDisposeProvider<List<NftCategory>> getProviderOverride(
    covariant _FetchNftCategoryProvider provider,
  ) {
    return call(
      context: provider.context,
      account: provider.account,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_fetchNftCategoryProvider';
}

String _$_getNbNFTInCategoryHash() =>
    r'6015ccc4a96e15a7d434528af26f7111386d7d15';

/// See also [_getNbNFTInCategory].
class _GetNbNFTInCategoryProvider extends AutoDisposeProvider<int> {
  _GetNbNFTInCategoryProvider({
    required this.account,
    required this.categoryNftIndex,
  }) : super(
          (ref) => _getNbNFTInCategory(
            ref,
            account: account,
            categoryNftIndex: categoryNftIndex,
          ),
          from: _getNbNFTInCategoryProvider,
          name: r'_getNbNFTInCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$_getNbNFTInCategoryHash,
        );

  final Account account;
  final int categoryNftIndex;

  @override
  bool operator ==(Object other) {
    return other is _GetNbNFTInCategoryProvider &&
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

typedef _GetNbNFTInCategoryRef = AutoDisposeProviderRef<int>;

/// See also [_getNbNFTInCategory].
final _getNbNFTInCategoryProvider = _GetNbNFTInCategoryFamily();

class _GetNbNFTInCategoryFamily extends Family<int> {
  _GetNbNFTInCategoryFamily();

  _GetNbNFTInCategoryProvider call({
    required Account account,
    required int categoryNftIndex,
  }) {
    return _GetNbNFTInCategoryProvider(
      account: account,
      categoryNftIndex: categoryNftIndex,
    );
  }

  @override
  AutoDisposeProvider<int> getProviderOverride(
    covariant _GetNbNFTInCategoryProvider provider,
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
  String? get name => r'_getNbNFTInCategoryProvider';
}

String _$_getListByDefaultHash() => r'8538d843366645b4a7c60a792cc8bf4f5af89e64';

/// See also [_getListByDefault].
class _GetListByDefaultProvider extends AutoDisposeProvider<List<NftCategory>> {
  _GetListByDefaultProvider({
    required this.context,
  }) : super(
          (ref) => _getListByDefault(
            ref,
            context: context,
          ),
          from: _getListByDefaultProvider,
          name: r'_getListByDefaultProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$_getListByDefaultHash,
        );

  final BuildContext context;

  @override
  bool operator ==(Object other) {
    return other is _GetListByDefaultProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _GetListByDefaultRef = AutoDisposeProviderRef<List<NftCategory>>;

/// See also [_getListByDefault].
final _getListByDefaultProvider = _GetListByDefaultFamily();

class _GetListByDefaultFamily extends Family<List<NftCategory>> {
  _GetListByDefaultFamily();

  _GetListByDefaultProvider call({
    required BuildContext context,
  }) {
    return _GetListByDefaultProvider(
      context: context,
    );
  }

  @override
  AutoDisposeProvider<List<NftCategory>> getProviderOverride(
    covariant _GetListByDefaultProvider provider,
  ) {
    return call(
      context: provider.context,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_getListByDefaultProvider';
}

String _$_updateNftCategoryListHash() =>
    r'c3d71c277aee70da60524f024c6de9d48a60288c';

/// See also [_listNFTCategoryHidden].
class _ListNFTCategoryHiddenProvider
    extends AutoDisposeProvider<List<NftCategory>> {
  _ListNFTCategoryHiddenProvider({
    required this.context,
  }) : super(
          (ref) => _listNFTCategoryHidden(
            ref,
            context: context,
          ),
          from: _listNFTCategoryHiddenProvider,
          name: r'_listNFTCategoryHiddenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$_updateNftCategoryListHash,
        );

  final BuildContext context;

  @override
  bool operator ==(Object other) {
    return other is _ListNFTCategoryHiddenProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _ListNFTCategoryHiddenRef = AutoDisposeProviderRef<List<NftCategory>>;

/// See also [_listNFTCategoryHidden].
final _listNFTCategoryHiddenProvider = _ListNFTCategoryHiddenFamily();

class _ListNFTCategoryHiddenFamily extends Family<List<NftCategory>> {
  _ListNFTCategoryHiddenFamily();

  _ListNFTCategoryHiddenProvider call({
    required BuildContext context,
  }) {
    return _ListNFTCategoryHiddenProvider(
      context: context,
    );
  }

  @override
  AutoDisposeProvider<List<NftCategory>> getProviderOverride(
    covariant _ListNFTCategoryHiddenProvider provider,
  ) {
    return call(
      context: provider.context,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_listNFTCategoryHiddenProvider';
}

String _$_getDescriptionHeaderHash() =>
    r'185dffe43711a9f602f89b67628173a12657f14a';

/// See also [_getDescriptionHeader].
class _GetDescriptionHeaderProvider extends AutoDisposeProvider<String> {
  _GetDescriptionHeaderProvider({
    required this.context,
    required this.id,
  }) : super(
          (ref) => _getDescriptionHeader(
            ref,
            context: context,
            id: id,
          ),
          from: _getDescriptionHeaderProvider,
          name: r'_getDescriptionHeaderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$_getDescriptionHeaderHash,
        );

  final BuildContext context;
  final int id;

  @override
  bool operator ==(Object other) {
    return other is _GetDescriptionHeaderProvider &&
        other.context == context &&
        other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _GetDescriptionHeaderRef = AutoDisposeProviderRef<String>;

/// See also [_getDescriptionHeader].
final _getDescriptionHeaderProvider = _GetDescriptionHeaderFamily();

class _GetDescriptionHeaderFamily extends Family<String> {
  _GetDescriptionHeaderFamily();

  _GetDescriptionHeaderProvider call({
    required BuildContext context,
    required int id,
  }) {
    return _GetDescriptionHeaderProvider(
      context: context,
      id: id,
    );
  }

  @override
  AutoDisposeProvider<String> getProviderOverride(
    covariant _GetDescriptionHeaderProvider provider,
  ) {
    return call(
      context: provider.context,
      id: provider.id,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_getDescriptionHeaderProvider';
}
