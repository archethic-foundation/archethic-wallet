// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

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

String $_recentTransactionsHash() =>
    r'794db0bda5288da921d3d6d2e44d1f649ef87a06';

/// See also [_recentTransactions].
class _RecentTransactionsProvider
    extends AutoDisposeFutureProvider<List<RecentTransaction>> {
  _RecentTransactionsProvider({
    required this.pagingAddress,
  }) : super(
          (ref) => _recentTransactions(
            ref,
            pagingAddress: pagingAddress,
          ),
          from: _recentTransactionsProvider,
          name: r'_recentTransactionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_recentTransactionsHash,
        );

  final String pagingAddress;

  @override
  bool operator ==(Object other) {
    return other is _RecentTransactionsProvider &&
        other.pagingAddress == pagingAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pagingAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _RecentTransactionsRef
    = AutoDisposeFutureProviderRef<List<RecentTransaction>>;

/// See also [_recentTransactions].
final _recentTransactionsProvider = _RecentTransactionsFamily();

class _RecentTransactionsFamily
    extends Family<AsyncValue<List<RecentTransaction>>> {
  _RecentTransactionsFamily();

  _RecentTransactionsProvider call({
    required String pagingAddress,
  }) {
    return _RecentTransactionsProvider(
      pagingAddress: pagingAddress,
    );
  }

  @override
  AutoDisposeFutureProvider<List<RecentTransaction>> getProviderOverride(
    covariant _RecentTransactionsProvider provider,
  ) {
    return call(
      pagingAddress: provider.pagingAddress,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_recentTransactionsProvider';
}

String $_archethicWalletKeychainHash() =>
    r'7b944e97107af41e54c05f9f8e86e05bb2b75bfe';

/// See also [_archethicWalletKeychain].
final _archethicWalletKeychainProvider = AutoDisposeFutureProvider<Keychain?>(
  _archethicWalletKeychain,
  name: r'_archethicWalletKeychainProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_archethicWalletKeychainHash,
);
typedef _ArchethicWalletKeychainRef = AutoDisposeFutureProviderRef<Keychain?>;
