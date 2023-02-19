// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

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

String $_sortedAccountsHash() => r'890718a09341a058dd459b77bc4e8472b7a6bd92';

/// See also [_sortedAccounts].
final _sortedAccountsProvider = AutoDisposeFutureProvider<List<Account>>(
  _sortedAccounts,
  name: r'_sortedAccountsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_sortedAccountsHash,
);
typedef _SortedAccountsRef = AutoDisposeFutureProviderRef<List<Account>>;
String $_AccountsNotifierHash() => r'033b8b933a00f33c59ee317f517ffa0d04f911d0';

/// See also [_AccountsNotifier].
final _accountsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<_AccountsNotifier, List<Account>>(
  _AccountsNotifier.new,
  name: r'_accountsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_AccountsNotifierHash,
);
typedef _AccountsNotifierRef
    = AutoDisposeAsyncNotifierProviderRef<List<Account>>;

abstract class _$AccountsNotifier
    extends AutoDisposeAsyncNotifier<List<Account>> {
  @override
  FutureOr<List<Account>> build();
}

String $_SelectedAccountNotifierHash() =>
    r'92372abd1516b94f62efe537520f0b03e5ff581f';

/// See also [_SelectedAccountNotifier].
final _selectedAccountNotifierProvider =
    AutoDisposeAsyncNotifierProvider<_SelectedAccountNotifier, Account?>(
  _SelectedAccountNotifier.new,
  name: r'_selectedAccountNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_SelectedAccountNotifierHash,
);
typedef _SelectedAccountNotifierRef
    = AutoDisposeAsyncNotifierProviderRef<Account?>;

abstract class _$SelectedAccountNotifier
    extends AutoDisposeAsyncNotifier<Account?> {
  @override
  FutureOr<Account?> build();
}

String $_selectedAccountNameHash() =>
    r'ed92e55365a9b6566dfdec965483b9f54e6bcaf3';

/// See also [_selectedAccountName].
final _selectedAccountNameProvider = AutoDisposeFutureProvider<String?>(
  _selectedAccountName,
  name: r'_selectedAccountNameProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_selectedAccountNameHash,
);
typedef _SelectedAccountNameRef = AutoDisposeFutureProviderRef<String?>;
