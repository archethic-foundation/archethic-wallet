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

typedef _FetchContactsRef = AutoDisposeFutureProviderRef<List<Contact>>;

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
    this.search = '',
  }) : super.internal(
          (ref) => _fetchContacts(
            ref,
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
        );

  final String search;

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

String _$getSelectedContactHash() =>
    r'b76abfb987991770f9866447bd0d5b025705d7d9';

/// See also [_getSelectedContact].
@ProviderFor(_getSelectedContact)
final _getSelectedContactProvider = AutoDisposeFutureProvider<Contact>.internal(
  _getSelectedContact,
  name: r'_getSelectedContactProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getSelectedContactHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetSelectedContactRef = AutoDisposeFutureProviderRef<Contact>;
String _$getContactWithNameHash() =>
    r'7272ba74ac24402574cf64136acc86fa939f3ca3';
typedef _GetContactWithNameRef = AutoDisposeFutureProviderRef<Contact>;

/// See also [_getContactWithName].
@ProviderFor(_getContactWithName)
const _getContactWithNameProvider = _GetContactWithNameFamily();

/// See also [_getContactWithName].
class _GetContactWithNameFamily extends Family<AsyncValue<Contact>> {
  /// See also [_getContactWithName].
  const _GetContactWithNameFamily();

  /// See also [_getContactWithName].
  _GetContactWithNameProvider call(
    String name,
  ) {
    return _GetContactWithNameProvider(
      name,
    );
  }

  @override
  _GetContactWithNameProvider getProviderOverride(
    covariant _GetContactWithNameProvider provider,
  ) {
    return call(
      provider.name,
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
class _GetContactWithNameProvider extends AutoDisposeFutureProvider<Contact> {
  /// See also [_getContactWithName].
  _GetContactWithNameProvider(
    this.name,
  ) : super.internal(
          (ref) => _getContactWithName(
            ref,
            name,
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
        );

  final String name;

  @override
  bool operator ==(Object other) {
    return other is _GetContactWithNameProvider && other.name == name;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, name.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getContactWithAddressHash() =>
    r'5d7e119dd654939aebe4963994fc8b0888a944c4';
typedef _GetContactWithAddressRef = AutoDisposeFutureProviderRef<Contact?>;

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
    this.address,
  ) : super.internal(
          (ref) => _getContactWithAddress(
            ref,
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
        );

  final String address;

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

String _$getContactWithPublicKeyHash() =>
    r'9f398d381eb5fedeba4fa599ebdee44f8f405d03';
typedef _GetContactWithPublicKeyRef = AutoDisposeFutureProviderRef<Contact?>;

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
    this.publicKey,
  ) : super.internal(
          (ref) => _getContactWithPublicKey(
            ref,
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
        );

  final String publicKey;

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

String _$getContactWithGenesisPublicKeyHash() =>
    r'ba5b98ca4aea9d1f0bcab19a0ba1b455fea93b63';
typedef _GetContactWithGenesisPublicKeyRef
    = AutoDisposeFutureProviderRef<Contact?>;

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
    this.genesisPublicKey,
  ) : super.internal(
          (ref) => _getContactWithGenesisPublicKey(
            ref,
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
        );

  final String genesisPublicKey;

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

String _$saveContactHash() => r'618ffd2195caf59b253a4866ef3c259e29ddcba9';
typedef _SaveContactRef = AutoDisposeFutureProviderRef<void>;

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
    this.contact,
  }) : super.internal(
          (ref) => _saveContact(
            ref,
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
        );

  final Contact? contact;

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

String _$deleteContactHash() => r'2e752a050b11741ff8e7b5ace2b5688b5b0bfea9';
typedef _DeleteContactRef = AutoDisposeFutureProviderRef<void>;

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
    this.contact,
  }) : super.internal(
          (ref) => _deleteContact(
            ref,
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
        );

  final Contact? contact;

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

String _$isContactExistsWithNameHash() =>
    r'af7f5b8a34da3b3530efd34c75a5a930c0576100';
typedef _IsContactExistsWithNameRef = AutoDisposeFutureProviderRef<bool>;

/// See also [_isContactExistsWithName].
@ProviderFor(_isContactExistsWithName)
const _isContactExistsWithNameProvider = _IsContactExistsWithNameFamily();

/// See also [_isContactExistsWithName].
class _IsContactExistsWithNameFamily extends Family<AsyncValue<bool>> {
  /// See also [_isContactExistsWithName].
  const _IsContactExistsWithNameFamily();

  /// See also [_isContactExistsWithName].
  _IsContactExistsWithNameProvider call({
    String? name,
  }) {
    return _IsContactExistsWithNameProvider(
      name: name,
    );
  }

  @override
  _IsContactExistsWithNameProvider getProviderOverride(
    covariant _IsContactExistsWithNameProvider provider,
  ) {
    return call(
      name: provider.name,
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
    this.name,
  }) : super.internal(
          (ref) => _isContactExistsWithName(
            ref,
            name: name,
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
        );

  final String? name;

  @override
  bool operator ==(Object other) {
    return other is _IsContactExistsWithNameProvider && other.name == name;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, name.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$isContactExistsWithAddressHash() =>
    r'4a2281e577a2bfa9fee0005c51763af7ad2b687b';
typedef _IsContactExistsWithAddressRef = AutoDisposeFutureProviderRef<bool>;

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
    this.address,
  }) : super.internal(
          (ref) => _isContactExistsWithAddress(
            ref,
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
        );

  final String? address;

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
