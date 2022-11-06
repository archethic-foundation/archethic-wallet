/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/util/get_it_instance.dart';
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
Future<Contact> _getContactWithName(
  _GetContactWithNameRef ref,
  String name,
) async {
  final searchedContact =
      await ref.watch(_contactRepositoryProvider).getContactWithName(name);
  return searchedContact;
}

@riverpod
Future<Contact> _getContactWithAddress(
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
    return sl.get<DBHelper>().contactExistsWithName('@$name');
  }

  Future<Contact> getContactWithName(String name) async {
    return sl.get<DBHelper>().getContactWithName(name);
  }

  Future<Contact> getContactWithAddress(String address) async {
    return sl.get<DBHelper>().getContactWithAddress(address);
  }

  Future<bool> isContactExistsWithAddress(String address) async {
    return sl.get<DBHelper>().contactExistsWithAddress(address);
  }

  Future<Contact> getContactWithPublicKey(String publicKey) async {
    return sl.get<DBHelper>().getContactWithPublicKey(publicKey);
  }
}

abstract class ContactProviders {
  static final fetchContacts = _fetchContactsProvider;
  static final isContactExistsWithName = _isContactExistsWithNameProvider;
  static final isContactExistsWithAddress = _isContactExistsWithAddressProvider;
  static final saveContact = _saveContactProvider;
  static final deleteContact = _deleteContactProvider;
  static final getContactWithName = _getContactWithNameProvider;
  static final getContactWithAddress = _getContactWithAddressProvider;
  static final getContactWithPublicKey = _getContactWithPublicKeyProvider;
}
