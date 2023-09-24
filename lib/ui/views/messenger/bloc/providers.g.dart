// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$discussionHash() => r'10b881aaeeb36c4a906a3525086c81ab108a8255';

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

/// See also [_discussion].
@ProviderFor(_discussion)
const _discussionProvider = _DiscussionFamily();

/// See also [_discussion].
class _DiscussionFamily extends Family<AsyncValue<Discussion>> {
  /// See also [_discussion].
  const _DiscussionFamily();

  /// See also [_discussion].
  _DiscussionProvider call(
    String address,
  ) {
    return _DiscussionProvider(
      address,
    );
  }

  @override
  _DiscussionProvider getProviderOverride(
    covariant _DiscussionProvider provider,
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
  String? get name => r'_discussionProvider';
}

/// See also [_discussion].
class _DiscussionProvider extends AutoDisposeFutureProvider<Discussion> {
  /// See also [_discussion].
  _DiscussionProvider(
    String address,
  ) : this._internal(
          (ref) => _discussion(
            ref as _DiscussionRef,
            address,
          ),
          from: _discussionProvider,
          name: r'_discussionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$discussionHash,
          dependencies: _DiscussionFamily._dependencies,
          allTransitiveDependencies:
              _DiscussionFamily._allTransitiveDependencies,
          address: address,
        );

