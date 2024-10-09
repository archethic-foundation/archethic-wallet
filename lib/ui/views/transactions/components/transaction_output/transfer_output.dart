/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/widgets/tokens/verified_token_icon.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransferOutput extends ConsumerWidget {
  const TransferOutput({
    super.key,
    required this.transaction,
    required this.isCurrencyNative,
  });

  final RecentTransaction transaction;
  final bool isCurrencyNative;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasTransactionInfo = transaction.tokenInformation != null;

    final amountFormatted = NumberUtil.formatThousandsStr(
      transaction.amount!.formatNumber(),
    );
    final localizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Row(
          children: [
            AutoSizeText(
              '${localizations.txListAmount} ',
              style: ArchethicThemeStyles.textStyleSize12W100Primary60,
            ),
            AutoSizeText(
              hasTransactionInfo
                  ? '-$amountFormatted ${isCurrencyNative ? (transaction.tokenInformation!.symbol! == '' ? 'NFT' : transaction.tokenInformation!.symbol!) : transaction.tokenInformation!.symbol!}'
                  : '-$amountFormatted ${AccountBalance.cryptoCurrencyLabel}',
              style: ArchethicThemeStyles.textStyleSize12W100Primary,
            ),
          ],
        ),
        if (transaction.tokenInformation != null &&
            transaction.tokenInformation!.type == 'fungible' &&
            transaction.tokenAddress != null)
          Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              VerifiedTokenIcon(
                address: transaction.tokenAddress!,
              ),
            ],
          ),
        const SizedBox(
          width: 2,
        ),
      ],
    );
  }
}
