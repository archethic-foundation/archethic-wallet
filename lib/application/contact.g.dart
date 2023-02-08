// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

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

String $_contactRepositoryHash() => r'cf712b6cccb80060dda6cf8b5e0115332d394211';

/// See also [_contactRepository].
final _contactRepositoryProvider = AutoDisposeProvider<ContactRepository>(
  _contactRepository,
  name: r'_contactRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_contactRepositoryHash,
);
typedef _ContactRepositoryRef = AutoDisposeProviderRef<ContactRepository>;
String $_fetchContactsHash() => r'e577c0c6beecb77d4217b611093c1e6f9e62b8e2';

/// See also [_fetchContacts].
class _FetchContactsProvider extends AutoDisposeFutureProvider<List<Contact>> {
  _FetchContactsProvider({
    this.search = '',
  }) : super(
          (ref) => _fetchContacts(
            ref,
            search: search,
          ),
          from: _fetchContactsProvider,
          name: r'_fetchContactsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_fetchContactsHash,
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

typedef _FetchContactsRef = AutoDisposeFutureProviderRef<List<Contact>>;

/// See also [_fetchContacts].
final _fetchContactsProvider = _FetchContactsFamily();

class _FetchContactsFamily extends Family<AsyncValue<List<Contact>>> {
  _FetchContactsFamily();

  _FetchContactsProvider call({
    String search = '',
  }) {
    return _FetchContactsProvider(
      search: search,
    );
  }

  @override
  AutoDisposeFutureProvider<List<Contact>> getProviderOverride(
    covariant _FetchContactsProvider provider,
  ) {
    return call(
      search: provider.search,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_fetchContactsProvider';
}

String $_getSelectedContactHash() =>
    r'c7007a7b315479cced6245a02482fb73e0ad6b65';

/// See also [_getSelectedContact].
final _getSelectedContactProvider = AutoDisposeFutureProvider<Contact>(
  _getSelectedContact,
  name: r'_getSelectedContactProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_getSelectedContactHash,
);
typedef _GetSelectedContactRef = AutoDisposeFutureProviderRef<Contact>;
String $_getContactWithNameHash() =>
    r'7272ba74ac24402574cf64136acc86fa939f3ca3';

/// See also [_getContactWithName].
class _GetContactWithNameProvider extends AutoDisposeFutureProvider<Contact> {
  _GetContactWithNameProvider(
    this.name,
  ) : super(
          (ref) => _getContactWithName(
            ref,
            name,
          ),
          from: _getContactWithNameProvider,
          name: r'_getContactWithNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_getContactWithNameHash,
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

typedef _GetContactWithNameRef = AutoDisposeFutureProviderRef<Contact>;

/// See also [_getContactWithName].
final _getContactWithNameProvider = _GetContactWithNameFamily();

class _GetContactWithNameFamily extends Family<AsyncValue<Contact>> {
  _GetContactWithNameFamily();

  _GetContactWithNameProvider call(
    String name,
  ) {
    return _GetContactWithNameProvider(
      name,
    );
  }

  @override
  AutoDisposeFutureProvider<Contact> getProviderOverride(
    covariant _GetContactWithNameProvider provider,
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
  String? get name => r'_getContactWithNameProvider';
}

String $_getContactWithAddressHash() =>
    r'5d7e119dd654939aebe4963994fc8b0888a944c4';

/// See also [_getContactWithAddress].
class _GetContactWithAddressProvider
    extends AutoDisposeFutureProvider<Contact?> {
  _GetContactWithAddressProvider(
    this.address,
  ) : super(
          (ref) => _getContactWithAddress(
            ref,
            address,
          ),
          from: _getContactWithAddressProvider,
          name: r'_getContactWithAddressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_getContactWithAddressHash,
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

typedef _GetContactWithAddressRef = AutoDisposeFutureProviderRef<Contact?>;

/// See also [_getContactWithAddress].
final _getContactWithAddressProvider = _GetContactWithAddressFamily();

class _GetContactWithAddressFamily extends Family<AsyncValue<Contact?>> {
  _GetContactWithAddressFamily();

  _GetContactWithAddressProvider call(
    String address,
  ) {
    return _GetContactWithAddressProvider(
      address,
    );
  }

  @override
  AutoDisposeFutureProvider<Contact?> getProviderOverride(
    covariant _GetContactWithAddressProvider provider,
  ) {
    return call(
      provider.address,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_getContactWithAddressProvider';
}

String $_getContactWithPublicKeyHash() =>
    r'62108be30a37c84a8cde033d6705e9aecf8b355f';

/// See also [_getContactWithPublicKey].
class _GetContactWithPublicKeyProvider
    extends AutoDisposeFutureProvider<Contact> {
  _GetContactWithPublicKeyProvider(
    this.publicKey,
  ) : super(
          (ref) => _getContactWithPublicKey(
            ref,
            publicKey,
          ),
          from: _getContactWithPublicKeyProvider,
          name: r'_getContactWithPublicKeyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_getContactWithPublicKeyHash,
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

typedef _GetContactWithPublicKeyRef = AutoDisposeFutureProviderRef<Contact>;

/// See also [_getContactWithPublicKey].
final _getContactWithPublicKeyProvider = _GetContactWithPublicKeyFamily();

class _GetContactWithPublicKeyFamily extends Family<AsyncValue<Contact>> {
  _GetContactWithPublicKeyFamily();

  _GetContactWithPublicKeyProvider call(
    String publicKey,
  ) {
    return _GetContactWithPublicKeyProvider(
      publicKey,
    );
  }

  @override
  AutoDisposeFutureProvider<Contact> getProviderOverride(
    covariant _GetContactWithPublicKeyProvider provider,
  ) {
    return call(
      provider.publicKey,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_getContactWithPublicKeyProvider';
}

String $_saveContactHash() => r'618ffd2195caf59b253a4866ef3c259e29ddcba9';

/// See also [_saveContact].
class _SaveContactProvider extends AutoDisposeFutureProvider<void> {
  _SaveContactProvider({
    this.contact,
  }) : super(
          (ref) => _saveContact(
            ref,
            contact: contact,
          ),
          from: _saveContactProvider,
          name: r'_saveContactProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_saveContactHash,
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

typedef _SaveContactRef = AutoDisposeFutureProviderRef<void>;

/// See also [_saveContact].
final _saveContactProvider = _SaveContactFamily();

class _SaveContactFamily extends Family<AsyncValue<void>> {
  _SaveContactFamily();

  _SaveContactProvider call({
    Contact? contact,
  }) {
    return _SaveContactProvider(
      contact: contact,
    );
  }

  @override
  AutoDisposeFutureProvider<void> getProviderOverride(
    covariant _SaveContactProvider provider,
  ) {
    return call(
      contact: provider.contact,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_saveContactProvider';
}

String $_deleteContactHash() => r'2e752a050b11741ff8e7b5ace2b5688b5b0bfea9';

/// See also [_deleteContact].
class _DeleteContactProvider extends AutoDisposeFutureProvider<void> {
  _DeleteContactProvider({
    this.contact,
  }) : super(
          (ref) => _deleteContact(
            ref,
            contact: contact,
          ),
          from: _deleteContactProvider,
          name: r'_deleteContactProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_deleteContactHash,
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

typedef _DeleteContactRef = AutoDisposeFutureProviderRef<void>;

/// See also [_deleteContact].
final _deleteContactProvider = _DeleteContactFamily();

class _DeleteContactFamily extends Family<AsyncValue<void>> {
  _DeleteContactFamily();

  _DeleteContactProvider call({
    Contact? contact,
  }) {
    return _DeleteContactProvider(
      contact: contact,
    );
  }

  @override
  AutoDisposeFutureProvider<void> getProviderOverride(
    covariant _DeleteContactProvider provider,
  ) {
    return call(
      contact: provider.contact,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_deleteContactProvider';
}

String $_isContactExistsWithNameHash() =>
    r'af7f5b8a34da3b3530efd34c75a5a930c0576100';

/// See also [_isContactExistsWithName].
class _IsContactExistsWithNameProvider extends AutoDisposeFutureProvider<bool> {
  _IsContactExistsWithNameProvider({
    this.name,
  }) : super(
          (ref) => _isContactExistsWithName(
            ref,
            name: name,
          ),
          from: _isContactExistsWithNameProvider,
          name: r'_isContactExistsWithNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_isContactExistsWithNameHash,
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

typedef _IsContactExistsWithNameRef = AutoDisposeFutureProviderRef<bool>;

/// See also [_isContactExistsWithName].
final _isContactExistsWithNameProvider = _IsContactExistsWithNameFamily();

class _IsContactExistsWithNameFamily extends Family<AsyncValue<bool>> {
  _IsContactExistsWithNameFamily();

  _IsContactExistsWithNameProvider call({
    String? name,
  }) {
    return _IsContactExistsWithNameProvider(
      name: name,
    );
  }

  @override
  AutoDisposeFutureProvider<bool> getProviderOverride(
    covariant _IsContactExistsWithNameProvider provider,
  ) {
    return call(
      name: provider.name,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_isContactExistsWithNameProvider';
}

String $_isContactExistsWithAddressHash() =>
    r'4a2281e577a2bfa9fee0005c51763af7ad2b687b';

/// See also [_isContactExistsWithAddress].
class _IsContactExistsWithAddressProvider
    extends AutoDisposeFutureProvider<bool> {
  _IsContactExistsWithAddressProvider({
    this.address,
  }) : super(
          (ref) => _isContactExistsWithAddress(
            ref,
            address: address,
          ),
          from: _isContactExistsWithAddressProvider,
          name: r'_isContactExistsWithAddressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_isContactExistsWithAddressHash,
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

typedef _IsContactExistsWithAddressRef = AutoDisposeFutureProviderRef<bool>;

/// See also [_isContactExistsWithAddress].
final _isContactExistsWithAddressProvider = _IsContactExistsWithAddressFamily();

class _IsContactExistsWithAddressFamily extends Family<AsyncValue<bool>> {
  _IsContactExistsWithAddressFamily();

  _IsContactExistsWithAddressProvider call({
    String? address,
  }) {
    return _IsContactExistsWithAddressProvider(
      address: address,
    );
  }

  @override
  AutoDisposeFutureProvider<bool> getProviderOverride(
    covariant _IsContactExistsWithAddressProvider provider,
  ) {
    return call(
      address: provider.address,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_isContactExistsWithAddressProvider';
}
