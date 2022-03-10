// Package imports:
import 'package:hive/hive.dart';

part 'hiveDB.g.dart';

@HiveType(typeId: 0)
class Contact extends HiveObject {
  Contact({required this.name, required this.address});

  /// Name
  @HiveField(0)
  String? name;

  /// Address
  @HiveField(1)
  String? address;
}

@HiveType(typeId: 1)
class Account extends HiveObject {
  Account(
      {this.genesisAddress,
      this.index,
      this.name,
      this.lastAccess,
      this.selected = false,
      this.lastAddress,
      this.balance});

  /// Genesis Address - Primary Key
  @HiveField(0)
  String? genesisAddress;

  /// Index on the seed
  @HiveField(1)
  int? index;

  /// Account nickname
  @HiveField(2)
  String? name;

  /// Last Accessed incrementor
  @HiveField(3)
  int? lastAccess;

  /// Whether this is the currently selected account
  @HiveField(4)
  bool? selected;

  /// Last address
  @HiveField(5)
  String? lastAddress;

  /// Last known balance in RAW
  @HiveField(6)
  String? balance;
}
