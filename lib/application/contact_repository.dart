/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_repository.g.dart';

@riverpod
ContactRepository _contactRepository(WidgetRef ref) => ContactRepository();

@riverpod
Future<List<Contact>> _fetchContacts(
  WidgetRef ref, {
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
Future<void> _saveContact(
  WidgetRef ref, {
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
  WidgetRef ref, {
  Contact? contact,
}) async {
  if (contact == null) {
    throw Exception('Contact is null');
  }
  ref.watch(_contactRepositoryProvider).deleteContact(contact);
  ref.invalidate(_contactRepositoryProvider);
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
              contact.name!.toLowerCase().contains(search.toLowerCase()),
        )
        .toList();
  }

  Future<void> saveContact(Contact newContact) async {
    await sl.get<DBHelper>().saveContact(newContact);
  }

  Future<void> deleteContact(Contact newContact) async {
    await sl.get<DBHelper>().deleteContact(newContact);
  }
}

abstract class ContactProviders {
  static final fetchContacts = _fetchContactsProvider;
  static final saveContact = _saveContactProvider;
  static final deleteContact = _deleteContactProvider;
}
