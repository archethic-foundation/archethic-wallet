/// SPDX-License-Identifier: AGPL-3.0-or-later
// Package imports:
import 'package:hive/hive.dart';

part 'token_informations_property.g.dart';

@HiveType(typeId: 10)
class TokenInformationsProperty extends HiveObject {
  TokenInformationsProperty({
    this.name,
    this.value,
  });

  /// Key
  @HiveField(0)
  String? name;

  /// Value
  @HiveField(1)
  String? value;
}
