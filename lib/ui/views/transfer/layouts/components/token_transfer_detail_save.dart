/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/transfer/bloc/provider.dart';
// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenTransferDetail extends ConsumerWidget {
  const TokenTransferDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    final transfer = ref.watch(TransferProvider.transfer);

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.only(left: 3.5, right: 3.5),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    AppLocalization.of(context)!.txListTo,
                    style: theme.textStyleSize14W600Primary,
                  ),
                  Text(
                    transfer.contactRecipient == null
                        ? Address(transfer.addressRecipient).getShortString()
                        : '${transfer.contactRecipient!.name}\n${Address(transfer.addressRecipient).getShortString()}',
                    style: theme.textStyleSize14W600Primary,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                AmountFormatters.standard(transfer.amount, transfer.symbol),
                style: theme.textStyleSize14W600Primary,
              ),
            ],
          ),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '+ ${localizations.estimatedFees}',
                      style: theme.textStyleSize14W600Primary,
                    ),
                  ],
                ),
                Text(
                  AmountFormatters.standardSmallValue(
                    transfer.feeEstimation,
                    StateContainer.of(context)
                        .curNetwork
                        .getNetworkCryptoCurrencyLabel(),
                  ),
                  style: theme.textStyleSize14W600Primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
