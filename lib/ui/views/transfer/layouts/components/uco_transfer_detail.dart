/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/primary_currency.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/transfer_recipient_formatters.dart';
import 'package:aewallet/ui/views/transfer/bloc/provider.dart';
import 'package:aewallet/ui/views/transfer/layouts/components/transfer_detail_card.dart';
import 'package:auto_size_text/auto_size_text.dart';
// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UCOTransferDetail extends ConsumerWidget {
  const UCOTransferDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final transfer = ref.watch(TransferFormProvider.transferForm);
    final accountSelected = ref.read(
      AccountProviders.getSelectedAccount(context: context),
    );
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
    var amountInUco = transfer.amount;
    if (primaryCurrency.primaryCurrency == AvailablePrimaryCurrencyEnum.fiat) {
      amountInUco = transfer.amountConverted;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              child: AutoSizeText(
                AmountFormatters.standard(
                  amountInUco,
                  transfer.symbol(context),
                ),
                style: theme.textStyleSize28W700Primary,
              ),
            ),
          ),
          TransferDetailCard(
            children: [
              Text(
                '${localizations.txListFrom} ${accountSelected!.name!}',
                style: theme.textStyleSize12W400Primary,
              ),
            ],
          ),
          TransferDetailCard(
            children: [
              Text(
                '${localizations.txListTo} ${transfer.recipient.format(localizations)}',
                style: theme.textStyleSize12W400Primary,
              ),
              Text(
                AmountFormatters.standard(
                  amountInUco,
                  transfer.symbol(context),
                ),
                style: theme.textStyleSize12W400Primary,
              ),
            ],
          ),
          TransferDetailCard(
            children: [
              Text(
                localizations.estimatedFees,
                style: theme.textStyleSize12W400Primary,
              ),
              Text(
                AmountFormatters.standardSmallValue(
                  transfer.feeEstimationOrZero,
                  StateContainer.of(context)
                      .curNetwork
                      .getNetworkCryptoCurrencyLabel(),
                ),
                style: theme.textStyleSize12W400Primary,
              ),
            ],
          ),
          TransferDetailCard(
            children: [
              Text(
                localizations.total,
                style: theme.textStyleSize12W400Primary,
              ),
              Text(
                AmountFormatters.standard(
                  transfer.feeEstimationOrZero + amountInUco,
                  StateContainer.of(context)
                      .curNetwork
                      .getNetworkCryptoCurrencyLabel(),
                ),
                style: theme.textStyleSize12W400Primary,
              ),
            ],
          ),
          TransferDetailCard(
            children: [
              Text(
                localizations.availableAfterTransfer,
                style: theme.textStyleSize12W400Primary,
              ),
              Text(
                AmountFormatters.standard(
                  accountSelected.balance!.nativeTokenValue! -
                      (transfer.feeEstimationOrZero + amountInUco),
                  transfer.symbol(context),
                ),
                style: theme.textStyleSize12W400Primary,
              ),
            ],
          ),
          if (transfer.message.isNotEmpty)
            TransferDetailCard(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.sendMessageConfirmHeader,
                      style: theme.textStyleSize12W400Primary,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        transfer.message,
                        style: theme.textStyleSize12W400Primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
