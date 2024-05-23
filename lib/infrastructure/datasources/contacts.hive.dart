import 'dart:developer';

import 'package:aewallet/infrastructure/datasources/hive.extension.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:hive/hive.dart';

class ContactsHiveDatasource {
  ContactsHiveDatasource._();

  factory ContactsHiveDatasource.instance() {
    return _instance ?? (_instance = ContactsHiveDatasource._());
  }

  static ContactsHiveDatasource? _instance;

  static const String contactsTable = 'contacts';

  Future<List<Contact>> getContacts() async {
    final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList()
      ..sort(
        (Contact a, Contact b) =>
            a.format.toLowerCase().compareTo(b.format.toLowerCase()),
      );
    return contactsList;
  }

  Future<List<Contact>> getContactsWithNameLike(String pattern) async {
    final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList();

    final contactsListSelected = List<Contact>.empty(growable: true);
    for (final contact in contactsList) {
      if (contact.format.contains(pattern)) {
        contactsListSelected.add(contact);
      }
    }
    return contactsListSelected;
  }

  Future<Contact?> getContactWithAddress(String address) async {
    final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList();
    final addressContact = <String>[];
    for (final contact in contactsList) {
      if (address == contact.address) {
        return contact;
      }

      addressContact.add(contact.address);
    }

    final lastTransactionMap = await sl.get<ApiService>().getLastTransaction(
      [address, ...addressContact],
      request: 'address',
    );

    var lastAddress = '';
    if (lastTransactionMap[address] != null) {
      lastAddress = lastTransactionMap[address]!.address!.address ?? '';
    }
    if (lastAddress == '') {
      lastAddress = address;
    }

    Contact? contactSelected;
    for (final contact in contactsList) {
      var lastAddressContact = '';
      if (lastTransactionMap[contact.address] != null &&
          lastTransactionMap[contact.address]!.address != null) {
        lastAddressContact =
            lastTransactionMap[contact.address]!.address!.address!;
      }

      if (lastAddressContact.isEmpty) {
        lastAddressContact = contact.address;
      } else {
        final contactToUpdate = contact..address = lastAddressContact;
        await saveContact(contactToUpdate);
      }
      if (lastAddressContact.toLowerCase() == lastAddress.toLowerCase()) {
        contactSelected = contact;
      }
    }
    return contactSelected;
  }

  Future<Contact> getContactWithPublicKey(String publicKey) async {
    Contact? contactSelected;

    final address = hash(publicKey);
    log('address contact: ${uint8ListToHex(address)}');
    contactSelected = await getContactWithAddress(uint8ListToHex(address));

    if (contactSelected == null) {
      throw Exception();
    } else {
      return contactSelected;
    }
  }

  Future<Contact> getContactWithGenesisPublicKey(
    String genesisPublicKey,
  ) async {
    Contact? contactSelected;
    final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList();

    for (final contact in contactsList) {
      if (contact.publicKey.toLowerCase() == genesisPublicKey.toLowerCase()) {
        contactSelected = contact;
      }
    }
    if (contactSelected == null) {
      throw Exception();
    } else {
      return contactSelected;
    }
  }

  Future<Contact?> getContactWithName(String contactName) async {
    final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList();
    Contact? contactSelected;
    final nameWithoutAt = contactName.startsWith('@')
        ? contactName.replaceFirst('@', '')
        : contactName;

    for (final contact in contactsList) {
      if (contact.name.replaceFirst('@', '').toLowerCase() ==
          Uri.encodeFull(nameWithoutAt).toLowerCase()) {
        contactSelected = contact;
      }
    }
    return contactSelected;
  }

  Future<bool> contactExistsWithName(String contactName) async {
    return await getContactWithName(contactName) != null;
  }

  Future<bool> contactExistsWithAddress(String address) async {
    // TODO(reddwarf03): Create similar behaviour with contactExistsWithName (3)
    final _contact = await getContactWithAddress(address);
    if (_contact == null) {
      return false;
    }
    return true;
  }

  Future<void> saveContact(Contact contact) async {
    final box = await Hive.openBox<Contact>(contactsTable);
    await box.put(contact.name, contact);
  }

  Future<void> deleteContact(Contact contact) async {
    final box = await Hive.openBox<Contact>(contactsTable);
    await box.delete(contact.name);
  }

  Future<void> deleteContactByName(String name) async {
    final box = await Hive.openBox<Contact>(contactsTable);
    await box.delete(name);
  }

  Future<void> deleteContactByType(String type) async {
    final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList();
    for (final contact in contactsList) {
      if (contact.type.toLowerCase() == type.toLowerCase()) {
        await box.delete(contact.name);
      }
    }
  }

  Future<void> clearContacts() async {
    await Hive.deleteBox<Contact>(contactsTable);
  }
}
