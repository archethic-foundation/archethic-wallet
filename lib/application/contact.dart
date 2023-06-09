/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact.g.dart';

@riverpod
ContactRepository _contactRepository(_ContactRepositoryRef ref) =>
    ContactRepository();

@riverpod
Future<List<Contact>> _fetchContacts(
  _FetchContactsRef ref, {
  String search = '',
}) async {
  if (search.isEmpty) {
    return ref.watch(_contactRepositoryProvider).getAllContacts();
  }
  final searchedContacts = await ref
      .watch(_contactRepositoryProvider)
      .searchContacts(search: search);
  return searchedContacts;
}

@riverpod
Future<Contact> _getSelectedContact(_GetSelectedContactRef ref) async {
  final selectedAccountNameDisplayed =
      await ref.watch(AccountProviders.selectedAccountNameDisplayed.future);
  if (selectedAccountNameDisplayed == null) throw Exception();

  return ref
      .watch(_getContactWithNameProvider(selectedAccountNameDisplayed).future);
}

@riverpod
Future<Contact> _getContactWithName(
  _GetContactWithNameRef ref,
  String name,
) async {
  final searchedContact = await ref
      .watch(
        _contactRepositoryProvider,
      )
      .getContactWithName(name);
  return searchedContact;
}

@riverpod
Future<Contact?> _getContactWithAddress(
  _GetContactWithAddressRef ref,
  String address,
) async {
  final searchedContact = await ref
      .watch(_contactRepositoryProvider)
      .getContactWithAddress(address);
  return searchedContact;
}

@riverpod
Future<Contact> _getContactWithPublicKey(
  _GetContactWithPublicKeyRef ref,
  String publicKey,
) async {
  final searchedContact = await ref
      .watch(_contactRepositoryProvider)
      .getContactWithPublicKey(publicKey);
  return searchedContact;
}

@riverpod
Future<Contact> _getContactWithGenesisPublicKey(
  _GetContactWithGenesisPublicKeyRef ref,
  String genesisPublicKey,
) async {
  final searchedContact = await ref
      .watch(_contactRepositoryProvider)
      .getContactWithGenesisPublicKey(genesisPublicKey);
  return searchedContact;
}

@riverpod
Future<void> _saveContact(
  _SaveContactRef ref, {
  Contact? contact,
}) async {
  if (contact == null) {
    throw Exception('Contact is null');
  }
  ref.watch(_contactRepositoryProvider).saveContact(contact);
  ref.invalidate(_contactRepositoryProvider);
}

@riverpod
Future<void> _deleteContact(
  _DeleteContactRef ref, {
  Contact? contact,
}) async {
  if (contact == null) {
    throw Exception('Contact is null');
  }
  ref.watch(_contactRepositoryProvider).deleteContact(contact);
  ref.invalidate(_contactRepositoryProvider);
}

@riverpod
Future<bool> _isContactExistsWithName(
  _IsContactExistsWithNameRef ref, {
  String? name,
}) async {
  if (name == null) {
    throw Exception('Name is null');
  }
  return ref.watch(_contactRepositoryProvider).isContactExistsWithName(name);
}

@riverpod
Future<bool> _isContactExistsWithAddress(
  _IsContactExistsWithAddressRef ref, {
  String? address,
}) async {
  if (address == null) {
    throw Exception('Address is null');
  }
  return ref
      .watch(_contactRepositoryProvider)
      .isContactExistsWithAddress(address);
}

class ContactRepository {
  Future<List<Contact>> getAllContacts() async {
    return sl.get<DBHelper>().getContacts();
  }

  Future<List<Contact>> searchContacts({required String search}) async {
    final contacts = await sl.get<DBHelper>().getContacts();
    return contacts
        .where(
          (contact) =>
              contact.name.toLowerCase().contains(search.toLowerCase()),
        )
        .toList();
  }

  Future<void> saveContact(Contact newContact) async {
    await sl.get<DBHelper>().saveContact(newContact);
  }

  Future<void> deleteContact(Contact newContact) async {
    await sl.get<DBHelper>().deleteContact(newContact);
  }

  Future<bool> isContactExistsWithName(String name) async {
    return sl.get<DBHelper>().contactExistsWithName(name);
  }

  Future<Contact> getContactWithName(String name) async {
    return sl.get<DBHelper>().getContactWithName(name);
  }

  Future<Contact?> getContactWithAddress(String address) async {
    return sl.get<DBHelper>().getContactWithAddress(address);
  }

  Future<bool> isContactExistsWithAddress(String address) async {
    return sl.get<DBHelper>().contactExistsWithAddress(address);
  }

  Future<Contact> getContactWithPublicKey(String publicKey) async {
    return sl.get<DBHelper>().getContactWithPublicKey(publicKey);
  }

  Future<Contact> getContactWithGenesisPublicKey(
      String genesisPublicKey) async {
    return sl.get<DBHelper>().getContactWithGenesisPublicKey(genesisPublicKey);
  }

  Future<void> clear() async {
    await sl.get<DBHelper>().clearContacts();
  }
}

abstract class ContactProviders {
  static const fetchContacts = _fetchContactsProvider;
  static const isContactExistsWithName = _isContactExistsWithNameProvider;
  static const isContactExistsWithAddress = _isContactExistsWithAddressProvider;
  static const saveContact = _saveContactProvider;
  static const deleteContact = _deleteContactProvider;
  static const getContactWithName = _getContactWithNameProvider;
  static const getContactWithAddress = _getContactWithAddressProvider;
  static const getContactWithPublicKey = _getContactWithPublicKeyProvider;
  static const getContactWithGenesisPublicKey =
      _getContactWithGenesisPublicKeyProvider;
  static final getSelectedContact = _getSelectedContactProvider;

  static Future<void> reset(Ref ref) async {
    await ref.read(_contactRepositoryProvider).clear();
    ref
      ..invalidate(fetchContacts)
      ..invalidate(isContactExistsWithName)
      ..invalidate(isContactExistsWithAddress)
      ..invalidate(getContactWithName)
      ..invalidate(getContactWithAddress)
      ..invalidate(getContactWithPublicKey)
      ..invalidate(getContactWithGenesisPublicKey)
      ..invalidate(getSelectedContact);
  }
}
