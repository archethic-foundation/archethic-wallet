/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'package:core/model/data/hive_db.dart';

class DBHelper {
  static const String _contactsTable = 'contacts';
  static const String _accountsTable = 'accounts';

  static Future<void> setupDatabase() async {
    if (!kIsWeb) {
      await Hive.initFlutter();
    }
    Hive.registerAdapter(ContactAdapter());
    Hive.registerAdapter(AccountAdapter());
  }

  // Contacts
  Future<List<Contact>> getContacts() async {
    final Box<Contact> box = await Hive.openBox<Contact>(_contactsTable);
    final List<Contact> contactsList = box.values.toList();
    return contactsList;
  }

  Future<List<Contact>> getContactsWithNameLike(String pattern) async {
    final Box<Contact> box = await Hive.openBox<Contact>(_contactsTable);
    final List<Contact> contactsList = box.values.toList();
    // ignore: prefer_final_locals
    List<Contact> contactsListSelected = List<Contact>.empty(growable: true);
    for (Contact _contact in contactsList) {
      if (_contact.name!.contains(pattern)) {
        contactsListSelected.add(_contact);
      }
    }
    return contactsListSelected;
  }

  Future<Contact> getContactWithAddress(String address) async {
    final Box<Contact> box = await Hive.openBox<Contact>(_contactsTable);
    final List<Contact> contactsList = box.values.toList();

    Contact? contactSelected;
    for (Contact _contact in contactsList) {
      if (_contact.address!.toLowerCase().contains(address.toLowerCase())) {
        contactSelected = _contact;
      }
    }
    if (contactSelected == null) {
      throw Exception();
    } else {
      return contactSelected;
    }
  }

  Future<Contact> getContactWithName(String name) async {
    final Box<Contact> box = await Hive.openBox<Contact>(_contactsTable);
    final List<Contact> contactsList = box.values.toList();
    Contact? contactSelected;
    for (Contact _contact in contactsList) {
      if (_contact.name!.toLowerCase() == name.toLowerCase()) {
        contactSelected = _contact;
      }
    }
    if (contactSelected == null) {
      throw Exception();
    } else {
      return contactSelected;
    }
  }

  Future<bool> contactExistsWithName(String name) async {
    final Box<Contact> box = await Hive.openBox<Contact>(_contactsTable);
    final List<Contact> contactsList = box.values.toList();
    bool contactExists = false;
    for (Contact _contact in contactsList) {
      if (_contact.name!.toLowerCase() == name.toLowerCase()) {
        contactExists = true;
      }
    }
    return contactExists;
  }

  Future<bool> contactExistsWithAddress(String address) async {
    final Box<Contact> box = await Hive.openBox<Contact>(_contactsTable);
    final List<Contact> contactsList = box.values.toList();
    bool contactExists = false;
    for (Contact _contact in contactsList) {
      if (_contact.address!.toLowerCase().contains(address.toLowerCase())) {
        contactExists = true;
      }
    }
    return contactExists;
  }

  Future<void> saveContact(Contact contact) async {
    // ignore: prefer_final_locals
    Box<Contact> box = await Hive.openBox<Contact>(_contactsTable);
    box.put(contact.address, contact);
  }

  Future<void> deleteContact(Contact contact) async {
    // ignore: prefer_final_locals
    Box<Contact> box = await Hive.openBox<Contact>(_contactsTable);
    box.delete(contact.address);
  }

  Future<Account> addAccount(Account account) async {
    Box<Account> box = await Hive.openBox<Account>(_accountsTable);
    box.put(account.name, account);
    return account;
  }

  Future<List<Account>> getRecentlyUsedAccounts() async {
    final Box<Account> box = await Hive.openBox<Account>(_accountsTable);
    final List<Account> accounts = box.values.toList();
    accounts
        .sort((Account a, Account b) => a.lastAccess!.compareTo(b.lastAccess!));
    return accounts;
  }

  Future<void> changeAccount(Account account) async {
    Box<Account> box = await Hive.openBox<Account>(_accountsTable);
    final List<Account> accountsList = box.values.toList();
    int maxLastAccessed = 0;
    for (Account _account in accountsList) {
      _account.selected = false;
      box.put(_account.name, _account);
      if (_account.lastAccess != null &&
          maxLastAccessed < _account.lastAccess!) {
        maxLastAccessed = _account.lastAccess!;
      }
    }
    account.selected = true;
    account.lastAccess = maxLastAccessed + 1;
    box.put(account.name, account);
  }

  Future<void> hideAccount(Account account) async {
    // ignore: prefer_final_locals
    Box<Account> box = await Hive.openBox<Account>(_accountsTable);
    box.delete(account.name);
  }

  Future<void> updateAccountBalance(Account account, String balance) async {
    // ignore: prefer_final_locals
    Box<Account> box = await Hive.openBox<Account>(_accountsTable);
    account.balance = balance;
    box.put(account.name, account);
  }

  Future<Account?> getSelectedAccount() async {
    final Box<Account> box = await Hive.openBox<Account>(_accountsTable);
    final List<Account> accountsList = box.values.toList();
    Account? accountSelected;
    for (Account _account in accountsList) {
      if (_account.selected!) {
        accountSelected = _account;
      }
    }
    return accountSelected;
  }

  Future<void> dropAccounts() async {
    // ignore: prefer_final_locals
    Box<Account> box = await Hive.openBox<Account>(_accountsTable);
    box.clear();
  }

  Future<void> dropAll() async {
    // ignore: prefer_final_locals
    Box<Account> boxAccounts = await Hive.openBox<Account>(_accountsTable);
    // ignore: prefer_final_locals
    Box<Contact> boxContacts = await Hive.openBox<Contact>(_contactsTable);
    boxAccounts.clear();
    boxContacts.clear();
  }
}
