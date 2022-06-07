/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:hive/hive.dart';

part 'hive_db.g.dart';

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
      {this.name,
      this.genesisAddress,
      this.lastAccess,
      this.selected = false,
      this.lastAddress,
      this.balance});

  /// Account name - Primary Key
  @HiveField(0)
  String? name;

  /// Genesis Address
  @HiveField(1)
  String? genesisAddress;

  /// Last Accessed incrementor
  @HiveField(2)
  int? lastAccess;

  /// Whether this is the currently selected account
  @HiveField(3)
  bool? selected;

  /// Last address
  @HiveField(4)
  String? lastAddress;

  /// Last known balance in RAW
  @HiveField(5)
  String? balance;
}
