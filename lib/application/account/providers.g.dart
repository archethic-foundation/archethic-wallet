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

String _$_sortedAccountsHash() => r'890718a09341a058dd459b77bc4e8472b7a6bd92';

/// See also [_sortedAccounts].
final _sortedAccountsProvider = AutoDisposeFutureProvider<List<Account>>(
  _sortedAccounts,
  name: r'_sortedAccountsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$_sortedAccountsHash,
);
typedef _SortedAccountsRef = AutoDisposeFutureProviderRef<List<Account>>;
String _$_AccountsNotifierHash() => r'325f4d06b122c7eadd0d8dcdf10d4084307ca5f4';

/// See also [_AccountsNotifier].
final _accountsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<_AccountsNotifier, List<Account>>(
  _AccountsNotifier.new,
  name: r'_accountsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$_AccountsNotifierHash,
);
typedef _AccountsNotifierRef
    = AutoDisposeAsyncNotifierProviderRef<List<Account>>;

abstract class _$AccountsNotifier
    extends AutoDisposeAsyncNotifier<List<Account>> {
  @override
  FutureOr<List<Account>> build();
}

String _$_SelectedAccountNotifierHash() =>
    r'e9781499f376aec00dfef02eb652a216c5630ebe';

/// See also [_SelectedAccountNotifier].
final _selectedAccountNotifierProvider =
    AutoDisposeAsyncNotifierProvider<_SelectedAccountNotifier, Account?>(
  _SelectedAccountNotifier.new,
  name: r'_selectedAccountNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$_SelectedAccountNotifierHash,
);
typedef _SelectedAccountNotifierRef
    = AutoDisposeAsyncNotifierProviderRef<Account?>;

abstract class _$SelectedAccountNotifier
    extends AutoDisposeAsyncNotifier<Account?> {
  @override
  FutureOr<Account?> build();
}

String _$_selectedAccountNameHash() =>
    r'ed92e55365a9b6566dfdec965483b9f54e6bcaf3';

/// See also [_selectedAccountName].
final _selectedAccountNameProvider = AutoDisposeFutureProvider<String?>(
  _selectedAccountName,
  name: r'_selectedAccountNameProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$_selectedAccountNameHash,
);
typedef _SelectedAccountNameRef = AutoDisposeFutureProviderRef<String?>;
