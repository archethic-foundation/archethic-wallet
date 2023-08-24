// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_category.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nftCategoryRepositoryHash() =>
    r'a38f8405031299f092dbef55597261545db4103c';

/// See also [_nftCategoryRepository].
@ProviderFor(_nftCategoryRepository)
final _nftCategoryRepositoryProvider =
    AutoDisposeProvider<NFTCategoryRepository>.internal(
  _nftCategoryRepository,
  name: r'_nftCategoryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$nftCategoryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _NftCategoryRepositoryRef
    = AutoDisposeProviderRef<NFTCategoryRepository>;
String _$selectedAccountNftCategoriesHash() =>
    r'14c939211bff7bc3c39aedd5aa134a7cac928c4f';

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

typedef _SelectedAccountNftCategoriesRef
    = AutoDisposeFutureProviderRef<List<NftCategory>>;

/// See also [_selectedAccountNftCategories].
@ProviderFor(_selectedAccountNftCategories)
const _selectedAccountNftCategoriesProvider =
    _SelectedAccountNftCategoriesFamily();

/// See also [_selectedAccountNftCategories].
class _SelectedAccountNftCategoriesFamily
    extends Family<AsyncValue<List<NftCategory>>> {
  /// See also [_selectedAccountNftCategories].
  const _SelectedAccountNftCategoriesFamily();

  /// See also [_selectedAccountNftCategories].
  _SelectedAccountNftCategoriesProvider call({
    required BuildContext context,
  }) {
    return _SelectedAccountNftCategoriesProvider(
      context: context,
    );
  }

  @override
  _SelectedAccountNftCategoriesProvider getProviderOverride(
    covariant _SelectedAccountNftCategoriesProvider provider,
  ) {
    return call(
      context: provider.context,
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
  String? get name => r'_selectedAccountNftCategoriesProvider';
}

/// See also [_selectedAccountNftCategories].
class _SelectedAccountNftCategoriesProvider
    extends AutoDisposeFutureProvider<List<NftCategory>> {
  /// See also [_selectedAccountNftCategories].
  _SelectedAccountNftCategoriesProvider({
    required this.context,
  }) : super.internal(
          (ref) => _selectedAccountNftCategories(
            ref,
            context: context,
          ),
          from: _selectedAccountNftCategoriesProvider,
          name: r'_selectedAccountNftCategoriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectedAccountNftCategoriesHash,
          dependencies: _SelectedAccountNftCategoriesFamily._dependencies,
          allTransitiveDependencies:
              _SelectedAccountNftCategoriesFamily._allTransitiveDependencies,
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

String _$fetchNftCategoryHash() => r'cd908e74d75cc876b704d525b019fcee83b43504';
typedef _FetchNftCategoryRef = AutoDisposeProviderRef<List<NftCategory>>;

/// See also [_fetchNftCategory].
@ProviderFor(_fetchNftCategory)
const _fetchNftCategoryProvider = _FetchNftCategoryFamily();

/// See also [_fetchNftCategory].
class _FetchNftCategoryFamily extends Family<List<NftCategory>> {
  /// See also [_fetchNftCategory].
  const _FetchNftCategoryFamily();

  /// See also [_fetchNftCategory].
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
  _FetchNftCategoryProvider getProviderOverride(
    covariant _FetchNftCategoryProvider provider,
  ) {
    return call(
      context: provider.context,
      account: provider.account,
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
  String? get name => r'_fetchNftCategoryProvider';
}

/// See also [_fetchNftCategory].
class _FetchNftCategoryProvider extends AutoDisposeProvider<List<NftCategory>> {
  /// See also [_fetchNftCategory].
  _FetchNftCategoryProvider({
    required this.context,
    required this.account,
  }) : super.internal(
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
                  : _$fetchNftCategoryHash,
          dependencies: _FetchNftCategoryFamily._dependencies,
          allTransitiveDependencies:
              _FetchNftCategoryFamily._allTransitiveDependencies,
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

String _$getNbNFTInCategoryHash() =>
    r'99a8437aa88eaa3ba56d8b6701a7dfca89a6d58f';
typedef _GetNbNFTInCategoryRef = AutoDisposeProviderRef<int>;

/// See also [_getNbNFTInCategory].
@ProviderFor(_getNbNFTInCategory)
const _getNbNFTInCategoryProvider = _GetNbNFTInCategoryFamily();

/// See also [_getNbNFTInCategory].
class _GetNbNFTInCategoryFamily extends Family<int> {
  /// See also [_getNbNFTInCategory].
  const _GetNbNFTInCategoryFamily();

  /// See also [_getNbNFTInCategory].
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
  _GetNbNFTInCategoryProvider getProviderOverride(
    covariant _GetNbNFTInCategoryProvider provider,
  ) {
    return call(
      account: provider.account,
      categoryNftIndex: provider.categoryNftIndex,
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
  String? get name => r'_getNbNFTInCategoryProvider';
}

/// See also [_getNbNFTInCategory].
class _GetNbNFTInCategoryProvider extends AutoDisposeProvider<int> {
  /// See also [_getNbNFTInCategory].
  _GetNbNFTInCategoryProvider({
    required this.account,
    required this.categoryNftIndex,
  }) : super.internal(
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
                  : _$getNbNFTInCategoryHash,
          dependencies: _GetNbNFTInCategoryFamily._dependencies,
          allTransitiveDependencies:
              _GetNbNFTInCategoryFamily._allTransitiveDependencies,
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

String _$getListByDefaultHash() => r'9512b96c85cc9b4ac7c455dd875784ae2c880d9e';
typedef _GetListByDefaultRef = AutoDisposeProviderRef<List<NftCategory>>;

/// See also [_getListByDefault].
@ProviderFor(_getListByDefault)
const _getListByDefaultProvider = _GetListByDefaultFamily();

/// See also [_getListByDefault].
class _GetListByDefaultFamily extends Family<List<NftCategory>> {
  /// See also [_getListByDefault].
  const _GetListByDefaultFamily();

  /// See also [_getListByDefault].
  _GetListByDefaultProvider call({
    required BuildContext context,
  }) {
    return _GetListByDefaultProvider(
      context: context,
    );
  }

  @override
  _GetListByDefaultProvider getProviderOverride(
    covariant _GetListByDefaultProvider provider,
  ) {
    return call(
      context: provider.context,
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
  String? get name => r'_getListByDefaultProvider';
}

/// See also [_getListByDefault].
class _GetListByDefaultProvider extends AutoDisposeProvider<List<NftCategory>> {
  /// See also [_getListByDefault].
  _GetListByDefaultProvider({
    required this.context,
  }) : super.internal(
          (ref) => _getListByDefault(
            ref,
            context: context,
          ),
          from: _getListByDefaultProvider,
          name: r'_getListByDefaultProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getListByDefaultHash,
          dependencies: _GetListByDefaultFamily._dependencies,
          allTransitiveDependencies:
              _GetListByDefaultFamily._allTransitiveDependencies,
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

String _$listNFTCategoryHiddenHash() =>
    r'ea0858e984f5a91c285cc1f97941383dd49dd4a7';
typedef _ListNFTCategoryHiddenRef = AutoDisposeProviderRef<List<NftCategory>>;

/// See also [_listNFTCategoryHidden].
@ProviderFor(_listNFTCategoryHidden)
const _listNFTCategoryHiddenProvider = _ListNFTCategoryHiddenFamily();

/// See also [_listNFTCategoryHidden].
class _ListNFTCategoryHiddenFamily extends Family<List<NftCategory>> {
  /// See also [_listNFTCategoryHidden].
  const _ListNFTCategoryHiddenFamily();

  /// See also [_listNFTCategoryHidden].
  _ListNFTCategoryHiddenProvider call({
    required BuildContext context,
  }) {
    return _ListNFTCategoryHiddenProvider(
      context: context,
    );
  }

  @override
  _ListNFTCategoryHiddenProvider getProviderOverride(
    covariant _ListNFTCategoryHiddenProvider provider,
  ) {
    return call(
      context: provider.context,
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
  String? get name => r'_listNFTCategoryHiddenProvider';
}

/// See also [_listNFTCategoryHidden].
class _ListNFTCategoryHiddenProvider
    extends AutoDisposeProvider<List<NftCategory>> {
  /// See also [_listNFTCategoryHidden].
  _ListNFTCategoryHiddenProvider({
    required this.context,
  }) : super.internal(
          (ref) => _listNFTCategoryHidden(
            ref,
            context: context,
          ),
          from: _listNFTCategoryHiddenProvider,
          name: r'_listNFTCategoryHiddenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listNFTCategoryHiddenHash,
          dependencies: _ListNFTCategoryHiddenFamily._dependencies,
          allTransitiveDependencies:
              _ListNFTCategoryHiddenFamily._allTransitiveDependencies,
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

String _$getDescriptionHeaderHash() =>
    r'185dffe43711a9f602f89b67628173a12657f14a';
typedef _GetDescriptionHeaderRef = AutoDisposeProviderRef<String>;

/// See also [_getDescriptionHeader].
@ProviderFor(_getDescriptionHeader)
const _getDescriptionHeaderProvider = _GetDescriptionHeaderFamily();

/// See also [_getDescriptionHeader].
class _GetDescriptionHeaderFamily extends Family<String> {
  /// See also [_getDescriptionHeader].
  const _GetDescriptionHeaderFamily();

  /// See also [_getDescriptionHeader].
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
  _GetDescriptionHeaderProvider getProviderOverride(
    covariant _GetDescriptionHeaderProvider provider,
  ) {
    return call(
      context: provider.context,
      id: provider.id,
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
  String? get name => r'_getDescriptionHeaderProvider';
}

/// See also [_getDescriptionHeader].
class _GetDescriptionHeaderProvider extends AutoDisposeProvider<String> {
  /// See also [_getDescriptionHeader].
  _GetDescriptionHeaderProvider({
    required this.context,
    required this.id,
  }) : super.internal(
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
                  : _$getDescriptionHeaderHash,
          dependencies: _GetDescriptionHeaderFamily._dependencies,
          allTransitiveDependencies:
              _GetDescriptionHeaderFamily._allTransitiveDependencies,
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
