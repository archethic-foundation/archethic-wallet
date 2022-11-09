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

String $_accountHash() => r'3ad56afffd864e0b5be2faf9af694b0dec0db458';

/// See also [_account].
class _AccountProvider extends AutoDisposeFutureProvider<Account> {
  _AccountProvider(
    this.name,
  ) : super(
          (ref) => _account(
            ref,
            name,
          ),
          from: _accountProvider,
          name: r'_accountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_accountHash,
        );

  final String name;

  @override
  bool operator ==(Object other) {
    return other is _AccountProvider && other.name == name;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, name.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _AccountRef = AutoDisposeFutureProviderRef<Account>;

/// See also [_account].
final _accountProvider = _AccountFamily();

class _AccountFamily extends Family<AsyncValue<Account>> {
  _AccountFamily();

  _AccountProvider call(
    String name,
  ) {
    return _AccountProvider(
      name,
    );
  }

  @override
  AutoDisposeFutureProvider<Account> getProviderOverride(
    covariant _AccountProvider provider,
  ) {
    return call(
      provider.name,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_accountProvider';
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
String $_AccountsNotifierHash() => r'ecab9635938445913bad331d0f4cb24140da1d59';

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
    r'd69ab61b59b433762ceb204f0f5b53a56b60ffe9';

/// See also [_SelectedAccountNotifier].
final _selectedAccountNotifierProvider =
    AutoDisposeNotifierProvider<_SelectedAccountNotifier, Account?>(
  _SelectedAccountNotifier.new,
  name: r'_selectedAccountNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_SelectedAccountNotifierHash,
);
typedef _SelectedAccountNotifierRef = AutoDisposeNotifierProviderRef<Account?>;

abstract class _$SelectedAccountNotifier extends AutoDisposeNotifier<Account?> {
  @override
  Account? build();
}
