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

String _$selectedAccountNameHash() =>
    r'63e95818e7ab3f93de3fb44ee555a20e0757516d';

/// See also [_selectedAccountName].
@ProviderFor(_selectedAccountName)
final _selectedAccountNameProvider =
    AutoDisposeFutureProvider<String?>.internal(
  _selectedAccountName,
  name: r'_selectedAccountNameProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedAccountNameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _SelectedAccountNameRef = AutoDisposeFutureProviderRef<String?>;
String _$accountsNotifierHash() => r'033b8b933a00f33c59ee317f517ffa0d04f911d0';

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
String _$selectedAccountNotifierHash() =>
    r'd0cba50e7938424a93e6afb396e066dbab2dee24';

/// See also [_SelectedAccountNotifier].
@ProviderFor(_SelectedAccountNotifier)
final _selectedAccountNotifierProvider = AutoDisposeAsyncNotifierProvider<
    _SelectedAccountNotifier, Account?>.internal(
  _SelectedAccountNotifier.new,
  name: r'_selectedAccountNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedAccountNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedAccountNotifier = AutoDisposeAsyncNotifier<Account?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
