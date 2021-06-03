// @dart=2.9

import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uniris_mobile_wallet/model/db/account.dart';
import 'package:uniris_mobile_wallet/model/db/contact.dart';
import 'package:uniris_mobile_wallet/util/app_ffi/apputil.dart';

class DBHelper {
  static const int DB_VERSION = 1;
  static const String CONTACTS_SQL = '''CREATE TABLE Contacts( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT, 
        address TEXT)''';
  static const String ACCOUNTS_SQL = '''CREATE TABLE Accounts( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT, 
        acct_index INTEGER, 
        selected INTEGER, 
        last_accessed INTEGER,
        private_key TEXT,
        address TEXT,
        balance TEXT
        )''';
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    final io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'uniris.db');
    final Database theDb = await openDatabase(path,
        version: DB_VERSION, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the tables
    await db.execute(CONTACTS_SQL);
    await db.execute(ACCOUNTS_SQL);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  // Contacts
  Future<List<Contact>> getContacts() async {
    final Database dbClient = await db;
    final List<Map> list =
        await dbClient.rawQuery('SELECT * FROM Contacts ORDER BY name');
    final List<Contact> contacts = List<Contact>.empty(growable: true);
    for (int i = 0; i < list.length; i++) {
      contacts.add(Contact(
        id: list[i]['id'],
        name: list[i]['name'],
        address: list[i]['address'],
      ));
    }
    return contacts;
  }

  Future<List<Contact>> getContactsWithNameLike(String pattern) async {
    final Database dbClient = await db;
    final List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM Contacts WHERE name LIKE \'%$pattern%\' ORDER BY LOWER(name)');
    final List<Contact> contacts = List<Contact>.empty(growable: true);
    for (int i = 0; i < list.length; i++) {
      contacts.add(Contact(
        id: list[i]['id'],
        name: list[i]['name'],
        address: list[i]['address'],
      ));
    }
    return contacts;
  }

  Future<Contact> getContactWithAddress(String address) async {
    final Database dbClient = await db;
    final List<Map> list = await dbClient
        .rawQuery('SELECT * FROM Contacts WHERE address like \'%$address\'');
    if (list.isNotEmpty) {
      return Contact(
        id: list[0]['id'],
        name: list[0]['name'],
        address: list[0]['address'],
      );
    }
    return null;
  }

  Future<Contact> getContactWithName(String name) async {
    final Database dbClient = await db;
    final List<Map> list = await dbClient
        .rawQuery('SELECT * FROM Contacts WHERE name = ?', [name]);
    if (list.isNotEmpty) {
      return Contact(
        id: list[0]['id'],
        name: list[0]['name'],
        address: list[0]['address'],
      );
    }
    return null;
  }

  Future<bool> contactExistsWithName(String name) async {
    final Database dbClient = await db;
    final int count = Sqflite.firstIntValue(await dbClient.rawQuery(
        'SELECT count(*) FROM Contacts WHERE lower(name) = ?',
        [name.toLowerCase()]));
    return count > 0;
  }

  Future<bool> contactExistsWithAddress(String address) async {
    final Database dbClient = await db;
    final int count = Sqflite.firstIntValue(await dbClient.rawQuery(
        'SELECT count(*) FROM Contacts WHERE lower(address) like \'%$address\''));
    return count > 0;
  }

  Future<int> saveContact(Contact contact) async {
    final Database dbClient = await db;
    return await dbClient.rawInsert(
        'INSERT INTO Contacts (name, address) values(?, ?)',
        [contact.name, contact.address]);
  }

  Future<int> saveContacts(List<Contact> contacts) async {
    int count = 0;
    for (Contact c in contacts) {
      if (await saveContact(c) > 0) {
        count++;
      }
    }
    return count;
  }

  Future<bool> deleteContact(Contact contact) async {
    final Database dbClient = await db;
    return await dbClient.rawDelete(
            "DELETE FROM Contacts WHERE lower(address) like \'%${contact.address.toLowerCase()}\'") >
        0;
  }

  // Accounts
  Future<List<Account>> getAccounts(String seed) async {
    final Database dbClient = await db;
    final List<Map> list =
        await dbClient.rawQuery('SELECT * FROM Accounts ORDER BY acct_index');
    final List<Account> accounts = List<Account>.empty(growable: true);
    for (int i = 0; i < list.length; i++) {
      accounts.add(Account(
        id: list[i]['id'],
        name: list[i]['name'],
        index: list[i]['acct_index'],
        lastAccess: list[i]['last_accessed'],
        selected: list[i]['selected'] == 1 ? true : false,
        balance: list[i]['balance'],
      ));
    }
    accounts.forEach((Account a) {
      a.address = AppUtil().seedToAddress(seed, a.index);
    });
    return accounts;
  }

  Future<List<Account>> getRecentlyUsedAccounts(String seed,
      {int limit = 2}) async {
    final Database dbClient = await db;
    final List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM Accounts WHERE selected != 1 ORDER BY last_accessed DESC, acct_index ASC LIMIT ?',
        [limit]);
    final List<Account> accounts = List<Account>.empty(growable: true);
    for (int i = 0; i < list.length; i++) {
      accounts.add(Account(
        id: list[i]['id'],
        name: list[i]['name'],
        index: list[i]['acct_index'],
        lastAccess: list[i]['last_accessed'],
        selected: list[i]['selected'] == 1 ? true : false,
        balance: list[i]['balance'],
      ));
    }
    accounts.forEach((Account a) async {
      a.address = AppUtil().seedToAddress(seed, a.index);
    });
    return accounts;
  }

  Future<Account> addAccount(String seed, {String nameBuilder}) async {
    final Database dbClient = await db;
    Account account;
    await dbClient.transaction((Transaction txn) async {
      int nextIndex = 1;
      int curIndex;
      final List<Map> accounts = await txn.rawQuery(
          'SELECT * from Accounts WHERE acct_index > 0 ORDER BY acct_index ASC');
      for (int i = 0; i < accounts.length; i++) {
        curIndex = accounts[i]['acct_index'];
        if (curIndex != nextIndex) {
          break;
        }
        nextIndex++;
      }
      final int nextID = nextIndex + 1;
      final String nextName = nameBuilder.replaceAll('%1', nextID.toString());
      account = Account(
        index: nextIndex,
        name: nextName,
        lastAccess: 0,
        balance: '0',
        selected: false,
        address: AppUtil().seedToAddress(seed, nextIndex),
      );
      await txn.rawInsert(
          'INSERT INTO Accounts (name, acct_index, last_accessed, selected, address, balance) values(?, ?, ?, ?, ?, ?)',
          [
            account.name,
            account.index,
            account.lastAccess,
            if (account.selected) 1 else 0,
            account.address,
            account.balance,
          ]);
    });
    return account;
  }

  Future<int> deleteAccount(Account account) async {
    final Database dbClient = await db;
    return await dbClient.rawDelete(
        'DELETE FROM Accounts WHERE acct_index = ?', [account.index]);
  }

  Future<int> saveAccount(Account account) async {
    final Database dbClient = await db;
    return await dbClient.rawInsert(
        'INSERT INTO Accounts (name, acct_index, last_accessed, selected, balance) values(?, ?, ?, ?, ?)',
        [
          account.name,
          account.index,
          account.lastAccess,
          if (account.selected) 1 else 0,
          account.balance,
        ]);
  }

  Future<int> changeAccountName(Account account, String name) async {
    final Database dbClient = await db;
    return await dbClient.rawUpdate(
        'UPDATE Accounts SET name = ? WHERE acct_index = ?',
        [name, account.index]);
  }

  Future<void> changeAccount(Account account) async {
    final Database dbClient = await db;
    return await dbClient.transaction((Transaction txn) async {
      await txn.rawUpdate('UPDATE Accounts set selected = 0');
      // Get access increment count
      final List<Map> list = await txn
          .rawQuery('SELECT max(last_accessed) as last_access FROM Accounts');
      await txn.rawUpdate(
          'UPDATE Accounts set selected = ?, last_accessed = ? where acct_index = ?',
          [1, list[0]['last_access'] + 1, account.index]);
    });
  }

  Future<void> updateAccountBalance(Account account, String balance) async {
    final Database dbClient = await db;
    return await dbClient.rawUpdate(
        'UPDATE Accounts set balance = ? where acct_index = ?',
        [balance, account.index]);
  }

  Future<Account> getSelectedAccount(String seed) async {
    final Database dbClient = await db;
    final List<Map> list =
        await dbClient.rawQuery('SELECT * FROM Accounts where selected = 1');
    if (list.isEmpty) {
      return null;
    }
    final Account account = Account(
      id: list[0]['id'],
      name: list[0]['name'],
      index: list[0]['acct_index'],
      selected: true,
      lastAccess: list[0]['last_accessed'],
      balance: list[0]['balance'],
      address: AppUtil().seedToAddress(seed, list[0]['acct_index']),
    );
    return account;
  }

  Future<Account> getMainAccount(String seed) async {
    final Database dbClient = await db;
    final List<Map> list =
        await dbClient.rawQuery('SELECT * FROM Accounts where acct_index = 0');
    if (list.isEmpty) {
      return null;
    }
    final String address = AppUtil().seedToAddress(seed, list[0]['acct_index']);

    final Account account = Account(
      id: list[0]['id'],
      name: list[0]['name'],
      index: list[0]['acct_index'],
      selected: true,
      lastAccess: list[0]['last_accessed'],
      balance: list[0]['balance'],
      address: address,
    );
    return account;
  }

  Future<void> dropAccounts() async {
    final Database dbClient = await db;
    return await dbClient.rawDelete('DELETE FROM ACCOUNTS');
  }
}
