/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NftCreationDetail extends ConsumerWidget {
  const NftCreationDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final nftCreation = ref.watch(
      NftCreationFormProvider.nftCreationForm,
    );
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm.notifier,
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
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
              ),
              Expanded(
                child: Text(
                  nftCreation.name,
                  style: ArchethicThemeStyles.textStyleSize12W100Primary,
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
                  style: ArchethicThemeStyles.textStyleSize12W100Primary,
                ),
                Text(
                  nftCreation.symbol,
                  style: ArchethicThemeStyles.textStyleSize12W100Primary,
                ),
              ],
            ),
          SheetDetailCard(
            children: [
              Text(
                localizations.tokenInitialSupply,
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
              ),
              Text(
                NumberUtil.formatThousands(nftCreation.initialSupply),
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
              ),
            ],
          ),
          SheetDetailCard(
            children: [
              Text(
                localizations.estimatedFees,
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
              ),
              Text(
                AmountFormatters.standardSmallValue(
                  nftCreation.feeEstimationOrZero,
                  AccountBalance.cryptoCurrencyLabel,
                ),
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
              ),
            ],
          ),
          SheetDetailCard(
            children: [
              Text(
                localizations.availableAfterMint,
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
              ),
              Text(
                AmountFormatters.standard(
                  nftCreation.accountBalance.nativeTokenValue -
                      nftCreation.feeEstimationOrZero,
                  nftCreation.symbolFees(context),
                ),
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
              ),
            ],
          ),
          SheetDetailCard(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: Text(
                    localizations.nftInfosCreationConfirmationWarning,
                    style: ArchethicThemeStyles.textStyleSize12W100Primary,
                  ),
                  value: nftCreation.checkPreventUserPublicInfo,
                  onChanged: (newValue) {
                    nftCreationNotifier
                        .setCheckPreventUserPublicInfo(newValue ?? false);
                  },
                  checkColor: ArchethicTheme.background,
                  activeColor: ArchethicTheme.text,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
