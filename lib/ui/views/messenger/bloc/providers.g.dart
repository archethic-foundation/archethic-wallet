// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$talksHash() => r'9df68aa3068b5364724b701394b53095d63c0d48';

/// See also [_talks].
@ProviderFor(_talks)
final _talksProvider = AutoDisposeFutureProvider<Iterable<Talk>>.internal(
  _talks,
  name: r'_talksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$talksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _TalksRef = AutoDisposeFutureProviderRef<Iterable<Talk>>;
String _$talkHash() => r'43ac2c0ff6372ced2df122cfe463fcab6ab7c0b8';

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
    String address,
  ) {
    return _TalkProvider(
      address,
    );
  }

  @override
  _TalkProvider getProviderOverride(
    covariant _TalkProvider provider,
  ) {
    return call(
      provider.address,
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
    this.address,
  ) : super.internal(
          (ref) => _talk(
            ref,
            address,
          ),
          from: _talkProvider,
          name: r'_talkProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$talkHash,
          dependencies: _TalkFamily._dependencies,
          allTransitiveDependencies: _TalkFamily._allTransitiveDependencies,
        );

  final String address;

  @override
  bool operator ==(Object other) {
    return other is _TalkProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$sortedTalksHash() => r'a69c62e57de2860c16c0b8d09c73490816d807a1';

/// See also [_sortedTalks].
@ProviderFor(_sortedTalks)
final _sortedTalksProvider = AutoDisposeFutureProvider<List<Talk>>.internal(
  _sortedTalks,
  name: r'_sortedTalksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sortedTalksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _SortedTalksRef = AutoDisposeFutureProviderRef<List<Talk>>;
String _$messageCreationFeesHash() =>
    r'd73daff392d278e20cddfd6d6fe9e3e1d46f71e9';
typedef _MessageCreationFeesRef = AutoDisposeFutureProviderRef<double>;

/// See also [_messageCreationFees].
@ProviderFor(_messageCreationFees)
const _messageCreationFeesProvider = _MessageCreationFeesFamily();

/// See also [_messageCreationFees].
class _MessageCreationFeesFamily extends Family<AsyncValue<double>> {
  /// See also [_messageCreationFees].
  const _MessageCreationFeesFamily();

  /// See also [_messageCreationFees].
  _MessageCreationFeesProvider call(
    String talkAddress,
    String content,
  ) {
    return _MessageCreationFeesProvider(
      talkAddress,
      content,
    );
  }

  @override
  _MessageCreationFeesProvider getProviderOverride(
    covariant _MessageCreationFeesProvider provider,
  ) {
    return call(
      provider.talkAddress,
      provider.content,
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
  String? get name => r'_messageCreationFeesProvider';
}

/// See also [_messageCreationFees].
class _MessageCreationFeesProvider extends AutoDisposeFutureProvider<double> {
  /// See also [_messageCreationFees].
  _MessageCreationFeesProvider(
    this.talkAddress,
    this.content,
  ) : super.internal(
          (ref) => _messageCreationFees(
            ref,
            talkAddress,
            content,
          ),
          from: _messageCreationFeesProvider,
          name: r'_messageCreationFeesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messageCreationFeesHash,
          dependencies: _MessageCreationFeesFamily._dependencies,
          allTransitiveDependencies:
              _MessageCreationFeesFamily._allTransitiveDependencies,
        );

  final String talkAddress;
  final String content;

  @override
  bool operator ==(Object other) {
    return other is _MessageCreationFeesProvider &&
        other.talkAddress == talkAddress &&
        other.content == content;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, talkAddress.hashCode);
    hash = _SystemHash.combine(hash, content.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$talkMessagesHash() => r'b145aeb4672f368d39954ad88a45cd9eee51154b';
typedef _TalkMessagesRef = AutoDisposeFutureProviderRef<List<TalkMessage>>;

/// See also [_talkMessages].
@ProviderFor(_talkMessages)
const _talkMessagesProvider = _TalkMessagesFamily();

/// See also [_talkMessages].
class _TalkMessagesFamily extends Family<AsyncValue<List<TalkMessage>>> {
  /// See also [_talkMessages].
  const _TalkMessagesFamily();

  /// See also [_talkMessages].
  _TalkMessagesProvider call(
    String talkAddress,
    int offset,
    int pageSize,
  ) {
    return _TalkMessagesProvider(
      talkAddress,
      offset,
      pageSize,
    );
  }

  @override
  _TalkMessagesProvider getProviderOverride(
    covariant _TalkMessagesProvider provider,
  ) {
    return call(
      provider.talkAddress,
      provider.offset,
      provider.pageSize,
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
  String? get name => r'_talkMessagesProvider';
}

/// See also [_talkMessages].
class _TalkMessagesProvider
    extends AutoDisposeFutureProvider<List<TalkMessage>> {
  /// See also [_talkMessages].
  _TalkMessagesProvider(
    this.talkAddress,
    this.offset,
    this.pageSize,
  ) : super.internal(
          (ref) => _talkMessages(
            ref,
            talkAddress,
            offset,
            pageSize,
          ),
          from: _talkMessagesProvider,
          name: r'_talkMessagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$talkMessagesHash,
          dependencies: _TalkMessagesFamily._dependencies,
          allTransitiveDependencies:
              _TalkMessagesFamily._allTransitiveDependencies,
        );

  final String talkAddress;
  final int offset;
  final int pageSize;

  @override
  bool operator ==(Object other) {
    return other is _TalkMessagesProvider &&
        other.talkAddress == talkAddress &&
        other.offset == offset &&
        other.pageSize == pageSize;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, talkAddress.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);
    hash = _SystemHash.combine(hash, pageSize.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$messageCreationFormNotifierHash() =>
    r'8714e3cb84f7b345836fb5d3ca059dcee59053cc';

abstract class _$MessageCreationFormNotifier
    extends BuildlessAutoDisposeNotifier<MessageCreationFormState> {
  late final String talkAddress;

  MessageCreationFormState build(
    String talkAddress,
  );
}

/// See also [_MessageCreationFormNotifier].
@ProviderFor(_MessageCreationFormNotifier)
const _messageCreationFormNotifierProvider =
    _MessageCreationFormNotifierFamily();

/// See also [_MessageCreationFormNotifier].
class _MessageCreationFormNotifierFamily
    extends Family<MessageCreationFormState> {
  /// See also [_MessageCreationFormNotifier].
  const _MessageCreationFormNotifierFamily();

  /// See also [_MessageCreationFormNotifier].
  _MessageCreationFormNotifierProvider call(
    String talkAddress,
  ) {
    return _MessageCreationFormNotifierProvider(
      talkAddress,
    );
  }

  @override
  _MessageCreationFormNotifierProvider getProviderOverride(
    covariant _MessageCreationFormNotifierProvider provider,
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
  String? get name => r'_messageCreationFormNotifierProvider';
}

/// See also [_MessageCreationFormNotifier].
class _MessageCreationFormNotifierProvider
    extends AutoDisposeNotifierProviderImpl<_MessageCreationFormNotifier,
        MessageCreationFormState> {
  /// See also [_MessageCreationFormNotifier].
  _MessageCreationFormNotifierProvider(
    this.talkAddress,
  ) : super.internal(
          () => _MessageCreationFormNotifier()..talkAddress = talkAddress,
          from: _messageCreationFormNotifierProvider,
          name: r'_messageCreationFormNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messageCreationFormNotifierHash,
          dependencies: _MessageCreationFormNotifierFamily._dependencies,
          allTransitiveDependencies:
              _MessageCreationFormNotifierFamily._allTransitiveDependencies,
        );

  final String talkAddress;

  @override
  bool operator ==(Object other) {
    return other is _MessageCreationFormNotifierProvider &&
        other.talkAddress == talkAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, talkAddress.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  MessageCreationFormState runNotifierBuild(
    covariant _MessageCreationFormNotifier notifier,
  ) {
    return notifier.build(
      talkAddress,
    );
  }
}

String _$paginatedTalkMessagesNotifierHash() =>
    r'348794a80e8401c9f736dad95a46c1e3733f9ea0';

abstract class _$PaginatedTalkMessagesNotifier
    extends BuildlessAutoDisposeNotifier<PagingController<int, TalkMessage>> {
  late final String talkAddress;

  PagingController<int, TalkMessage> build(
    String talkAddress,
  );
}

/// See also [_PaginatedTalkMessagesNotifier].
@ProviderFor(_PaginatedTalkMessagesNotifier)
const _paginatedTalkMessagesNotifierProvider =
    _PaginatedTalkMessagesNotifierFamily();

/// See also [_PaginatedTalkMessagesNotifier].
class _PaginatedTalkMessagesNotifierFamily
    extends Family<PagingController<int, TalkMessage>> {
  /// See also [_PaginatedTalkMessagesNotifier].
  const _PaginatedTalkMessagesNotifierFamily();

  /// See also [_PaginatedTalkMessagesNotifier].
  _PaginatedTalkMessagesNotifierProvider call(
    String talkAddress,
  ) {
    return _PaginatedTalkMessagesNotifierProvider(
      talkAddress,
    );
  }

  @override
  _PaginatedTalkMessagesNotifierProvider getProviderOverride(
    covariant _PaginatedTalkMessagesNotifierProvider provider,
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
  String? get name => r'_paginatedTalkMessagesNotifierProvider';
}

/// See also [_PaginatedTalkMessagesNotifier].
class _PaginatedTalkMessagesNotifierProvider
    extends AutoDisposeNotifierProviderImpl<_PaginatedTalkMessagesNotifier,
        PagingController<int, TalkMessage>> {
  /// See also [_PaginatedTalkMessagesNotifier].
  _PaginatedTalkMessagesNotifierProvider(
    this.talkAddress,
  ) : super.internal(
          () => _PaginatedTalkMessagesNotifier()..talkAddress = talkAddress,
          from: _paginatedTalkMessagesNotifierProvider,
          name: r'_paginatedTalkMessagesNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$paginatedTalkMessagesNotifierHash,
          dependencies: _PaginatedTalkMessagesNotifierFamily._dependencies,
          allTransitiveDependencies:
              _PaginatedTalkMessagesNotifierFamily._allTransitiveDependencies,
        );

  final String talkAddress;

  @override
  bool operator ==(Object other) {
    return other is _PaginatedTalkMessagesNotifierProvider &&
        other.talkAddress == talkAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, talkAddress.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  PagingController<int, TalkMessage> runNotifierBuild(
    covariant _PaginatedTalkMessagesNotifier notifier,
  ) {
    return notifier.build(
      talkAddress,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
