/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account.g.dart';

@riverpod
AccountRepository _accountRepository(_AccountRepositoryRef ref) =>
    AccountRepository();

@riverpod
Account? _getSelectedAccount(
  _GetSelectedAccountRef ref, {
  required BuildContext context,
}) {
  return ref.read(_accountRepositoryProvider).getSelectedAccount(context);
}

class AccountRepository {
  Account? getSelectedAccount(BuildContext context) {
    return StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected();
  }
}

abstract class AccountProviders {
  static final getSelectedAccount = _getSelectedAccountProvider;
}