  _DiscussionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
  }) : super.internal();

  final String address;

  @override
  Override overrideWith(
    FutureOr<Discussion> Function(_DiscussionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _DiscussionProvider._internal(
        (ref) => create(ref as _DiscussionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        address: address,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Discussion> createElement() {
    return _DiscussionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _DiscussionProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _DiscussionRef on AutoDisposeFutureProviderRef<Discussion> {
  /// The parameter `address` of this provider.
  String get address;
}

class _DiscussionProviderElement
    extends AutoDisposeFutureProviderElement<Discussion> with _DiscussionRef {
  _DiscussionProviderElement(super.provider);

  @override
  String get address => (origin as _DiscussionProvider).address;
}

String _$discussionDisplayNameHash() =>
    r'5c65d094a29d76864a5e57d0f383da99df9ed664';

/// See also [_discussionDisplayName].
@ProviderFor(_discussionDisplayName)
const _discussionDisplayNameProvider = _DiscussionDisplayNameFamily();

/// See also [_discussionDisplayName].
class _DiscussionDisplayNameFamily extends Family<String> {
  /// See also [_discussionDisplayName].
  const _DiscussionDisplayNameFamily();

  /// See also [_discussionDisplayName].
  _DiscussionDisplayNameProvider call(
    Discussion discussion,
  ) {
    return _DiscussionDisplayNameProvider(
      discussion,
    );
  }

  @override
  _DiscussionDisplayNameProvider getProviderOverride(
    covariant _DiscussionDisplayNameProvider provider,
  ) {
    return call(
      provider.discussion,
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
  String? get name => r'_discussionDisplayNameProvider';
}

/// See also [_discussionDisplayName].
class _DiscussionDisplayNameProvider extends AutoDisposeProvider<String> {
  /// See also [_discussionDisplayName].
  _DiscussionDisplayNameProvider(
    Discussion discussion,
  ) : this._internal(
          (ref) => _discussionDisplayName(
            ref as _DiscussionDisplayNameRef,
            discussion,
          ),
          from: _discussionDisplayNameProvider,
          name: r'_discussionDisplayNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$discussionDisplayNameHash,
          dependencies: _DiscussionDisplayNameFamily._dependencies,
          allTransitiveDependencies:
              _DiscussionDisplayNameFamily._allTransitiveDependencies,
          discussion: discussion,
        );

  _DiscussionDisplayNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.discussion,
  }) : super.internal();

  final Discussion discussion;

  @override
  Override overrideWith(
    String Function(_DiscussionDisplayNameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _DiscussionDisplayNameProvider._internal(
        (ref) => create(ref as _DiscussionDisplayNameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        discussion: discussion,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _DiscussionDisplayNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _DiscussionDisplayNameProvider &&
        other.discussion == discussion;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, discussion.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _DiscussionDisplayNameRef on AutoDisposeProviderRef<String> {
  /// The parameter `discussion` of this provider.
  Discussion get discussion;
}

class _DiscussionDisplayNameProviderElement
    extends AutoDisposeProviderElement<String> with _DiscussionDisplayNameRef {
  _DiscussionDisplayNameProviderElement(super.provider);

  @override
  Discussion get discussion =>
      (origin as _DiscussionDisplayNameProvider).discussion;
}

String _$accessRecipientWithPublicKeyHash() =>
    r'8cd0c92d333699019c70fa46161053c030e3e555';

/// See also [_accessRecipientWithPublicKey].
@ProviderFor(_accessRecipientWithPublicKey)
const _accessRecipientWithPublicKeyProvider =
    _AccessRecipientWithPublicKeyFamily();

/// See also [_accessRecipientWithPublicKey].
class _AccessRecipientWithPublicKeyFamily
    extends Family<AsyncValue<AccessRecipient>> {
  /// See also [_accessRecipientWithPublicKey].
  const _AccessRecipientWithPublicKeyFamily();

  /// See also [_accessRecipientWithPublicKey].
  _AccessRecipientWithPublicKeyProvider call(
    String pubKey,
  ) {
    return _AccessRecipientWithPublicKeyProvider(
      pubKey,
    );
  }

  @override
  _AccessRecipientWithPublicKeyProvider getProviderOverride(
    covariant _AccessRecipientWithPublicKeyProvider provider,
  ) {
    return call(
      provider.pubKey,
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
  String? get name => r'_accessRecipientWithPublicKeyProvider';
}

/// See also [_accessRecipientWithPublicKey].
class _AccessRecipientWithPublicKeyProvider
    extends AutoDisposeFutureProvider<AccessRecipient> {
  /// See also [_accessRecipientWithPublicKey].
  _AccessRecipientWithPublicKeyProvider(
    String pubKey,
  ) : this._internal(
          (ref) => _accessRecipientWithPublicKey(
            ref as _AccessRecipientWithPublicKeyRef,
            pubKey,
          ),
          from: _accessRecipientWithPublicKeyProvider,
          name: r'_accessRecipientWithPublicKeyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$accessRecipientWithPublicKeyHash,
          dependencies: _AccessRecipientWithPublicKeyFamily._dependencies,
          allTransitiveDependencies:
              _AccessRecipientWithPublicKeyFamily._allTransitiveDependencies,
          pubKey: pubKey,
        );

  _AccessRecipientWithPublicKeyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pubKey,
  }) : super.internal();

  final String pubKey;

  @override
  Override overrideWith(
    FutureOr<AccessRecipient> Function(
            _AccessRecipientWithPublicKeyRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _AccessRecipientWithPublicKeyProvider._internal(
        (ref) => create(ref as _AccessRecipientWithPublicKeyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pubKey: pubKey,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AccessRecipient> createElement() {
    return _AccessRecipientWithPublicKeyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _AccessRecipientWithPublicKeyProvider &&
        other.pubKey == pubKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pubKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _AccessRecipientWithPublicKeyRef
    on AutoDisposeFutureProviderRef<AccessRecipient> {
  /// The parameter `pubKey` of this provider.
  String get pubKey;
}

class _AccessRecipientWithPublicKeyProviderElement
    extends AutoDisposeFutureProviderElement<AccessRecipient>
    with _AccessRecipientWithPublicKeyRef {
  _AccessRecipientWithPublicKeyProviderElement(super.provider);

  @override
  String get pubKey => (origin as _AccessRecipientWithPublicKeyProvider).pubKey;
}

String _$remoteDiscussionHash() => r'686c3e57cdf4f6d0616c2371cda5110356bd3d13';

/// See also [_remoteDiscussion].
@ProviderFor(_remoteDiscussion)
const _remoteDiscussionProvider = _RemoteDiscussionFamily();

/// See also [_remoteDiscussion].
class _RemoteDiscussionFamily extends Family<AsyncValue<Discussion>> {
  /// See also [_remoteDiscussion].
  const _RemoteDiscussionFamily();

  /// See also [_remoteDiscussion].
  _RemoteDiscussionProvider call(
    String address,
  ) {
    return _RemoteDiscussionProvider(
      address,
    );
  }

  @override
  _RemoteDiscussionProvider getProviderOverride(
    covariant _RemoteDiscussionProvider provider,
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
  String? get name => r'_remoteDiscussionProvider';
}

/// See also [_remoteDiscussion].
class _RemoteDiscussionProvider extends AutoDisposeFutureProvider<Discussion> {
  /// See also [_remoteDiscussion].
  _RemoteDiscussionProvider(
    String address,
  ) : this._internal(
          (ref) => _remoteDiscussion(
            ref as _RemoteDiscussionRef,
            address,
          ),
          from: _remoteDiscussionProvider,
          name: r'_remoteDiscussionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$remoteDiscussionHash,
          dependencies: _RemoteDiscussionFamily._dependencies,
          allTransitiveDependencies:
              _RemoteDiscussionFamily._allTransitiveDependencies,
          address: address,
        );

  _RemoteDiscussionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
  }) : super.internal();

  final String address;

  @override
  Override overrideWith(
    FutureOr<Discussion> Function(_RemoteDiscussionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _RemoteDiscussionProvider._internal(
        (ref) => create(ref as _RemoteDiscussionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        address: address,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Discussion> createElement() {
    return _RemoteDiscussionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _RemoteDiscussionProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _RemoteDiscussionRef on AutoDisposeFutureProviderRef<Discussion> {
  /// The parameter `address` of this provider.
  String get address;
}

class _RemoteDiscussionProviderElement
    extends AutoDisposeFutureProviderElement<Discussion>
    with _RemoteDiscussionRef {
  _RemoteDiscussionProviderElement(super.provider);

  @override
  String get address => (origin as _RemoteDiscussionProvider).address;
}

String _$sortedDiscussionsHash() => r'083eefc9d4b8e99c9e0a234c26600207ed3c048b';

/// See also [_sortedDiscussions].
@ProviderFor(_sortedDiscussions)
final _sortedDiscussionsProvider =
    AutoDisposeFutureProvider<List<Discussion>>.internal(
  _sortedDiscussions,
  name: r'_sortedDiscussionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sortedDiscussionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _SortedDiscussionsRef = AutoDisposeFutureProviderRef<List<Discussion>>;
String _$messageCreationFeesHash() =>
    r'b9785f58fee1d54451c98b8642746e240132ed2e';

/// See also [_messageCreationFees].
@ProviderFor(_messageCreationFees)
const _messageCreationFeesProvider = _MessageCreationFeesFamily();

/// See also [_messageCreationFees].
class _MessageCreationFeesFamily extends Family<AsyncValue<double>> {
  /// See also [_messageCreationFees].
  const _MessageCreationFeesFamily();

  /// See also [_messageCreationFees].
  _MessageCreationFeesProvider call(
    String discussionAddress,
    String content,
  ) {
    return _MessageCreationFeesProvider(
      discussionAddress,
      content,
    );
  }

  @override
  _MessageCreationFeesProvider getProviderOverride(
    covariant _MessageCreationFeesProvider provider,
  ) {
    return call(
      provider.discussionAddress,
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
    String discussionAddress,
    String content,
  ) : this._internal(
          (ref) => _messageCreationFees(
            ref as _MessageCreationFeesRef,
            discussionAddress,
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
          discussionAddress: discussionAddress,
          content: content,
        );

  _MessageCreationFeesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.discussionAddress,
    required this.content,
  }) : super.internal();

  final String discussionAddress;
  final String content;

  @override
  Override overrideWith(
    FutureOr<double> Function(_MessageCreationFeesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _MessageCreationFeesProvider._internal(
        (ref) => create(ref as _MessageCreationFeesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        discussionAddress: discussionAddress,
        content: content,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double> createElement() {
    return _MessageCreationFeesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _MessageCreationFeesProvider &&
        other.discussionAddress == discussionAddress &&
        other.content == content;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, discussionAddress.hashCode);
    hash = _SystemHash.combine(hash, content.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _MessageCreationFeesRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `discussionAddress` of this provider.
  String get discussionAddress;

  /// The parameter `content` of this provider.
  String get content;
}

class _MessageCreationFeesProviderElement
    extends AutoDisposeFutureProviderElement<double>
    with _MessageCreationFeesRef {
  _MessageCreationFeesProviderElement(super.provider);

  @override
  String get discussionAddress =>
      (origin as _MessageCreationFeesProvider).discussionAddress;
  @override
  String get content => (origin as _MessageCreationFeesProvider).content;
}

String _$discussionMessagesHash() =>
    r'fd47155c1eb2c43e819918b8f1f14cbf2031dce5';

/// See also [_discussionMessages].
@ProviderFor(_discussionMessages)
const _discussionMessagesProvider = _DiscussionMessagesFamily();

/// See also [_discussionMessages].
class _DiscussionMessagesFamily
    extends Family<AsyncValue<List<DiscussionMessage>>> {
  /// See also [_discussionMessages].
  const _DiscussionMessagesFamily();

  /// See also [_discussionMessages].
  _DiscussionMessagesProvider call(
    String discussionAddress,
    int offset,
    int pageSize,
  ) {
    return _DiscussionMessagesProvider(
      discussionAddress,
      offset,
      pageSize,
    );
  }

  @override
  _DiscussionMessagesProvider getProviderOverride(
    covariant _DiscussionMessagesProvider provider,
  ) {
    return call(
      provider.discussionAddress,
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
  String? get name => r'_discussionMessagesProvider';
}

/// See also [_discussionMessages].
class _DiscussionMessagesProvider
    extends AutoDisposeFutureProvider<List<DiscussionMessage>> {
  /// See also [_discussionMessages].
  _DiscussionMessagesProvider(
    String discussionAddress,
    int offset,
    int pageSize,
  ) : this._internal(
          (ref) => _discussionMessages(
            ref as _DiscussionMessagesRef,
            discussionAddress,
            offset,
            pageSize,
          ),
          from: _discussionMessagesProvider,
          name: r'_discussionMessagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$discussionMessagesHash,
          dependencies: _DiscussionMessagesFamily._dependencies,
          allTransitiveDependencies:
              _DiscussionMessagesFamily._allTransitiveDependencies,
          discussionAddress: discussionAddress,
          offset: offset,
          pageSize: pageSize,
        );

  _DiscussionMessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.discussionAddress,
    required this.offset,
    required this.pageSize,
  }) : super.internal();

  final String discussionAddress;
  final int offset;
  final int pageSize;

  @override
  Override overrideWith(
    FutureOr<List<DiscussionMessage>> Function(_DiscussionMessagesRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _DiscussionMessagesProvider._internal(
        (ref) => create(ref as _DiscussionMessagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        discussionAddress: discussionAddress,
        offset: offset,
        pageSize: pageSize,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DiscussionMessage>> createElement() {
    return _DiscussionMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _DiscussionMessagesProvider &&
        other.discussionAddress == discussionAddress &&
        other.offset == offset &&
        other.pageSize == pageSize;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, discussionAddress.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);
    hash = _SystemHash.combine(hash, pageSize.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _DiscussionMessagesRef
    on AutoDisposeFutureProviderRef<List<DiscussionMessage>> {
  /// The parameter `discussionAddress` of this provider.
  String get discussionAddress;

  /// The parameter `offset` of this provider.
  int get offset;

  /// The parameter `pageSize` of this provider.
  int get pageSize;
}

class _DiscussionMessagesProviderElement
    extends AutoDisposeFutureProviderElement<List<DiscussionMessage>>
    with _DiscussionMessagesRef {
  _DiscussionMessagesProviderElement(super.provider);

  @override
  String get discussionAddress =>
      (origin as _DiscussionMessagesProvider).discussionAddress;
  @override
  int get offset => (origin as _DiscussionMessagesProvider).offset;
  @override
  int get pageSize => (origin as _DiscussionMessagesProvider).pageSize;
}

String _$discussionsHash() => r'a4c36b61d6370a8e2ba8fb15e67ae9cc8e9917fb';

/// See also [_Discussions].
@ProviderFor(_Discussions)
final _discussionsProvider = AutoDisposeAsyncNotifierProvider<_Discussions,
    Iterable<Discussion>>.internal(
  _Discussions.new,
  name: r'_discussionsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$discussionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Discussions = AutoDisposeAsyncNotifier<Iterable<Discussion>>;
String _$messageCreationFormNotifierHash() =>
    r'b5a2c5ef6d68ca9d1bb861ab865ba4b360d93e25';

abstract class _$MessageCreationFormNotifier
    extends BuildlessAutoDisposeNotifier<MessageCreationFormState> {
  late final Discussion discussion;

  MessageCreationFormState build(
    Discussion discussion,
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
    Discussion discussion,
  ) {
    return _MessageCreationFormNotifierProvider(
      discussion,
    );
  }

  @override
  _MessageCreationFormNotifierProvider getProviderOverride(
    covariant _MessageCreationFormNotifierProvider provider,
  ) {
    return call(
      provider.discussion,
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
    Discussion discussion,
  ) : this._internal(
          () => _MessageCreationFormNotifier()..discussion = discussion,
          from: _messageCreationFormNotifierProvider,
          name: r'_messageCreationFormNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messageCreationFormNotifierHash,
          dependencies: _MessageCreationFormNotifierFamily._dependencies,
          allTransitiveDependencies:
              _MessageCreationFormNotifierFamily._allTransitiveDependencies,
          discussion: discussion,
        );

  _MessageCreationFormNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.discussion,
  }) : super.internal();

  final Discussion discussion;

  @override
  MessageCreationFormState runNotifierBuild(
    covariant _MessageCreationFormNotifier notifier,
  ) {
    return notifier.build(
      discussion,
    );
  }

  @override
  Override overrideWith(_MessageCreationFormNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: _MessageCreationFormNotifierProvider._internal(
        () => create()..discussion = discussion,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        discussion: discussion,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<_MessageCreationFormNotifier,
      MessageCreationFormState> createElement() {
    return _MessageCreationFormNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _MessageCreationFormNotifierProvider &&
        other.discussion == discussion;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, discussion.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _MessageCreationFormNotifierRef
    on AutoDisposeNotifierProviderRef<MessageCreationFormState> {
  /// The parameter `discussion` of this provider.
  Discussion get discussion;
}

class _MessageCreationFormNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<_MessageCreationFormNotifier,
        MessageCreationFormState> with _MessageCreationFormNotifierRef {
  _MessageCreationFormNotifierProviderElement(super.provider);

  @override
  Discussion get discussion =>
      (origin as _MessageCreationFormNotifierProvider).discussion;
}

String _$paginatedDiscussionMessagesNotifierHash() =>
    r'85cde8d45cf844fc3e8e838a59533dfc1ecc4cb1';

abstract class _$PaginatedDiscussionMessagesNotifier
    extends BuildlessAutoDisposeNotifier<
        PagingController<int, DiscussionMessage>> {
  late final String discussionAddress;

  PagingController<int, DiscussionMessage> build(
    String discussionAddress,
  );
}

/// See also [_PaginatedDiscussionMessagesNotifier].
@ProviderFor(_PaginatedDiscussionMessagesNotifier)
const _paginatedDiscussionMessagesNotifierProvider =
    _PaginatedDiscussionMessagesNotifierFamily();

/// See also [_PaginatedDiscussionMessagesNotifier].
class _PaginatedDiscussionMessagesNotifierFamily
    extends Family<PagingController<int, DiscussionMessage>> {
  /// See also [_PaginatedDiscussionMessagesNotifier].
  const _PaginatedDiscussionMessagesNotifierFamily();

  /// See also [_PaginatedDiscussionMessagesNotifier].
  _PaginatedDiscussionMessagesNotifierProvider call(
    String discussionAddress,
  ) {
    return _PaginatedDiscussionMessagesNotifierProvider(
      discussionAddress,
    );
  }

  @override
  _PaginatedDiscussionMessagesNotifierProvider getProviderOverride(
    covariant _PaginatedDiscussionMessagesNotifierProvider provider,
  ) {
    return call(
      provider.discussionAddress,
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
  String? get name => r'_paginatedDiscussionMessagesNotifierProvider';
}

/// See also [_PaginatedDiscussionMessagesNotifier].
class _PaginatedDiscussionMessagesNotifierProvider
    extends AutoDisposeNotifierProviderImpl<
        _PaginatedDiscussionMessagesNotifier,
        PagingController<int, DiscussionMessage>> {
  /// See also [_PaginatedDiscussionMessagesNotifier].
  _PaginatedDiscussionMessagesNotifierProvider(
    String discussionAddress,
  ) : this._internal(
          () => _PaginatedDiscussionMessagesNotifier()
            ..discussionAddress = discussionAddress,
          from: _paginatedDiscussionMessagesNotifierProvider,
          name: r'_paginatedDiscussionMessagesNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$paginatedDiscussionMessagesNotifierHash,
          dependencies:
              _PaginatedDiscussionMessagesNotifierFamily._dependencies,
          allTransitiveDependencies: _PaginatedDiscussionMessagesNotifierFamily
              ._allTransitiveDependencies,
          discussionAddress: discussionAddress,
        );

  _PaginatedDiscussionMessagesNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.discussionAddress,
  }) : super.internal();

  final String discussionAddress;

  @override
  PagingController<int, DiscussionMessage> runNotifierBuild(
    covariant _PaginatedDiscussionMessagesNotifier notifier,
  ) {
    return notifier.build(
      discussionAddress,
    );
  }

  @override
  Override overrideWith(
      _PaginatedDiscussionMessagesNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: _PaginatedDiscussionMessagesNotifierProvider._internal(
        () => create()..discussionAddress = discussionAddress,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        discussionAddress: discussionAddress,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<_PaginatedDiscussionMessagesNotifier,
      PagingController<int, DiscussionMessage>> createElement() {
    return _PaginatedDiscussionMessagesNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _PaginatedDiscussionMessagesNotifierProvider &&
        other.discussionAddress == discussionAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, discussionAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _PaginatedDiscussionMessagesNotifierRef on AutoDisposeNotifierProviderRef<
    PagingController<int, DiscussionMessage>> {
  /// The parameter `discussionAddress` of this provider.
  String get discussionAddress;
}

class _PaginatedDiscussionMessagesNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<
        _PaginatedDiscussionMessagesNotifier,
        PagingController<int, DiscussionMessage>>
    with _PaginatedDiscussionMessagesNotifierRef {
  _PaginatedDiscussionMessagesNotifierProviderElement(super.provider);

  @override
  String get discussionAddress =>
      (origin as _PaginatedDiscussionMessagesNotifierProvider)
          .discussionAddress;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
