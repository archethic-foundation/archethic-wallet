/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact extends HiveObject {
  Contact({required this.name, required this.address, required this.type});

  /// Name
  @HiveField(0)
  String? name;

  /// Address
  @HiveField(1)
  String? address;

  /// Type contact - Keychain Service / External contact
  @HiveField(4)
  String? type;
}
