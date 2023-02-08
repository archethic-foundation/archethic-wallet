/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:developer';

import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/app_keychain.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/data/hive_app_wallet_dto.dart';
import 'package:aewallet/model/data/nft_infos_off_chain.dart';
import 'package:aewallet/model/data/price.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static const String contactsTable = 'contacts';
  static const String appWalletTable = 'appWallet';
  static const String priceTable = 'price';

  static Future<void> setupDatabase() async {
    if (kIsWeb) {
      Hive.initFlutter();
    } else {
      final suppDir = await getApplicationSupportDirectory();
      Hive.init(suppDir.path);
    }

    Hive
      ..registerAdapter(ContactAdapter())
      ..registerAdapter(HiveAppWalletDTOAdapter())
      ..registerAdapter(AccountBalanceAdapter())
      ..registerAdapter(AccountAdapter())
      ..registerAdapter(AppKeychainAdapter())
      ..registerAdapter(RecentTransactionAdapter())
      ..registerAdapter(PriceAdapter())
      ..registerAdapter(AccountTokenAdapter())
      ..registerAdapter(TokenInformationsAdapter())
      ..registerAdapter(NftInfosOffChainAdapter());
  }

  // Contacts
  Future<List<Contact>> getContacts() async {
    final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList()
      ..sort(
        (Contact a, Contact b) =>
            a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
    return contactsList;
  }

  Future<List<Contact>> getContactsWithNameLike(String pattern) async {
    final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList();

    final contactsListSelected = List<Contact>.empty(growable: true);
    for (final contact in contactsList) {
      if (contact.name.contains(pattern)) {
        contactsListSelected.add(contact);
      }
    }
    return contactsListSelected;
  }

  Future<Contact?> getContactWithAddress(String address) async {
    final box = await Hive.openBox<Contact>(contactsTable);
    final contactsList = box.values.toList();
    final addressContact = <String>[];
    for (final contacts in contactsList) {
      addressContact.add(contacts.address);
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

    final address = hash(publicKey);
    log('address contact: ${uint8ListToHex(address)}');
    contactSelected = await getContactWithAddress(uint8ListToHex(address));

    if (contactSelected == null) {
      throw Exception();
    } else {
      return contactSelected;
    }
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
    try {
      await getContactWithName(name);
      return true;
    } catch (_) {
      return false;
    }
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

  Future<void> clearContacts() async {
    final box = await Hive.openBox<Contact>(contactsTable);
    await box.clear();
  }

  Future<List<Account>> getAccounts() async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    final appWallet = box.get(0)!;
    return appWallet.appKeychain.accounts;
  }

  Future<Account?> getAccount(String name) async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    final appWallet = box.get(0)!;
    for (final account in appWallet.appKeychain.accounts) {
      if (account.name == name) return account;
    }
    return null;
  }

  Future<HiveAppWalletDTO> addAccount(Account account) async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    final appWallet = box.get(0)!;
    appWallet.appKeychain.accounts.add(account);
    await box.putAt(0, appWallet);
    return appWallet;
  }

  Future<HiveAppWalletDTO> clearAccount() async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    final appWallet = box.get(0)!;
    appWallet.appKeychain.accounts.clear();
    await box.putAt(0, appWallet);
    return appWallet;
  }

  Future<HiveAppWalletDTO> changeAccount(String accountName) async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
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
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
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
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
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
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    await box.clear();
  }

  Future<HiveAppWalletDTO> createAppWallet(String keyChainAddress) async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    final appKeychain =
        AppKeychain(address: keyChainAddress, accounts: <Account>[]);
    final appWallet = HiveAppWalletDTO(appKeychain: appKeychain);
    await box.add(appWallet);
    return appWallet;
  }

  Future<HiveAppWalletDTO?> getAppWallet() async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    return box.get(0);
  }

  Future<void> saveAppWallet(HiveAppWalletDTO wallet) async {
    final box = await Hive.openBox<HiveAppWalletDTO>(appWalletTable);
    return box.putAt(0, wallet);
  }

  Future<void> clearAll() async {
    await clearAppWallet();
    await clearContacts();
    await clearPrice();
  }

  Future<void> updatePrice(AvailableCurrencyEnum currency, Price price) async {
    final box = await Hive.openBox<Price>(priceTable);
    await box.put(currency.index, price);
  }

  Future<Price?> getPrice(AvailableCurrencyEnum currency) async {
    final box = await Hive.openBox<Price>(priceTable);
    return box.get(currency.index);
  }

  Future<void> clearPrice() async {
    final box = await Hive.openBox<Price>(priceTable);
    await box.clear();
  }
}
