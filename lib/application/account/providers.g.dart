// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
String _$selectedAccountNameHash() =>
    r'ed92e55365a9b6566dfdec965483b9f54e6bcaf3';

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
String _$selectedAccountNameDisplayedHash() =>
    r'17e4d2e89e9e50b0887df22fb1ca57ea8155479d';

/// See also [_selectedAccountNameDisplayed].
@ProviderFor(_selectedAccountNameDisplayed)
final _selectedAccountNameDisplayedProvider =
    AutoDisposeFutureProvider<String?>.internal(
  _selectedAccountNameDisplayed,
  name: r'_selectedAccountNameDisplayedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedAccountNameDisplayedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _SelectedAccountNameDisplayedRef
    = AutoDisposeFutureProviderRef<String?>;
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
    r'92372abd1516b94f62efe537520f0b03e5ff581f';

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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
