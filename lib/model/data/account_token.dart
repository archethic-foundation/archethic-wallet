/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/blockchain/token_information.dart';
// Project imports:
import 'package:aewallet/model/data/appdb.dart';
import 'package:hive/hive.dart';

part 'account_token.g.dart';

/// Next field available : 9
@HiveType(typeId: HiveTypeIds.accountToken)
class AccountToken extends HiveObject {
  AccountToken({
    this.tokenInformation,
    this.amount,
  });

  /// Token Information
  @HiveField(7)
  TokenInformation? tokenInformation;

  /// Amount
  @HiveField(8)
  double? amount;
}
