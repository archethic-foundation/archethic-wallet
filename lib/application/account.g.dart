// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

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

String $_AccountsNotifierHash() => r'91c85b834910bdbd4074074355570d4acd246fec';

/// See also [_AccountsNotifier].
final _accountsNotifierProvider =
    NotifierProvider<_AccountsNotifier, List<Account>>(
  _AccountsNotifier.new,
  name: r'_accountsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_AccountsNotifierHash,
);
typedef _AccountsNotifierRef = NotifierProviderRef<List<Account>>;

abstract class _$AccountsNotifier extends Notifier<List<Account>> {
  @override
  List<Account> build();
}

String $_selectedAccountHash() => r'dd8c0fd844f0eacd4313d8f74a75883dbf30183d';

/// See also [_selectedAccount].
final _selectedAccountProvider = AutoDisposeProvider<Account?>(
  _selectedAccount,
  name: r'_selectedAccountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_selectedAccountHash,
);
typedef _SelectedAccountRef = AutoDisposeProviderRef<Account?>;
String $_sortedAccountsHash() => r'af89aa30403924cdfaf4bb74f0c9932044637e19';

/// See also [_sortedAccounts].
final _sortedAccountsProvider = AutoDisposeProvider<List<Account>>(
  _sortedAccounts,
  name: r'_sortedAccountsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_sortedAccountsHash,
);
typedef _SortedAccountsRef = AutoDisposeProviderRef<List<Account>>;
