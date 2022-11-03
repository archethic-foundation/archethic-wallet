// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_transactions.dart';

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

String $_RecentTransactionsNotifierHash() =>
    r'f2e7e88265ea68269525e043d782c228969b2ad3';

/// See also [_RecentTransactionsNotifier].
final _recentTransactionsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    _RecentTransactionsNotifier, List<RecentTransaction>>(
  _RecentTransactionsNotifier.new,
  name: r'_recentTransactionsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_RecentTransactionsNotifierHash,
);
typedef _RecentTransactionsNotifierRef
    = AutoDisposeAsyncNotifierProviderRef<List<RecentTransaction>>;

abstract class _$RecentTransactionsNotifier
    extends AutoDisposeAsyncNotifier<List<RecentTransaction>> {
  @override
  FutureOr<List<RecentTransaction>> build();
}

String $_remoteRepositoryHash() => r'219e1df5e6f8de3352450304cb2ab7150c931bf9';

/// See also [_remoteRepository].
final _remoteRepositoryProvider =
    Provider<TransactionRemoteRepositoryInterface>(
  _remoteRepository,
  name: r'_remoteRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_remoteRepositoryHash,
);
typedef _RemoteRepositoryRef
    = ProviderRef<TransactionRemoteRepositoryInterface>;
String $_localRepositoryHash() => r'dbb6cbf4a753b202823026f1c8579dacbce11912';

/// See also [_localRepository].
final _localRepositoryProvider = Provider<TransactionLocalRepositoryInterface>(
  _localRepository,
  name: r'_localRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_localRepositoryHash,
);
typedef _LocalRepositoryRef = ProviderRef<TransactionLocalRepositoryInterface>;
