/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/accounts/layouts/components/account_list_item.dart';
import 'package:aewallet/ui/views/accounts/layouts/components/add_account_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountsListWidget extends ConsumerWidget {
  const AccountsListWidget({
    super.key,
    this.currencyName,
  });
  final String? currencyName;
  static const int kMaxAccounts = 50;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final accounts = ref.watch(AccountProviders.sortedAccounts).valueOrNull ??
        []; // TODO(Chralu): show a loading screen ?
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 50),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 36, right: 36, bottom: 20),
            child: Text(
              localizations.accountsListDescription,
              textAlign: TextAlign.justify,
              style: theme.textStyleSize12W400Primary,
            ),
          ),
          for (int i = 0; i < accounts.length; i++)
            AccountListItem(
              account: accounts[i],
            ),
          if (accounts.length < kMaxAccounts)
            Row(
              children: const [
                AddAccountButton(),
              ],
            ),
        ],
      ),
    );
  }
}
