/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/add_account/bloc/provider.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAccountDetail extends ConsumerWidget {
  const AddAccountDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final addAccount = ref.watch(AddAccountFormProvider.addAccountForm);
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          SheetDetailCard(
            children: [
              Text(
                localizations.tokenName,
                style: theme.textStyleSize12W400Primary,
              ),
              Expanded(
                child: Text(
                  addAccount.name,
                  style: theme.textStyleSize12W400Primary,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          SheetDetailCard(
            children: [
              Text(
                localizations.estimatedFees,
                style: theme.textStyleSize12W400Primary,
              ),
              Text(
                '0 ${AccountBalance.cryptoCurrencyLabel}',
                style: theme.textStyleSize12W400Primary,
              ),
            ],
          ),
          SheetDetailCard(
            children: [
              Text(
                localizations.availableAfterCreation,
                style: theme.textStyleSize12W400Primary,
              ),
              Text(
                AmountFormatters.standard(
                  accountSelected!.balance!.nativeTokenValue,
                  addAccount.symbolFees(context),
                ),
                style: theme.textStyleSize12W400Primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
