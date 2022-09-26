/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/app_keychain.dart';
import 'package:aewallet/model/data/app_wallet.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/data/nft_infos_off_chain.dart';
import 'package:aewallet/model/data/price.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/model/data/token_informations_property.dart';
import 'package:aewallet/util/get_it_instance.dart';

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
    Hive.registerAdapter(AccountTokenAdapter());
    Hive.registerAdapter(TokenInformationsAdapter());
    Hive.registerAdapter(TokenInformationsPropertyAdapter());
    Hive.registerAdapter(NftInfosOffChainAdapter());
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
    for (Contact contact in contactsList) {
      if (contact.name!.contains(pattern)) {
        contactsListSelected.add(contact);
      }
    }
    return contactsListSelected;
  }

  Future<Contact?> getContactWithAddress(String address) async {
    String? lastAddress = (await sl
            .get<ApiService>()
            .getLastTransaction(address, request: 'address'))
        .address;
    if (lastAddress == null || lastAddress == '') {
      lastAddress = address;
    }
    final Box<Contact> box = await Hive.openBox<Contact>(contactsTable);
    final List<Contact> contactsList = box.values.toList();

    Contact? contactSelected;
    for (Contact contact in contactsList) {
      String? lastAddressContact = (await sl
              .get<ApiService>()
              .getLastTransaction(contact.address!, request: 'address'))
          .address;

      if (lastAddressContact == null || lastAddressContact == '') {
        lastAddressContact = contact.address!;
      } else {
        Contact contactToUpdate = contact;
        contactToUpdate.address = lastAddressContact;
        await sl.get<DBHelper>().saveContact(contactToUpdate);
      }
      if (lastAddressContact.toLowerCase() == lastAddress.toLowerCase()) {
        contactSelected = contact;
      }
    }
    return contactSelected;
  }

  Future<Contact> getContactWithName(String name) async {
    final Box<Contact> box = await Hive.openBox<Contact>(contactsTable);
    final List<Contact> contactsList = box.values.toList();
    Contact? contactSelected;
    for (Contact contact in contactsList) {
      if (contact.name!.toLowerCase() == name.toLowerCase()) {
        contactSelected = contact;
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
    for (Contact contact in contactsList) {
      if (contact.name!.toLowerCase() == name.toLowerCase()) {
        contactExists = true;
      }
    }
    return contactExists;
  }

  Future<bool> contactExistsWithAddress(String address) async {
    String? lastAddress = (await sl
            .get<ApiService>()
            .getLastTransaction(address, request: 'address'))
        .address;
    if (lastAddress == null || lastAddress == '') {
      lastAddress = address;
    }

    final Box<Contact> box = await Hive.openBox<Contact>(contactsTable);
    final List<Contact> contactsList = box.values.toList();
    bool contactExists = false;
    for (Contact contact in contactsList) {
      String lastAddressContact = (await sl
              .get<ApiService>()
              .getLastTransaction(contact.address!, request: 'address'))
          .address!;
      if (lastAddressContact == '') {
        lastAddressContact = contact.address!;
      }
      if (lastAddressContact
          .toLowerCase()
          .contains(lastAddress.toLowerCase())) {
        contactExists = true;
      }
    }
    return contactExists;
  }

  Future<void> saveContact(Contact contact) async {
    // ignore: prefer_final_locals
    Box<Contact> box = await Hive.openBox<Contact>(contactsTable);
    await box.put(contact.name, contact);
  }

  Future<void> deleteContact(Contact contact) async {
    // ignore: prefer_final_locals
    Box<Contact> box = await Hive.openBox<Contact>(contactsTable);
    await box.delete(contact.name);
  }

  Future<void> clearContacts() async {
    // ignore: prefer_final_locals
    Box<Contact> box = await Hive.openBox<Contact>(contactsTable);
    await box.clear();
  }

  Future<AppWallet> addAccount(Account account) async {
    Box<AppWallet> box = await Hive.openBox<AppWallet>(appWalletTable);
    AppWallet appWallet = box.get(0)!;
    appWallet.appKeychain!.accounts!.add(account);
    await box.putAt(0, appWallet);
    return appWallet;
  }

  Future<AppWallet> clearAccount() async {
    Box<AppWallet> box = await Hive.openBox<AppWallet>(appWalletTable);
    AppWallet appWallet = box.get(0)!;
    appWallet.appKeychain!.accounts!.clear();
    await box.putAt(0, appWallet);
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
    await box.putAt(0, appWallet);
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
        await box.putAt(0, appWallet);
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
        await box.putAt(0, appWallet);
        return;
      }
    }
  }

  Future<void> clearAppWallet() async {
    // ignore: prefer_final_locals
    Box<AppWallet> box = await Hive.openBox<AppWallet>(appWalletTable);
    await box.clear();
  }

  Future<AppWallet> createAppWallet(String seed, String keyChainAddress) async {
    // ignore: prefer_final_locals
    Box<AppWallet> box = await Hive.openBox<AppWallet>(appWalletTable);
    AppKeychain appKeychain =
        AppKeychain(address: keyChainAddress, accounts: <Account>[]);
    AppWallet appWallet = AppWallet(seed: seed, appKeychain: appKeychain);
    await box.add(appWallet);
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
      await box.add(price);
    } else {
      await box.putAt(0, price);
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
    await box.clear();
  }
}
