/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/repositories/account.dart';
import 'package:aewallet/infrastructure/repositories/local_account.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/hive_app_wallet_dto.dart';
import 'package:aewallet/model/data/price.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_notifier.dart';
part 'providers.g.dart';
part 'selected_account_notifier.dart';

@riverpod
Future<Account> _account(_AccountRef ref, String name) async {
  final repository = ref.read(AccountProviders.accountsRepository);
  final account = await repository.getAccount(name);

  return account!;
}

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
  static final account = _accountProvider;
  static final sortedAccounts = _sortedAccountsProvider;
  static final selectedAccount = _selectedAccountNotifierProvider;
}
