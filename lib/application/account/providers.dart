/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/account_notifier.dart';
import 'package:aewallet/application/account/accounts.dart';
import 'package:aewallet/application/account/accounts_notifier.dart';

class AccountProviders {
  static final accounts = accountsNotifierProvider;
  static const account = accountNotifierProvider;
  static const accountWithGenesisAddress = accountWithGenesisAddressProvider;
  static const accountWithName = accountWithNameProvider;
}
