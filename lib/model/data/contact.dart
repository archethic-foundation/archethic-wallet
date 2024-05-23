/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/infrastructure/datasources/appdb.hive.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'contact.g.dart';

class ContactConverter implements JsonConverter<Contact, Map<String, dynamic>> {
  const ContactConverter();

  @override
  Contact fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'] as String,
      address: json['address'] as String,
      genesisAddress: json['genesisAddress'] as String,
      type: json['type'] as String,
      publicKey: json['publicKey'] as String,
      favorite: json['favorite'] == null ? null : json['favorite'] as bool,
      balance: json['balance'] == null
          ? null
          : const AccountBalanceConverter()
              .fromJson(json['balance'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson(Contact contact) {
    return {
      'name': contact.name,
      'address': contact.address,
      'genesisAddress': contact.genesisAddress,
      'type': contact.type,
      'publicKey': contact.publicKey,
      'favorite': contact.favorite,
      'balance': const AccountBalanceConverter().toJson(contact.balance!),
    };
  }
}

enum ContactType { keychainService, externalContact }

/// Next field available : 9
@HiveType(typeId: HiveTypeIds.contact)
@AccountBalanceConverter()
class Contact extends HiveObject {
  Contact({
    required this.name,
    required this.address,
    required this.type,
    required this.publicKey,
    required this.genesisAddress,
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

  /// Genesis Address
  @HiveField(8)
  String? genesisAddress;
}
