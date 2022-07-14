/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:core/model/data/account.dart';
import 'package:core/model/data/app_keychain.dart';
import 'package:core/model/data/app_wallet.dart';
import 'package:core/model/data/contact.dart';
import 'package:core/model/data/price.dart';
import 'package:core/model/data/recent_transaction.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'package:core/model/data/account_balance.dart';

class DBHelper {
  static const String contactsTable = 'contacts';
  static const String appWalletTable = 'appWallet';
  static const String priceTable = 'price';

  static Future<void> setupDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ContactAdapter());
    Hive.registerAdapter(AppWalletAdapter());
    Hive.registerAdapter(AccountBalanceAdapter());
    Hive.registerAdapter(AccountAdapter());
    Hive.registerAdapter(AppKeychainAdapter());
    Hive.registerAdapter(RecentTransactionAdapter());
    Hive.registerAdapter(PriceAdapter());
  }

  // Contacts
  Future<List<Contact>> getContacts() async {
    final Box<Contact> box = await Hive.openBox<Contact>(contactsTable);
    final List<Contact> contactsList = box.values.toList();
    contactsList.sort((Contact a, Contact b) =>
        a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
    return contactsList;
  }

  Future<List<Contact>> getContactsWithNameLike(String pattern) async {
    final Box<Contact> box = await Hive.openBox<Contact>(contactsTable);
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

  Future<Contact?> getContactWithAddress(String address) async {
    final Box<Contact> box = await Hive.openBox<Contact>(contactsTable);
    final List<Contact> contactsList = box.values.toList();

    Contact? contactSelected;
    for (Contact _contact in contactsList) {
      if (_contact.address!.toLowerCase().contains(address.toLowerCase())) {
        contactSelected = _contact;
      }
    }
    return contactSelected;
  }

  Future<Contact> getContactWithName(String name) async {
    final Box<Contact> box = await Hive.openBox<Contact>(contactsTable);
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
    final Box<Contact> box = await Hive.openBox<Contact>(contactsTable);
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
    final Box<Contact> box = await Hive.openBox<Contact>(contactsTable);
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
    Box<Contact> box = await Hive.openBox<Contact>(contactsTable);
    box.put(contact.address, contact);
  }

  Future<void> deleteContact(Contact contact) async {
    // ignore: prefer_final_locals
    Box<Contact> box = await Hive.openBox<Contact>(contactsTable);
    box.delete(contact.address);
  }

  Future<void> clearContacts() async {
    // ignore: prefer_final_locals
    Box<Contact> box = await Hive.openBox<Contact>(contactsTable);
    box.clear();
  }

  Future<AppWallet> addAccount(Account account) async {
    Box<AppWallet> box = await Hive.openBox<AppWallet>(appWalletTable);
    AppWallet appWallet = box.get(0)!;
    appWallet.appKeychain!.accounts!.add(account);
    box.put(0, appWallet);
    return appWallet;
  }

  Future<AppWallet> clearAccount() async {
    Box<AppWallet> box = await Hive.openBox<AppWallet>(appWalletTable);
    AppWallet appWallet = box.get(0)!;
    appWallet.appKeychain!.accounts!.clear();
    box.put(0, appWallet);
    return appWallet;
  }

  Future<AppWallet> changeAccount(Account account) async {
    Box<AppWallet> box = await Hive.openBox<AppWallet>(appWalletTable);
    AppWallet appWallet = box.get(0)!;
    for (int i = 0; i < appWallet.appKeychain!.accounts!.length; i++) {
      if (appWallet.appKeychain!.accounts![i].name == account.name) {
        appWallet.appKeychain!.accounts![i].selected = true;
      } else {
        appWallet.appKeychain!.accounts![i].selected = false;
      }
    }
    box.put(0, appWallet);
    return appWallet;
  }

  Future<void> updateAccountBalance(
      Account selectedAccount, AccountBalance balance) async {
    // ignore: prefer_final_locals
    Box<AppWallet> box = await Hive.openBox<AppWallet>(appWalletTable);
    AppWallet appWallet = box.get(0)!;
    List<Account> accounts = appWallet.appKeychain!.accounts!;
    for (Account account in accounts) {
      if (selectedAccount.name == account.name) {
        account.balance = balance;
        box.putAt(0, appWallet);
        return;
      }
    }
  }

  Future<void> updateAccount(Account selectedAccount) async {
    // ignore: prefer_final_locals
    Box<AppWallet> box = await Hive.openBox<AppWallet>(appWalletTable);
    AppWallet appWallet = box.get(0)!;
    List<Account> accounts = appWallet.appKeychain!.accounts!;
    for (Account account in accounts) {
      if (selectedAccount.name == account.name) {
        account = selectedAccount;
        box.putAt(0, appWallet);
        return;
      }
    }
  }

  Future<void> clearAppWallet() async {
    // ignore: prefer_final_locals
    Box<AppWallet> box = await Hive.openBox<AppWallet>(appWalletTable);
    box.clear();
  }

  Future<AppWallet> createAppWallet(String seed, String keyChainAddress) async {
    // ignore: prefer_final_locals
    Box<AppWallet> box = await Hive.openBox<AppWallet>(appWalletTable);
    AppKeychain appKeychain =
        AppKeychain(address: keyChainAddress, accounts: <Account>[]);
    AppWallet appWallet = AppWallet(seed: seed, appKeychain: appKeychain);
    box.add(appWallet);
    return appWallet;
  }

  Future<AppWallet?> getAppWallet() async {
    // ignore: prefer_final_locals
    Box<AppWallet> box = await Hive.openBox<AppWallet>(appWalletTable);
    return box.getAt(0);
  }

  Future<void> clearAll() async {
    await clearAppWallet();
    await clearContacts();
    await clearPrice();
  }

  Future<void> updatePrice(Price price) async {
    // ignore: prefer_final_locals
    Box<Price> box = await Hive.openBox<Price>(priceTable);
    if (box.isEmpty) {
      box.add(price);
    } else {
      box.putAt(0, price);
    }
  }

  Future<Price?> getPrice() async {
    // ignore: prefer_final_locals
    Box<Price> box = await Hive.openBox<Price>(priceTable);
    return box.getAt(0);
  }

  Future<void> clearPrice() async {
    // ignore: prefer_final_locals
    Box<Price> box = await Hive.openBox<Price>(priceTable);
    box.clear();
  }
}
