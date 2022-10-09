/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_repository.g.dart';

@riverpod
ContactRepository contactRepository(ContactRepositoryRef ref) =>
    ContactRepository();

@riverpod
Future<List<Contact>> fetchContacts(
  FetchContactsRef ref, {
  String search = '',
}) async {
  if (search.isEmpty) {
    return ref.watch(contactRepositoryProvider).getAllContacts();
  }
  final searchedContacts =
      await ref.watch(contactRepositoryProvider).searchContacts(search: search);
  return searchedContacts;
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
}
