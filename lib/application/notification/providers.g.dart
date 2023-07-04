// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationRepositoryHash() =>
    r'7e1f2ea623188a3d472a103e9ed49d04326651dd';

/// See also [_notificationRepository].
@ProviderFor(_notificationRepository)
final _notificationRepositoryProvider =
    Provider<NotificationsRepository>.internal(
  _notificationRepository,
  name: r'_notificationRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _NotificationRepositoryRef = ProviderRef<NotificationsRepository>;
String _$txSentEventsHash() => r'7555e6b25dce9862c0ed04d1066359a01c8eb726';

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

typedef _TxSentEventsRef = AutoDisposeStreamProviderRef<TxSentEvent>;

/// See also [_txSentEvents].
@ProviderFor(_txSentEvents)
const _txSentEventsProvider = _TxSentEventsFamily();

/// See also [_txSentEvents].
class _TxSentEventsFamily extends Family<AsyncValue<TxSentEvent>> {
  /// See also [_txSentEvents].
  const _TxSentEventsFamily();

  /// See also [_txSentEvents].
  _TxSentEventsProvider call(
    String txChainGenesisAddress,
  ) {
    return _TxSentEventsProvider(
      txChainGenesisAddress,
    );
  }

  @override
  _TxSentEventsProvider getProviderOverride(
    covariant _TxSentEventsProvider provider,
  ) {
    return call(
      provider.txChainGenesisAddress,
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
  String? get name => r'_txSentEventsProvider';
}

/// See also [_txSentEvents].
class _TxSentEventsProvider extends AutoDisposeStreamProvider<TxSentEvent> {
  /// See also [_txSentEvents].
  _TxSentEventsProvider(
    this.txChainGenesisAddress,
  ) : super.internal(
          (ref) => _txSentEvents(
            ref,
            txChainGenesisAddress,
          ),
          from: _txSentEventsProvider,
          name: r'_txSentEventsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$txSentEventsHash,
          dependencies: _TxSentEventsFamily._dependencies,
          allTransitiveDependencies:
              _TxSentEventsFamily._allTransitiveDependencies,
        );

  final String txChainGenesisAddress;

  @override
  bool operator ==(Object other) {
    return other is _TxSentEventsProvider &&
        other.txChainGenesisAddress == txChainGenesisAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, txChainGenesisAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
