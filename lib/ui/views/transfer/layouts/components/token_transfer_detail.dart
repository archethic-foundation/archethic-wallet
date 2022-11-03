/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/transfer_recipient_formatters.dart';
import 'package:aewallet/ui/views/transfer/bloc/provider.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenTransferDetail extends ConsumerWidget {
  const TokenTransferDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final transfer = ref.watch(TransferFormProvider.transferForm);
    final accountSelected = ref.watch(
      AccountProviders.selectedAccount,
    );
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              child: transfer.transferType != TransferType.nft
                  ? AutoSizeText(
                      AmountFormatters.standard(
                        transfer.amount,
                        transfer.symbol(context),
                      ),
                      style: theme.textStyleSize28W700Primary,
                    )
                  : const SizedBox(
                      height: 28,
                    ),
            ),
          ),
          SheetDetailCard(
            children: [
              Text(
                '${localizations.txListFrom} ${accountSelected!.name}',
                style: theme.textStyleSize12W400Primary,
              ),
            ],
          ),
          SheetDetailCard(
            children: [
              Text(
                '${localizations.txListTo} ${transfer.recipient.format(localizations)}',
                style: theme.textStyleSize12W400Primary,
              ),
              if (transfer.transferType != TransferType.nft)
                Text(
                  AmountFormatters.standard(
                    transfer.amount,
                    transfer.symbol(context),
                  ),
                  style: theme.textStyleSize12W400Primary,
                )
              else
                Text(
                  AmountFormatters.standard(
                    transfer.amount,
                    'NFT "${transfer.accountToken!.tokenInformations!.name!}"',
                  ),
                  style: theme.textStyleSize12W400Primary,
                )
            ],
          ),
          SheetDetailCard(
            children: [
              Text(
                localizations.estimatedFees,
                style: theme.textStyleSize12W400Primary,
              ),
              Text(
                AmountFormatters.standardSmallValue(
                  transfer.feeEstimation.valueOrNull ?? 0,
                  StateContainer.of(context)
                      .curNetwork
                      .getNetworkCryptoCurrencyLabel(),
                ),
                style: theme.textStyleSize12W400Primary,
              ),
            ],
          ),
          SheetDetailCard(
            children: [
              Text(
                localizations.availableAfterTransfer,
                style: theme.textStyleSize12W400Primary,
              ),
              if (transfer.transferType != TransferType.nft)
                Text(
                  AmountFormatters.standard(
                    transfer.accountToken!.amount! - transfer.amount,
                    transfer.symbol(context),
                  ),
                  style: theme.textStyleSize12W400Primary,
                )
              else
                Text(
                  AmountFormatters.standard(
                    transfer.accountToken!.amount! - transfer.amount,
                    'NFT "${transfer.accountToken!.tokenInformations!.name!}"',
                  ),
                  style: theme.textStyleSize12W400Primary,
                )
            ],
          ),
          if (transfer.message.isNotEmpty)
            SheetDetailCard(
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
