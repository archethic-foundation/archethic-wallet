/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:developer';

import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/repositories/account.dart';
import 'package:aewallet/infrastructure/repositories/local_account.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_notifier.dart';
part 'accounts_notifier.dart';
part 'providers.g.dart';
part 'selected_account_notifier.dart';

@riverpod
Future<List<Account>> _sortedAccounts(_SortedAccountsRef ref) async {
  final accounts = await ref.watch(
    AccountProviders.accounts.future,
  );
  return [
    ...accounts,
  ]..sort(
      (a, b) => a.name.compareTo(b.name),
    );
}

abstract class AccountProviders {
  static final accountsRepository = Provider<AccountLocalRepositoryInterface>(
    (ref) => AccountLocalRepository(),
  );
  static final accounts = _accountsNotifierProvider;
  static final account = AsyncNotifierProvider.autoDispose
      .family<_AccountNotifier, Account?, String>(
    _AccountNotifier.new,
  );
  static final sortedAccounts = _sortedAccountsProvider;
  static final selectedAccount = _selectedAccountNotifierProvider;
  static final selectedAccountName = _selectedAccountNameProvider;
}
