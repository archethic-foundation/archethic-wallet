// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$contactRepositoryHash() => r'cf712b6cccb80060dda6cf8b5e0115332d394211';

/// See also [_contactRepository].
@ProviderFor(_contactRepository)
final _contactRepositoryProvider =
    AutoDisposeProvider<ContactRepository>.internal(
  _contactRepository,
  name: r'_contactRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$contactRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _ContactRepositoryRef = AutoDisposeProviderRef<ContactRepository>;
String _$fetchContactsHash() => r'e577c0c6beecb77d4217b611093c1e6f9e62b8e2';

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

/// See also [_fetchContacts].
@ProviderFor(_fetchContacts)
const _fetchContactsProvider = _FetchContactsFamily();

/// See also [_fetchContacts].
class _FetchContactsFamily extends Family<AsyncValue<List<Contact>>> {
  /// See also [_fetchContacts].
  const _FetchContactsFamily();

  /// See also [_fetchContacts].
  _FetchContactsProvider call({
    String search = '',
  }) {
    return _FetchContactsProvider(
      search: search,
    );
  }

  @override
  _FetchContactsProvider getProviderOverride(
    covariant _FetchContactsProvider provider,
  ) {
    return call(
      search: provider.search,
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
  String? get name => r'_fetchContactsProvider';
}

/// See also [_fetchContacts].
class _FetchContactsProvider extends AutoDisposeFutureProvider<List<Contact>> {
  /// See also [_fetchContacts].
  _FetchContactsProvider({
    String search = '',
  }) : this._internal(
          (ref) => _fetchContacts(
            ref as _FetchContactsRef,
            search: search,
          ),
          from: _fetchContactsProvider,
          name: r'_fetchContactsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchContactsHash,
          dependencies: _FetchContactsFamily._dependencies,
          allTransitiveDependencies:
              _FetchContactsFamily._allTransitiveDependencies,
          search: search,
        );

  _FetchContactsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.search,
  }) : super.internal();

  final String search;

  @override
  Override overrideWith(
    FutureOr<List<Contact>> Function(_FetchContactsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchContactsProvider._internal(
        (ref) => create(ref as _FetchContactsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        search: search,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Contact>> createElement() {
    return _FetchContactsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _FetchContactsProvider && other.search == search;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, search.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _FetchContactsRef on AutoDisposeFutureProviderRef<List<Contact>> {
  /// The parameter `search` of this provider.
  String get search;
}

class _FetchContactsProviderElement
    extends AutoDisposeFutureProviderElement<List<Contact>>
    with _FetchContactsRef {
  _FetchContactsProviderElement(super.provider);

  @override
  String get search => (origin as _FetchContactsProvider).search;
}

String _$getSelectedContactHash() =>
    r'109fbd016c26cd4de5a583cdc034524e7d6f7146';

/// See also [_getSelectedContact].
@ProviderFor(_getSelectedContact)
final _getSelectedContactProvider =
    AutoDisposeFutureProvider<Contact?>.internal(
  _getSelectedContact,
  name: r'_getSelectedContactProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getSelectedContactHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetSelectedContactRef = AutoDisposeFutureProviderRef<Contact?>;
String _$getContactWithNameHash() =>
    r'e42c9606f79b6b6396b453ee26e7af18ae358470';

/// See also [_getContactWithName].
@ProviderFor(_getContactWithName)
const _getContactWithNameProvider = _GetContactWithNameFamily();

/// See also [_getContactWithName].
class _GetContactWithNameFamily extends Family<AsyncValue<Contact?>> {
  /// See also [_getContactWithName].
  const _GetContactWithNameFamily();

  /// See also [_getContactWithName].
  _GetContactWithNameProvider call(
    String contactName,
  ) {
    return _GetContactWithNameProvider(
      contactName,
    );
  }

  @override
  _GetContactWithNameProvider getProviderOverride(
    covariant _GetContactWithNameProvider provider,
  ) {
    return call(
      provider.contactName,
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
  String? get name => r'_getContactWithNameProvider';
}

/// See also [_getContactWithName].
class _GetContactWithNameProvider extends AutoDisposeFutureProvider<Contact?> {
  /// See also [_getContactWithName].
  _GetContactWithNameProvider(
    String contactName,
  ) : this._internal(
          (ref) => _getContactWithName(
            ref as _GetContactWithNameRef,
            contactName,
          ),
          from: _getContactWithNameProvider,
          name: r'_getContactWithNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getContactWithNameHash,
          dependencies: _GetContactWithNameFamily._dependencies,
          allTransitiveDependencies:
              _GetContactWithNameFamily._allTransitiveDependencies,
          contactName: contactName,
        );

  _GetContactWithNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.contactName,
  }) : super.internal();

  final String contactName;

  @override
  Override overrideWith(
    FutureOr<Contact?> Function(_GetContactWithNameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetContactWithNameProvider._internal(
        (ref) => create(ref as _GetContactWithNameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        contactName: contactName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Contact?> createElement() {
    return _GetContactWithNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetContactWithNameProvider &&
        other.contactName == contactName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contactName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetContactWithNameRef on AutoDisposeFutureProviderRef<Contact?> {
  /// The parameter `contactName` of this provider.
  String get contactName;
}

class _GetContactWithNameProviderElement
    extends AutoDisposeFutureProviderElement<Contact?>
    with _GetContactWithNameRef {
  _GetContactWithNameProviderElement(super.provider);

  @override
  String get contactName => (origin as _GetContactWithNameProvider).contactName;
}

String _$getContactWithAddressHash() =>
    r'5d7e119dd654939aebe4963994fc8b0888a944c4';

/// See also [_getContactWithAddress].
@ProviderFor(_getContactWithAddress)
const _getContactWithAddressProvider = _GetContactWithAddressFamily();

/// See also [_getContactWithAddress].
class _GetContactWithAddressFamily extends Family<AsyncValue<Contact?>> {
  /// See also [_getContactWithAddress].
  const _GetContactWithAddressFamily();

  /// See also [_getContactWithAddress].
  _GetContactWithAddressProvider call(
    String address,
  ) {
    return _GetContactWithAddressProvider(
      address,
    );
  }

  @override
  _GetContactWithAddressProvider getProviderOverride(
    covariant _GetContactWithAddressProvider provider,
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
  String? get name => r'_getContactWithAddressProvider';
}

/// See also [_getContactWithAddress].
class _GetContactWithAddressProvider
    extends AutoDisposeFutureProvider<Contact?> {
  /// See also [_getContactWithAddress].
  _GetContactWithAddressProvider(
    String address,
  ) : this._internal(
          (ref) => _getContactWithAddress(
            ref as _GetContactWithAddressRef,
            address,
          ),
          from: _getContactWithAddressProvider,
          name: r'_getContactWithAddressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getContactWithAddressHash,
          dependencies: _GetContactWithAddressFamily._dependencies,
          allTransitiveDependencies:
              _GetContactWithAddressFamily._allTransitiveDependencies,
          address: address,
        );

  _GetContactWithAddressProvider._internal(
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
    FutureOr<Contact?> Function(_GetContactWithAddressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetContactWithAddressProvider._internal(
        (ref) => create(ref as _GetContactWithAddressRef),
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
  AutoDisposeFutureProviderElement<Contact?> createElement() {
    return _GetContactWithAddressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetContactWithAddressProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetContactWithAddressRef on AutoDisposeFutureProviderRef<Contact?> {
  /// The parameter `address` of this provider.
  String get address;
}

class _GetContactWithAddressProviderElement
    extends AutoDisposeFutureProviderElement<Contact?>
    with _GetContactWithAddressRef {
  _GetContactWithAddressProviderElement(super.provider);

  @override
  String get address => (origin as _GetContactWithAddressProvider).address;
}

String _$getContactWithPublicKeyHash() =>
    r'9f398d381eb5fedeba4fa599ebdee44f8f405d03';

/// See also [_getContactWithPublicKey].
@ProviderFor(_getContactWithPublicKey)
const _getContactWithPublicKeyProvider = _GetContactWithPublicKeyFamily();

/// See also [_getContactWithPublicKey].
class _GetContactWithPublicKeyFamily extends Family<AsyncValue<Contact?>> {
  /// See also [_getContactWithPublicKey].
  const _GetContactWithPublicKeyFamily();

  /// See also [_getContactWithPublicKey].
  _GetContactWithPublicKeyProvider call(
    String publicKey,
  ) {
    return _GetContactWithPublicKeyProvider(
      publicKey,
    );
  }

  @override
  _GetContactWithPublicKeyProvider getProviderOverride(
    covariant _GetContactWithPublicKeyProvider provider,
  ) {
    return call(
      provider.publicKey,
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
  String? get name => r'_getContactWithPublicKeyProvider';
}

/// See also [_getContactWithPublicKey].
class _GetContactWithPublicKeyProvider
    extends AutoDisposeFutureProvider<Contact?> {
  /// See also [_getContactWithPublicKey].
  _GetContactWithPublicKeyProvider(
    String publicKey,
  ) : this._internal(
          (ref) => _getContactWithPublicKey(
            ref as _GetContactWithPublicKeyRef,
            publicKey,
          ),
          from: _getContactWithPublicKeyProvider,
          name: r'_getContactWithPublicKeyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getContactWithPublicKeyHash,
          dependencies: _GetContactWithPublicKeyFamily._dependencies,
          allTransitiveDependencies:
              _GetContactWithPublicKeyFamily._allTransitiveDependencies,
          publicKey: publicKey,
        );

  _GetContactWithPublicKeyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.publicKey,
  }) : super.internal();

  final String publicKey;

  @override
  Override overrideWith(
    FutureOr<Contact?> Function(_GetContactWithPublicKeyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetContactWithPublicKeyProvider._internal(
        (ref) => create(ref as _GetContactWithPublicKeyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        publicKey: publicKey,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Contact?> createElement() {
    return _GetContactWithPublicKeyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetContactWithPublicKeyProvider &&
        other.publicKey == publicKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, publicKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetContactWithPublicKeyRef on AutoDisposeFutureProviderRef<Contact?> {
  /// The parameter `publicKey` of this provider.
  String get publicKey;
}

class _GetContactWithPublicKeyProviderElement
    extends AutoDisposeFutureProviderElement<Contact?>
    with _GetContactWithPublicKeyRef {
  _GetContactWithPublicKeyProviderElement(super.provider);

  @override
  String get publicKey =>
      (origin as _GetContactWithPublicKeyProvider).publicKey;
}

String _$getContactWithGenesisPublicKeyHash() =>
    r'ba5b98ca4aea9d1f0bcab19a0ba1b455fea93b63';

/// See also [_getContactWithGenesisPublicKey].
@ProviderFor(_getContactWithGenesisPublicKey)
const _getContactWithGenesisPublicKeyProvider =
    _GetContactWithGenesisPublicKeyFamily();

/// See also [_getContactWithGenesisPublicKey].
class _GetContactWithGenesisPublicKeyFamily
    extends Family<AsyncValue<Contact?>> {
  /// See also [_getContactWithGenesisPublicKey].
  const _GetContactWithGenesisPublicKeyFamily();

  /// See also [_getContactWithGenesisPublicKey].
  _GetContactWithGenesisPublicKeyProvider call(
    String genesisPublicKey,
  ) {
    return _GetContactWithGenesisPublicKeyProvider(
      genesisPublicKey,
    );
  }

  @override
  _GetContactWithGenesisPublicKeyProvider getProviderOverride(
    covariant _GetContactWithGenesisPublicKeyProvider provider,
  ) {
    return call(
      provider.genesisPublicKey,
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
  String? get name => r'_getContactWithGenesisPublicKeyProvider';
}

/// See also [_getContactWithGenesisPublicKey].
class _GetContactWithGenesisPublicKeyProvider
    extends AutoDisposeFutureProvider<Contact?> {
  /// See also [_getContactWithGenesisPublicKey].
  _GetContactWithGenesisPublicKeyProvider(
    String genesisPublicKey,
  ) : this._internal(
          (ref) => _getContactWithGenesisPublicKey(
            ref as _GetContactWithGenesisPublicKeyRef,
            genesisPublicKey,
          ),
          from: _getContactWithGenesisPublicKeyProvider,
          name: r'_getContactWithGenesisPublicKeyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getContactWithGenesisPublicKeyHash,
          dependencies: _GetContactWithGenesisPublicKeyFamily._dependencies,
          allTransitiveDependencies:
              _GetContactWithGenesisPublicKeyFamily._allTransitiveDependencies,
          genesisPublicKey: genesisPublicKey,
        );

  _GetContactWithGenesisPublicKeyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.genesisPublicKey,
  }) : super.internal();

  final String genesisPublicKey;

  @override
  Override overrideWith(
    FutureOr<Contact?> Function(_GetContactWithGenesisPublicKeyRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetContactWithGenesisPublicKeyProvider._internal(
        (ref) => create(ref as _GetContactWithGenesisPublicKeyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        genesisPublicKey: genesisPublicKey,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Contact?> createElement() {
    return _GetContactWithGenesisPublicKeyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetContactWithGenesisPublicKeyProvider &&
        other.genesisPublicKey == genesisPublicKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, genesisPublicKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetContactWithGenesisPublicKeyRef
    on AutoDisposeFutureProviderRef<Contact?> {
  /// The parameter `genesisPublicKey` of this provider.
  String get genesisPublicKey;
}

class _GetContactWithGenesisPublicKeyProviderElement
    extends AutoDisposeFutureProviderElement<Contact?>
    with _GetContactWithGenesisPublicKeyRef {
  _GetContactWithGenesisPublicKeyProviderElement(super.provider);

  @override
  String get genesisPublicKey =>
      (origin as _GetContactWithGenesisPublicKeyProvider).genesisPublicKey;
}

String _$saveContactHash() => r'618ffd2195caf59b253a4866ef3c259e29ddcba9';

/// See also [_saveContact].
@ProviderFor(_saveContact)
const _saveContactProvider = _SaveContactFamily();

/// See also [_saveContact].
class _SaveContactFamily extends Family<AsyncValue<void>> {
  /// See also [_saveContact].
  const _SaveContactFamily();

  /// See also [_saveContact].
  _SaveContactProvider call({
    Contact? contact,
  }) {
    return _SaveContactProvider(
      contact: contact,
    );
  }

  @override
  _SaveContactProvider getProviderOverride(
    covariant _SaveContactProvider provider,
  ) {
    return call(
      contact: provider.contact,
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
  String? get name => r'_saveContactProvider';
}

/// See also [_saveContact].
class _SaveContactProvider extends AutoDisposeFutureProvider<void> {
  /// See also [_saveContact].
  _SaveContactProvider({
    Contact? contact,
  }) : this._internal(
          (ref) => _saveContact(
            ref as _SaveContactRef,
            contact: contact,
          ),
          from: _saveContactProvider,
          name: r'_saveContactProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$saveContactHash,
          dependencies: _SaveContactFamily._dependencies,
          allTransitiveDependencies:
              _SaveContactFamily._allTransitiveDependencies,
          contact: contact,
        );

  _SaveContactProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.contact,
  }) : super.internal();

  final Contact? contact;

  @override
  Override overrideWith(
    FutureOr<void> Function(_SaveContactRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _SaveContactProvider._internal(
        (ref) => create(ref as _SaveContactRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        contact: contact,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SaveContactProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _SaveContactProvider && other.contact == contact;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contact.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _SaveContactRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `contact` of this provider.
  Contact? get contact;
}

class _SaveContactProviderElement extends AutoDisposeFutureProviderElement<void>
    with _SaveContactRef {
  _SaveContactProviderElement(super.provider);

  @override
  Contact? get contact => (origin as _SaveContactProvider).contact;
}

String _$deleteContactHash() => r'2e752a050b11741ff8e7b5ace2b5688b5b0bfea9';

/// See also [_deleteContact].
@ProviderFor(_deleteContact)
const _deleteContactProvider = _DeleteContactFamily();

/// See also [_deleteContact].
class _DeleteContactFamily extends Family<AsyncValue<void>> {
  /// See also [_deleteContact].
  const _DeleteContactFamily();

  /// See also [_deleteContact].
  _DeleteContactProvider call({
    Contact? contact,
  }) {
    return _DeleteContactProvider(
      contact: contact,
    );
  }

  @override
  _DeleteContactProvider getProviderOverride(
    covariant _DeleteContactProvider provider,
  ) {
    return call(
      contact: provider.contact,
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
  String? get name => r'_deleteContactProvider';
}

/// See also [_deleteContact].
class _DeleteContactProvider extends AutoDisposeFutureProvider<void> {
  /// See also [_deleteContact].
  _DeleteContactProvider({
    Contact? contact,
  }) : this._internal(
          (ref) => _deleteContact(
            ref as _DeleteContactRef,
            contact: contact,
          ),
          from: _deleteContactProvider,
          name: r'_deleteContactProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteContactHash,
          dependencies: _DeleteContactFamily._dependencies,
          allTransitiveDependencies:
              _DeleteContactFamily._allTransitiveDependencies,
          contact: contact,
        );

  _DeleteContactProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.contact,
  }) : super.internal();

  final Contact? contact;

  @override
  Override overrideWith(
    FutureOr<void> Function(_DeleteContactRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _DeleteContactProvider._internal(
        (ref) => create(ref as _DeleteContactRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        contact: contact,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _DeleteContactProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _DeleteContactProvider && other.contact == contact;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contact.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _DeleteContactRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `contact` of this provider.
  Contact? get contact;
}

class _DeleteContactProviderElement
    extends AutoDisposeFutureProviderElement<void> with _DeleteContactRef {
  _DeleteContactProviderElement(super.provider);

  @override
  Contact? get contact => (origin as _DeleteContactProvider).contact;
}

String _$isContactExistsWithNameHash() =>
    r'b18c734decf17f6100eb45137e53610775b90d10';

/// See also [_isContactExistsWithName].
@ProviderFor(_isContactExistsWithName)
const _isContactExistsWithNameProvider = _IsContactExistsWithNameFamily();

/// See also [_isContactExistsWithName].
class _IsContactExistsWithNameFamily extends Family<AsyncValue<bool>> {
  /// See also [_isContactExistsWithName].
  const _IsContactExistsWithNameFamily();

  /// See also [_isContactExistsWithName].
  _IsContactExistsWithNameProvider call({
    String? contactName,
  }) {
    return _IsContactExistsWithNameProvider(
      contactName: contactName,
    );
  }

  @override
  _IsContactExistsWithNameProvider getProviderOverride(
    covariant _IsContactExistsWithNameProvider provider,
  ) {
    return call(
      contactName: provider.contactName,
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
  String? get name => r'_isContactExistsWithNameProvider';
}

/// See also [_isContactExistsWithName].
class _IsContactExistsWithNameProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [_isContactExistsWithName].
  _IsContactExistsWithNameProvider({
    String? contactName,
  }) : this._internal(
          (ref) => _isContactExistsWithName(
            ref as _IsContactExistsWithNameRef,
            contactName: contactName,
          ),
          from: _isContactExistsWithNameProvider,
          name: r'_isContactExistsWithNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isContactExistsWithNameHash,
          dependencies: _IsContactExistsWithNameFamily._dependencies,
          allTransitiveDependencies:
              _IsContactExistsWithNameFamily._allTransitiveDependencies,
          contactName: contactName,
        );

  _IsContactExistsWithNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.contactName,
  }) : super.internal();

  final String? contactName;

  @override
  Override overrideWith(
    FutureOr<bool> Function(_IsContactExistsWithNameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _IsContactExistsWithNameProvider._internal(
        (ref) => create(ref as _IsContactExistsWithNameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        contactName: contactName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _IsContactExistsWithNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _IsContactExistsWithNameProvider &&
        other.contactName == contactName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contactName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _IsContactExistsWithNameRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `contactName` of this provider.
  String? get contactName;
}

class _IsContactExistsWithNameProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with _IsContactExistsWithNameRef {
  _IsContactExistsWithNameProviderElement(super.provider);

  @override
  String? get contactName =>
      (origin as _IsContactExistsWithNameProvider).contactName;
}

String _$isContactExistsWithAddressHash() =>
    r'4a2281e577a2bfa9fee0005c51763af7ad2b687b';

/// See also [_isContactExistsWithAddress].
@ProviderFor(_isContactExistsWithAddress)
const _isContactExistsWithAddressProvider = _IsContactExistsWithAddressFamily();

/// See also [_isContactExistsWithAddress].
class _IsContactExistsWithAddressFamily extends Family<AsyncValue<bool>> {
  /// See also [_isContactExistsWithAddress].
  const _IsContactExistsWithAddressFamily();

  /// See also [_isContactExistsWithAddress].
  _IsContactExistsWithAddressProvider call({
    String? address,
  }) {
    return _IsContactExistsWithAddressProvider(
      address: address,
    );
  }

  @override
  _IsContactExistsWithAddressProvider getProviderOverride(
    covariant _IsContactExistsWithAddressProvider provider,
  ) {
    return call(
      address: provider.address,
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
  String? get name => r'_isContactExistsWithAddressProvider';
}

/// See also [_isContactExistsWithAddress].
class _IsContactExistsWithAddressProvider
    extends AutoDisposeFutureProvider<bool> {
  /// See also [_isContactExistsWithAddress].
  _IsContactExistsWithAddressProvider({
    String? address,
  }) : this._internal(
          (ref) => _isContactExistsWithAddress(
            ref as _IsContactExistsWithAddressRef,
            address: address,
          ),
          from: _isContactExistsWithAddressProvider,
          name: r'_isContactExistsWithAddressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isContactExistsWithAddressHash,
          dependencies: _IsContactExistsWithAddressFamily._dependencies,
          allTransitiveDependencies:
              _IsContactExistsWithAddressFamily._allTransitiveDependencies,
          address: address,
        );

  _IsContactExistsWithAddressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
  }) : super.internal();

  final String? address;

  @override
  Override overrideWith(
    FutureOr<bool> Function(_IsContactExistsWithAddressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _IsContactExistsWithAddressProvider._internal(
        (ref) => create(ref as _IsContactExistsWithAddressRef),
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
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _IsContactExistsWithAddressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _IsContactExistsWithAddressProvider &&
        other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _IsContactExistsWithAddressRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `address` of this provider.
  String? get address;
}

class _IsContactExistsWithAddressProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with _IsContactExistsWithAddressRef {
  _IsContactExistsWithAddressProviderElement(super.provider);

  @override
  String? get address =>
      (origin as _IsContactExistsWithAddressProvider).address;
}

String _$getBalanceHash() => r'6db260cee3bd0bcbe6222c6da8836d88feba18db';

/// See also [_getBalance].
@ProviderFor(_getBalance)
const _getBalanceProvider = _GetBalanceFamily();

/// See also [_getBalance].
class _GetBalanceFamily extends Family<AsyncValue<AccountBalance>> {
  /// See also [_getBalance].
  const _GetBalanceFamily();

  /// See also [_getBalance].
  _GetBalanceProvider call({
    String? address,
  }) {
    return _GetBalanceProvider(
      address: address,
    );
  }

  @override
  _GetBalanceProvider getProviderOverride(
    covariant _GetBalanceProvider provider,
  ) {
    return call(
      address: provider.address,
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
  String? get name => r'_getBalanceProvider';
}

/// See also [_getBalance].
class _GetBalanceProvider extends AutoDisposeFutureProvider<AccountBalance> {
  /// See also [_getBalance].
  _GetBalanceProvider({
    String? address,
  }) : this._internal(
          (ref) => _getBalance(
            ref as _GetBalanceRef,
            address: address,
          ),
          from: _getBalanceProvider,
          name: r'_getBalanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBalanceHash,
          dependencies: _GetBalanceFamily._dependencies,
          allTransitiveDependencies:
              _GetBalanceFamily._allTransitiveDependencies,
          address: address,
        );

  _GetBalanceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
  }) : super.internal();

  final String? address;

  @override
  Override overrideWith(
    FutureOr<AccountBalance> Function(_GetBalanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetBalanceProvider._internal(
        (ref) => create(ref as _GetBalanceRef),
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
  AutoDisposeFutureProviderElement<AccountBalance> createElement() {
    return _GetBalanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetBalanceProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetBalanceRef on AutoDisposeFutureProviderRef<AccountBalance> {
  /// The parameter `address` of this provider.
  String? get address;
}

class _GetBalanceProviderElement
    extends AutoDisposeFutureProviderElement<AccountBalance>
    with _GetBalanceRef {
  _GetBalanceProviderElement(super.provider);

  @override
  String? get address => (origin as _GetBalanceProvider).address;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
