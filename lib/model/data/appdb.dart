/// SPDX-License-Identifier: AGPL-3.0-or-later
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
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
    // TODO(chralu): How to remove this adapter annd the unused hive class
    Hive.registerAdapter(TokenInformationsPropertyAdapter());
    Hive.registerAdapter(NftInfosOffChainAdapter());
  }

  // Contacts
  Future<List<Contact>> getContacts() async {
    final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList();
    contactsList.sort(
      (Contact a, Contact b) =>
          a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );
    return contactsList;
  }

  Future<List<Contact>> getContactsWithNameLike(String pattern) async {
    final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList();
    // ignore: prefer_final_locals
    var contactsListSelected = List<Contact>.empty(growable: true);
    for (final contact in contactsList) {
      if (contact.name.contains(pattern)) {
        contactsListSelected.add(contact);
      }
    }
    return contactsListSelected;
  }

  Future<Contact?> getContactWithAddress(String address) async {
    var lastAddress = (await sl
            .get<ApiService>()
            .getLastTransaction(address, request: 'address'))
        .address;
    if (lastAddress == null || lastAddress == '') {
      lastAddress = address;
    }
    final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList();
    Contact? contactSelected;
    for (final contact in contactsList) {
      var lastAddressContact = (await sl
              .get<ApiService>()
              .getLastTransaction(contact.address, request: 'address'))
          .address;

      if (lastAddressContact == null || lastAddressContact.isEmpty) {
        lastAddressContact = contact.address;
      } else {
        final contactToUpdate = contact;
        contactToUpdate.address = lastAddressContact;
        await sl.get<DBHelper>().saveContact(contactToUpdate);
      }
      if (lastAddressContact.toLowerCase() == lastAddress.toLowerCase()) {
        contactSelected = contact;
      }
    }
    return contactSelected;
  }

  Future<Contact> getContactWithPublicKey(String publicKey) async {
    Contact? contactSelected;
    if (contactSelected == null) {
      throw Exception();
    } else {
      return contactSelected;
    }
    // TODO(reddwarf03): need feature in node: https://github.com/archethic-foundation/archethic-node/issues/670
    /* final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList();
    Contact? contactSelected;
    for (final contact in contactsList) {
      var lastAddressContact = (await sl
              .get<ApiService>()
              .getLastTransaction(contact.address, request: 'address'))
          .address;

      if (lastAddressContact == null || lastAddressContact.isEmpty) {
        lastAddressContact = contact.address;
      } else {
        final contactToUpdate = contact;
        contactToUpdate.address = lastAddressContact;
        await sl.get<DBHelper>().saveContact(contactToUpdate);
      }
      if (lastAddressContact.toLowerCase() == lastAddress.toLowerCase()) {
        contactSelected = contact;
      }
    }
    if (contactSelected == null) {
      throw Exception();
    } else {
      return contactSelected;
    }*/
  }

  Future<Contact> getContactWithName(String name) async {
    final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList();
    Contact? contactSelected;
    final nameWithAt = name.startsWith('@') ? name : '@$name';

    for (final contact in contactsList) {
      if (contact.name.toLowerCase() == nameWithAt.toLowerCase()) {
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
    final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList();
    var contactExists = false;
    for (final contact in contactsList) {
      if (contact.name.toLowerCase() == name.toLowerCase()) {
        contactExists = true;
      }
    }
    return contactExists;
  }

  Future<bool> contactExistsWithAddress(String address) async {
    var lastAddress = (await sl
            .get<ApiService>()
            .getLastTransaction(address, request: 'address'))
        .address;
    if (lastAddress == null || lastAddress == '') {
      lastAddress = address;
    }

    final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList();
    var contactExists = false;
    for (final contact in contactsList) {
      var lastAddressContact = (await sl
              .get<ApiService>()
              .getLastTransaction(contact.address, request: 'address'))
          .address!;
      if (lastAddressContact == '') {
        lastAddressContact = contact.address;
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
    var box = await Hive.openBox<Contact>(contactsTable);
    await box.put(contact.name, contact);
  }

  Future<void> deleteContact(Contact contact) async {
    // ignore: prefer_final_locals
    var box = await Hive.openBox<Contact>(contactsTable);
    await box.delete(contact.name);
  }

  Future<void> clearContacts() async {
    // ignore: prefer_final_locals
    var box = await Hive.openBox<Contact>(contactsTable);
    await box.clear();
  }

  Future<List<Account>> getAccounts() async {
    final box = await Hive.openBox<AppWallet>(appWalletTable);
    final appWallet = box.get(0)!;
    return appWallet.appKeychain.accounts;
  }

  Future<Account?> getAccount(String name) async {
    final box = await Hive.openBox<AppWallet>(appWalletTable);
    final appWallet = box.get(0)!;
    for (final account in appWallet.appKeychain.accounts) {
      if (account.name == name) return account;
    }
    return null;
  }

  Future<AppWallet> addAccount(Account account) async {
    final box = await Hive.openBox<AppWallet>(appWalletTable);
    final appWallet = box.get(0)!;
    appWallet.appKeychain.accounts.add(account);
    await box.putAt(0, appWallet);
    return appWallet;
  }

  Future<AppWallet> clearAccount() async {
    final box = await Hive.openBox<AppWallet>(appWalletTable);
    final appWallet = box.get(0)!;
    appWallet.appKeychain.accounts.clear();
    await box.putAt(0, appWallet);
    return appWallet;
  }

  Future<AppWallet> changeAccount(String accountName) async {
    final box = await Hive.openBox<AppWallet>(appWalletTable);
    final appWallet = box.get(0)!;
    for (var i = 0; i < appWallet.appKeychain.accounts.length; i++) {
      if (appWallet.appKeychain.accounts[i].name == accountName) {
        appWallet.appKeychain.accounts[i].selected = true;
      } else {
        appWallet.appKeychain.accounts[i].selected = false;
      }
    }
    await box.putAt(0, appWallet);
    return appWallet;
  }

  Future<void> updateAccountBalance(
    Account selectedAccount,
    AccountBalance balance,
  ) async {
    // ignore: prefer_final_locals
    var box = await Hive.openBox<AppWallet>(appWalletTable);
    final appWallet = box.get(0)!;
    final accounts = appWallet.appKeychain.accounts;
    for (final account in accounts) {
      if (selectedAccount.name == account.name) {
        account.balance = balance;
        await box.putAt(0, appWallet);
        return;
      }
    }
  }

  Future<void> updateAccount(Account selectedAccount) async {
    // ignore: prefer_final_locals
    var box = await Hive.openBox<AppWallet>(appWalletTable);
    final appWallet = box.get(0)!;
    appWallet.appKeychain.accounts = appWallet.appKeychain.accounts.map(
      (account) {
        if (account.name == selectedAccount.name) return selectedAccount;
        return account;
      },
    ).toList();
    await box.putAt(0, appWallet);
  }

  Future<void> clearAppWallet() async {
    // ignore: prefer_final_locals
    var box = await Hive.openBox<AppWallet>(appWalletTable);
    await box.clear();
  }

  Future<AppWallet> createAppWallet(String seed, String keyChainAddress) async {
    // ignore: prefer_final_locals
    var box = await Hive.openBox<AppWallet>(appWalletTable);
    final appKeychain =
        AppKeychain(address: keyChainAddress, accounts: <Account>[]);
    final appWallet = AppWallet(seed: seed, appKeychain: appKeychain);
    await box.add(appWallet);
    return appWallet;
  }

  Future<AppWallet?> getAppWallet() async {
    // ignore: prefer_final_locals
    var box = await Hive.openBox<AppWallet>(appWalletTable);
    return box.get(0);
  }

  Future<void> clearAll() async {
    await clearAppWallet();
    await clearContacts();
    await clearPrice();
  }

  Future<void> updatePrice(Price price) async {
    // ignore: prefer_final_locals
    var box = await Hive.openBox<Price>(priceTable);
    if (box.isEmpty) {
      await box.add(price);
    } else {
      await box.putAt(0, price);
    }
  }

  Future<Price?> getPrice() async {
    // ignore: prefer_final_locals
    var box = await Hive.openBox<Price>(priceTable);
    return box.get(0);
  }

  Future<void> clearPrice() async {
    // ignore: prefer_final_locals
    var box = await Hive.openBox<Price>(priceTable);
    await box.clear();
  }
}
