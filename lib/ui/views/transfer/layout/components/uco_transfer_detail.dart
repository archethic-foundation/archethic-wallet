/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/transfer/bloc/provider.dart';
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
    final transfer = ref.watch(TransferProvider.transfer);
    final accountSelected =
        ref.read(AccountProviders.getSelectedAccount(context: context));
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
                  transfer.amount,
                  StateContainer.of(context)
                      .curNetwork
                      .getNetworkCryptoCurrencyLabel(),
                ),
                style: theme.textStyleSize28W700Primary,
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: theme.backgroundTransferListOutline!,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              color: theme.backgroundTransferListCard,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${localizations.txListFrom} ${accountSelected!.name!}',
                      style: theme.textStyleSize12W400Primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: theme.backgroundTransferListOutline!,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              color: theme.backgroundTransferListCard,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      transfer.contactRecipient == null
                          ? '${localizations.txListTo} ${Address(transfer.addressRecipient).getShortString()}'
                          : '${localizations.txListTo} ${transfer.contactRecipient!.name!.replaceFirst('@', '')}',
                      style: theme.textStyleSize12W400Primary,
                    ),
                    Text(
                      AmountFormatters.standard(
                        transfer.amount,
                        StateContainer.of(context)
                            .curNetwork
                            .getNetworkCryptoCurrencyLabel(),
                      ),
                      style: theme.textStyleSize12W400Primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: theme.backgroundTransferListOutline!,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              color: theme.backgroundTransferListCard,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      localizations.estimatedFees,
                      style: theme.textStyleSize12W400Primary,
                    ),
                    Text(
                      AmountFormatters.standardSmallValue(
                        transfer.feeEstimation,
                        StateContainer.of(context)
                            .curNetwork
                            .getNetworkCryptoCurrencyLabel(),
                      ),
                      style: theme.textStyleSize12W400Primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: theme.backgroundTransferListOutline!,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              color: theme.backgroundTransferListTotalCard,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      localizations.total,
                      style: theme.textStyleSize12W400Primary,
                    ),
                    Text(
                      AmountFormatters.standard(
                        transfer.feeEstimation + transfer.amount,
                        StateContainer.of(context)
                            .curNetwork
                            .getNetworkCryptoCurrencyLabel(),
                      ),
                      style: theme.textStyleSize12W400Primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: theme.backgroundTransferListOutline!,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              color: theme.backgroundTransferListCard,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      localizations.availableAfterTransfer,
                      style: theme.textStyleSize12W400Primary,
                    ),
                    Text(
                      AmountFormatters.standard(
                        accountSelected.balance!.nativeTokenValue! -
                            (transfer.feeEstimation + transfer.amount),
                        accountSelected.balance!.nativeTokenName!,
                      ),
                      style: theme.textStyleSize12W400Primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (transfer.message.isNotEmpty)
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: theme.backgroundTransferListOutline!,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                color: theme.backgroundTransferListCard,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        localizations.sendMessageConfirmHeader,
                        style: theme.textStyleSize12W400Primary,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        transfer.message,
                        style: theme.textStyleSize12W400Primary,
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
