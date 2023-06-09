// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$talkHash() => r'5fb0711dfe5996d7be9a5d302210739e54b1ff85';

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

typedef _TalkRef = AutoDisposeFutureProviderRef<Talk>;

/// See also [_talk].
@ProviderFor(_talk)
const _talkProvider = _TalkFamily();

/// See also [_talk].
class _TalkFamily extends Family<AsyncValue<Talk>> {
  /// See also [_talk].
  const _TalkFamily();

  /// See also [_talk].
  _TalkProvider call(
    String talkId,
  ) {
    return _TalkProvider(
      talkId,
    );
  }

  @override
  _TalkProvider getProviderOverride(
    covariant _TalkProvider provider,
  ) {
    return call(
      provider.talkId,
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
  String? get name => r'_talkProvider';
}

/// See also [_talk].
class _TalkProvider extends AutoDisposeFutureProvider<Talk> {
  /// See also [_talk].
  _TalkProvider(
    this.talkId,
  ) : super.internal(
          (ref) => _talk(
            ref,
            talkId,
          ),
          from: _talkProvider,
          name: r'_talkProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$talkHash,
          dependencies: _TalkFamily._dependencies,
          allTransitiveDependencies: _TalkFamily._allTransitiveDependencies,
        );

  final String talkId;

  @override
  bool operator ==(Object other) {
    return other is _TalkProvider && other.talkId == talkId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, talkId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$talkAddressesHash() => r'dce9ddf2e6806d6fd73d37af16e01ebc064a4453';

/// See also [_talkAddresses].
@ProviderFor(_talkAddresses)
final _talkAddressesProvider = AutoDisposeFutureProvider<List<String>>.internal(
  _talkAddresses,
  name: r'_talkAddressesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$talkAddressesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _TalkAddressesRef = AutoDisposeFutureProviderRef<List<String>>;
String _$talkMessagesNotifierHash() =>
    r'37be84c2fa827577dd14ddd4a9c4180f43c5d281';

abstract class _$TalkMessagesNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<TalkMessage>> {
  late final String talkAddress;

  FutureOr<List<TalkMessage>> build(
    String talkAddress,
  );
}

/// See also [_TalkMessagesNotifier].
@ProviderFor(_TalkMessagesNotifier)
const _talkMessagesNotifierProvider = _TalkMessagesNotifierFamily();

/// See also [_TalkMessagesNotifier].
class _TalkMessagesNotifierFamily
    extends Family<AsyncValue<List<TalkMessage>>> {
  /// See also [_TalkMessagesNotifier].
  const _TalkMessagesNotifierFamily();

  /// See also [_TalkMessagesNotifier].
  _TalkMessagesNotifierProvider call(
    String talkAddress,
  ) {
    return _TalkMessagesNotifierProvider(
      talkAddress,
    );
  }

  @override
  _TalkMessagesNotifierProvider getProviderOverride(
    covariant _TalkMessagesNotifierProvider provider,
  ) {
    return call(
      provider.talkAddress,
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
  String? get name => r'_talkMessagesNotifierProvider';
}

/// See also [_TalkMessagesNotifier].
class _TalkMessagesNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<_TalkMessagesNotifier,
        List<TalkMessage>> {
  /// See also [_TalkMessagesNotifier].
  _TalkMessagesNotifierProvider(
    this.talkAddress,
  ) : super.internal(
          () => _TalkMessagesNotifier()..talkAddress = talkAddress,
          from: _talkMessagesNotifierProvider,
          name: r'_talkMessagesNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$talkMessagesNotifierHash,
          dependencies: _TalkMessagesNotifierFamily._dependencies,
          allTransitiveDependencies:
              _TalkMessagesNotifierFamily._allTransitiveDependencies,
        );

  final String talkAddress;

  @override
  bool operator ==(Object other) {
    return other is _TalkMessagesNotifierProvider &&
        other.talkAddress == talkAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, talkAddress.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<TalkMessage>> runNotifierBuild(
    covariant _TalkMessagesNotifier notifier,
  ) {
    return notifier.build(
      talkAddress,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions