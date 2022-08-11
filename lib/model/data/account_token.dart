/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:aewallet/model/data/token_informations.dart';

part 'account_token.g.dart';

@HiveType(typeId: 8)
class AccountToken extends HiveObject {
  AccountToken({
    this.tokenInformations,
    this.amount,
  });

  /// Amount
  @HiveField(2)
  int? amount;

  /// Token informations
  @HiveField(7)
  TokenInformations? tokenInformations;
}
