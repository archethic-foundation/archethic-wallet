// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountRepositoryHash() => r'afe2ee1ebe77e5b3ff7bc7e5d6941b52c0712395';

/// See also [_accountRepository].
@ProviderFor(_accountRepository)
final _accountRepositoryProvider =
    AutoDisposeProvider<AccountRepository>.internal(
  _accountRepository,
  name: r'_accountRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accountRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _AccountRepositoryRef = AutoDisposeProviderRef<AccountRepository>;
String _$sortedAccountsHash() => r'5bdc20f92e21ee900619360af880fd64f96e9317';

/// See also [_sortedAccounts].
@ProviderFor(_sortedAccounts)
final _sortedAccountsProvider =
    AutoDisposeFutureProvider<List<Account>>.internal(
  _sortedAccounts,
  name: r'_sortedAccountsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sortedAccountsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _SortedAccountsRef = AutoDisposeFutureProviderRef<List<Account>>;
String _$getAccountNFTFilteredHash() =>
    r'3cf4cd4f6bcd093a62ec7122b2b0891de539c780';

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

/// See also [_getAccountNFTFiltered].
@ProviderFor(_getAccountNFTFiltered)
const _getAccountNFTFilteredProvider = _GetAccountNFTFilteredFamily();

/// See also [_getAccountNFTFiltered].
class _GetAccountNFTFilteredFamily extends Family<List<AccountToken>> {
  /// See also [_getAccountNFTFiltered].
  const _GetAccountNFTFilteredFamily();

  /// See also [_getAccountNFTFiltered].
  _GetAccountNFTFilteredProvider call(
    Account account,
    int categoryNftIndex, {
    bool? favorite,
  }) {
    return _GetAccountNFTFilteredProvider(
      account,
      categoryNftIndex,
      favorite: favorite,
    );
  }

  @override
  _GetAccountNFTFilteredProvider getProviderOverride(
    covariant _GetAccountNFTFilteredProvider provider,
  ) {
    return call(
      provider.account,
      provider.categoryNftIndex,
      favorite: provider.favorite,
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
  String? get name => r'_getAccountNFTFilteredProvider';
}

/// See also [_getAccountNFTFiltered].
class _GetAccountNFTFilteredProvider
    extends AutoDisposeProvider<List<AccountToken>> {
  /// See also [_getAccountNFTFiltered].
  _GetAccountNFTFilteredProvider(
    Account account,
    int categoryNftIndex, {
    bool? favorite,
  }) : this._internal(
          (ref) => _getAccountNFTFiltered(
            ref as _GetAccountNFTFilteredRef,
            account,
            categoryNftIndex,
            favorite: favorite,
          ),
          from: _getAccountNFTFilteredProvider,
          name: r'_getAccountNFTFilteredProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAccountNFTFilteredHash,
          dependencies: _GetAccountNFTFilteredFamily._dependencies,
          allTransitiveDependencies:
              _GetAccountNFTFilteredFamily._allTransitiveDependencies,
          account: account,
          categoryNftIndex: categoryNftIndex,
          favorite: favorite,
        );

  _GetAccountNFTFilteredProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.account,
    required this.categoryNftIndex,
    required this.favorite,
  }) : super.internal();

  final Account account;
  final int categoryNftIndex;
  final bool? favorite;

  @override
  Override overrideWith(
    List<AccountToken> Function(_GetAccountNFTFilteredRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetAccountNFTFilteredProvider._internal(
        (ref) => create(ref as _GetAccountNFTFilteredRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        account: account,
        categoryNftIndex: categoryNftIndex,
        favorite: favorite,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<AccountToken>> createElement() {
    return _GetAccountNFTFilteredProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetAccountNFTFilteredProvider &&
        other.account == account &&
        other.categoryNftIndex == categoryNftIndex &&
        other.favorite == favorite;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, account.hashCode);
    hash = _SystemHash.combine(hash, categoryNftIndex.hashCode);
    hash = _SystemHash.combine(hash, favorite.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetAccountNFTFilteredRef on AutoDisposeProviderRef<List<AccountToken>> {
  /// The parameter `account` of this provider.
  Account get account;

  /// The parameter `categoryNftIndex` of this provider.
  int get categoryNftIndex;

  /// The parameter `favorite` of this provider.
  bool? get favorite;
}

class _GetAccountNFTFilteredProviderElement
    extends AutoDisposeProviderElement<List<AccountToken>>
    with _GetAccountNFTFilteredRef {
  _GetAccountNFTFilteredProviderElement(super.provider);

  @override
  Account get account => (origin as _GetAccountNFTFilteredProvider).account;
  @override
  int get categoryNftIndex =>
      (origin as _GetAccountNFTFilteredProvider).categoryNftIndex;
  @override
  bool? get favorite => (origin as _GetAccountNFTFilteredProvider).favorite;
}

String _$accountsRepositoryHash() =>
    r'2b5e9161faf46fa8c5fa28cb4b3985178f121543';

/// See also [_accountsRepository].
@ProviderFor(_accountsRepository)
final _accountsRepositoryProvider =
    AutoDisposeProvider<AccountLocalRepositoryInterface>.internal(
  _accountsRepository,
  name: r'_accountsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accountsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _AccountsRepositoryRef
    = AutoDisposeProviderRef<AccountLocalRepositoryInterface>;
String _$accountExistsNotifierHash() =>
    r'f0b33a3795ff3d6db808cf7c7ea485610fdceeed';

abstract class _$AccountExistsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<bool> {
  late final String name;

  FutureOr<bool> build({
    required String name,
  });
}

/// See also [_AccountExistsNotifier].
@ProviderFor(_AccountExistsNotifier)
const _accountExistsNotifierProvider = _AccountExistsNotifierFamily();

/// See also [_AccountExistsNotifier].
class _AccountExistsNotifierFamily extends Family<AsyncValue<bool>> {
  /// See also [_AccountExistsNotifier].
  const _AccountExistsNotifierFamily();

  /// See also [_AccountExistsNotifier].
  _AccountExistsNotifierProvider call({
    required String name,
  }) {
    return _AccountExistsNotifierProvider(
      name: name,
    );
  }

  @override
  _AccountExistsNotifierProvider getProviderOverride(
    covariant _AccountExistsNotifierProvider provider,
  ) {
    return call(
      name: provider.name,
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
  String? get name => r'_accountExistsNotifierProvider';
}

/// See also [_AccountExistsNotifier].
class _AccountExistsNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<_AccountExistsNotifier, bool> {
  /// See also [_AccountExistsNotifier].
  _AccountExistsNotifierProvider({
    required String name,
  }) : this._internal(
          () => _AccountExistsNotifier()..name = name,
          from: _accountExistsNotifierProvider,
          name: r'_accountExistsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$accountExistsNotifierHash,
          dependencies: _AccountExistsNotifierFamily._dependencies,
          allTransitiveDependencies:
              _AccountExistsNotifierFamily._allTransitiveDependencies,
          name: name,
        );

  _AccountExistsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.name,
  }) : super.internal();

  final String name;

  @override
  FutureOr<bool> runNotifierBuild(
    covariant _AccountExistsNotifier notifier,
  ) {
    return notifier.build(
      name: name,
    );
  }

  @override
  Override overrideWith(_AccountExistsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: _AccountExistsNotifierProvider._internal(
        () => create()..name = name,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        name: name,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<_AccountExistsNotifier, bool>
      createElement() {
    return _AccountExistsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _AccountExistsNotifierProvider && other.name == name;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, name.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _AccountExistsNotifierRef on AutoDisposeAsyncNotifierProviderRef<bool> {
  /// The parameter `name` of this provider.
  String get name;
}

class _AccountExistsNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<_AccountExistsNotifier,
        bool> with _AccountExistsNotifierRef {
  _AccountExistsNotifierProviderElement(super.provider);

  @override
  String get name => (origin as _AccountExistsNotifierProvider).name;
}

String _$accountNotifierHash() => r'c3ab8c93e137b7c9a3002dcfb240d0edcc25d751';

abstract class _$AccountNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Account?> {
  late final String name;

  FutureOr<Account?> build(
    String name,
  );
}

/// See also [_AccountNotifier].
@ProviderFor(_AccountNotifier)
const _accountNotifierProvider = _AccountNotifierFamily();

/// See also [_AccountNotifier].
class _AccountNotifierFamily extends Family<AsyncValue<Account?>> {
  /// See also [_AccountNotifier].
  const _AccountNotifierFamily();

  /// See also [_AccountNotifier].
  _AccountNotifierProvider call(
    String name,
  ) {
    return _AccountNotifierProvider(
      name,
    );
  }

  @override
  _AccountNotifierProvider getProviderOverride(
    covariant _AccountNotifierProvider provider,
  ) {
    return call(
      provider.name,
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
  String? get name => r'_accountNotifierProvider';
}

/// See also [_AccountNotifier].
class _AccountNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<_AccountNotifier, Account?> {
  /// See also [_AccountNotifier].
  _AccountNotifierProvider(
    String name,
  ) : this._internal(
          () => _AccountNotifier()..name = name,
          from: _accountNotifierProvider,
          name: r'_accountNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$accountNotifierHash,
          dependencies: _AccountNotifierFamily._dependencies,
          allTransitiveDependencies:
              _AccountNotifierFamily._allTransitiveDependencies,
          name: name,
        );

  _AccountNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.name,
  }) : super.internal();

  final String name;

  @override
  FutureOr<Account?> runNotifierBuild(
    covariant _AccountNotifier notifier,
  ) {
    return notifier.build(
      name,
    );
  }

  @override
  Override overrideWith(_AccountNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: _AccountNotifierProvider._internal(
        () => create()..name = name,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        name: name,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<_AccountNotifier, Account?>
      createElement() {
    return _AccountNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _AccountNotifierProvider && other.name == name;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, name.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _AccountNotifierRef on AutoDisposeAsyncNotifierProviderRef<Account?> {
  /// The parameter `name` of this provider.
  String get name;
}

class _AccountNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<_AccountNotifier, Account?>
    with _AccountNotifierRef {
  _AccountNotifierProviderElement(super.provider);

  @override
  String get name => (origin as _AccountNotifierProvider).name;
}

String _$accountsNotifierHash() => r'b5f45fb504840ad2e128cbf54fb57f22332d4ddf';

/// See also [_AccountsNotifier].
@ProviderFor(_AccountsNotifier)
final _accountsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<_AccountsNotifier, List<Account>>.internal(
  _AccountsNotifier.new,
  name: r'_accountsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accountsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AccountsNotifier = AutoDisposeAsyncNotifier<List<Account>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
