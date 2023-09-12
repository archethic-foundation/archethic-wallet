/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/model/data/account_balance.dart';
// Package imports:
import 'package:aewallet/model/data/appdb.dart';
import 'package:hive/hive.dart';

part 'contact.g.dart';

enum ContactType { keychainService, externalContact }

/// Next field available : 8
@HiveType(typeId: HiveTypeIds.contact)
class Contact extends HiveObject {
  Contact({
    required this.name,
    required this.address,
    required this.type,
    required this.publicKey,
    this.balance,
    this.favorite,
  });

  /// Name
  @HiveField(0)
  String name;

  /// Address
  @HiveField(1)
  String address;

  /// Type contact - Keychain Service / External contact
  @HiveField(4)
  String type;

  /// Public Key
  @HiveField(5, defaultValue: '')
  String publicKey;

  /// Favorite
  @HiveField(6)
  bool? favorite;

  /// Balance
  @HiveField(7)
  AccountBalance? balance;
}
