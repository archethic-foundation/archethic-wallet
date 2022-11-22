/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NftCreationDetail extends ConsumerWidget {
  const NftCreationDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final nftCreation = ref.watch(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ),
    );

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
                  nftCreation.name,
                  style: theme.textStyleSize12W400Primary,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          if (nftCreation.symbol.isNotEmpty)
            SheetDetailCard(
              children: [
                Text(
                  localizations.tokenSymbol,
                  style: theme.textStyleSize12W400Primary,
                ),
                Text(
                  nftCreation.symbol,
                  style: theme.textStyleSize12W400Primary,
                ),
              ],
            ),
          SheetDetailCard(
            children: [
              Text(
                localizations.tokenInitialSupply,
                style: theme.textStyleSize12W400Primary,
              ),
              Text(
                NumberUtil.formatThousands(nftCreation.initialSupply),
                style: theme.textStyleSize12W400Primary,
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
                AmountFormatters.standardSmallValue(
                  nftCreation.feeEstimationOrZero,
                  AccountBalance.cryptoCurrencyLabel,
                ),
                style: theme.textStyleSize12W400Primary,
              ),
            ],
          ),
          SheetDetailCard(
            children: [
              Text(
                localizations.availableAfterMint,
                style: theme.textStyleSize12W400Primary,
              ),
              Text(
                AmountFormatters.standard(
                  nftCreation.accountBalance.nativeTokenValue -
                      nftCreation.feeEstimationOrZero,
                  nftCreation.symbolFees(context),
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
