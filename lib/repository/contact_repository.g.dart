// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_repository.dart';

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

String $contactRepositoryHash() => r'bafa28e36bec7fbefecdc51500caa24c688260ec';

/// See also [contactRepository].
final contactRepositoryProvider = AutoDisposeProvider<ContactRepository>(
  contactRepository,
  name: r'contactRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $contactRepositoryHash,
);
typedef ContactRepositoryRef = AutoDisposeProviderRef<ContactRepository>;
String $fetchContactsHash() => r'6e4d75a9b5bc23013a774602b19d887f40cfede6';

/// See also [fetchContacts].
class FetchContactsProvider extends AutoDisposeFutureProvider<List<Contact>> {
  FetchContactsProvider({
    this.search = '',
  }) : super(
          (ref) => fetchContacts(
            ref,
            search: search,
          ),
          from: fetchContactsProvider,
          name: r'fetchContactsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $fetchContactsHash,
        );

  final String search;

  @override
  bool operator ==(Object other) {
    return other is FetchContactsProvider && other.search == search;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, search.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef FetchContactsRef = AutoDisposeFutureProviderRef<List<Contact>>;

/// See also [fetchContacts].
final fetchContactsProvider = FetchContactsFamily();

class FetchContactsFamily extends Family<AsyncValue<List<Contact>>> {
  FetchContactsFamily();

  FetchContactsProvider call({
    String search = '',
  }) {
    return FetchContactsProvider(
      search: search,
    );
  }

  @override
  AutoDisposeFutureProvider<List<Contact>> getProviderOverride(
    covariant FetchContactsProvider provider,
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
  String? get name => r'fetchContactsProvider';
}
