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
String _$txSentEventsHash() => r'71714c2335498d8a55124574c77db4da80d097bf';

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

/// See also [_txSentEvents].
@ProviderFor(_txSentEvents)
const _txSentEventsProvider = _TxSentEventsFamily();

/// See also [_txSentEvents].
class _TxSentEventsFamily extends Family<AsyncValue<TxSentEvent>> {
  /// See also [_txSentEvents].
  const _TxSentEventsFamily();

  /// See also [_txSentEvents].
  _TxSentEventsProvider call(
    String listenAddress,
  ) {
    return _TxSentEventsProvider(
      listenAddress,
    );
  }

  @override
  _TxSentEventsProvider getProviderOverride(
    covariant _TxSentEventsProvider provider,
  ) {
    return call(
      provider.listenAddress,
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
    String listenAddress,
  ) : this._internal(
          (ref) => _txSentEvents(
            ref as _TxSentEventsRef,
            listenAddress,
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
          listenAddress: listenAddress,
        );

  _TxSentEventsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.listenAddress,
  }) : super.internal();

  final String listenAddress;

  @override
  Override overrideWith(
    Stream<TxSentEvent> Function(_TxSentEventsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _TxSentEventsProvider._internal(
        (ref) => create(ref as _TxSentEventsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        listenAddress: listenAddress,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<TxSentEvent> createElement() {
    return _TxSentEventsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _TxSentEventsProvider &&
        other.listenAddress == listenAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, listenAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _TxSentEventsRef on AutoDisposeStreamProviderRef<TxSentEvent> {
  /// The parameter `listenAddress` of this provider.
  String get listenAddress;
}

class _TxSentEventsProviderElement
    extends AutoDisposeStreamProviderElement<TxSentEvent>
    with _TxSentEventsRef {
  _TxSentEventsProviderElement(super.provider);

  @override
  String get listenAddress => (origin as _TxSentEventsProvider).listenAddress;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
