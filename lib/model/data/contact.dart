/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:aewallet/model/data/appdb.dart';
import 'package:hive/hive.dart';

part 'contact.g.dart';

enum ContactType { keychainService, externalContact }

/// Next field available : 7
@HiveType(typeId: HiveTypeIds.contact)
class Contact extends HiveObject {
  Contact({
    required this.name,
    required this.address,
    required this.type,
    required this.publicKey,
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
}
