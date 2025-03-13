import 'package:aewallet/application/onramp/onramp.dart';
import 'package:aewallet/domain/models/onramp.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:numeral/numeral.dart';

class OnRampTransactionHistory extends ConsumerWidget {
  const OnRampTransactionHistory(this.footer, {super.key});

  final Widget footer;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final transfers = ref.watch(onrampTransfersProvider).valueOrNull;

    if (transfers == null || transfers.isEmpty) {
      return const SizedBox.shrink();
    }
    final localizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.onrampHistoryTitle,
          style: AppTextStyles.bodyLarge(context)
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: aedappfm.ArchethicThemeBase.brightPurpleBackground,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: transfers
                  .mapIndexed(
                    (index, transfer) => _OnRampTransactionHistoryTableRow(
                      key: Key(transfer.id),
                      deposit: transfer,
                      isEven: index.isEven,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 15),
        footer,
      ],
    );
  }
}

class _OnRampTransactionHistoryTableRow extends ConsumerWidget {
  const _OnRampTransactionHistoryTableRow({
    super.key,
    required this.deposit,
    required this.isEven,
  });
  final OnRampDeposit deposit;
  final bool isEven;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final depositToken = ref
        .watch(
          onrampTokenProvider(
            deposit.depositChainId,
            deposit.depositTokenId,
          ),
        )
        .valueOrNull;

    final depositTokenDisplay = ref
        .watch(
          onrampTokenDisplayDataProvider(
            deposit.depositTokenId,
          ),
        )
        .valueOrNull;

    final depositSymbol = depositTokenDisplay?.symbol ?? '';
    final depositAmount = depositToken?.toDecimal(deposit.depositAmount);
    final isReceived = deposit.transferedUcoAmount != 0;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isEven
            ? Colors.transparent
            : aedappfm.ArchethicThemeBase.raspberry500.withValues(alpha: 0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          '+${depositAmount?.numeral(digits: 8) ?? '--'} ',
                          style: AppTextStyles.bodyLarge(context).copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        depositSymbol,
                        style: AppTextStyles.bodyLarge(context).copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Symbols.arrow_outward,
                        size: 15,
                        color: Colors.red,
                        weight: 700,
                      ),
                    ],
                  ),
                  Text(
                    DateFormat.yMd(
                      Localizations.localeOf(context).languageCode,
                    ).add_Hms().format(deposit.depositDate.toLocal()),
                    style: AppTextStyles.bodySmall(context),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          '+${deposit.transferedUcoAmount.toDecimal(8).numeral()} ',
                          style: AppTextStyles.bodyLarge(context).copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        aedappfm.ucoToken.symbol,
                        style: AppTextStyles.bodyLarge(context).copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      if (isReceived)
                        const SizedBox(
                          width: 4,
                        ),
                      if (isReceived)
                        const Icon(
                          Symbols.call_received,
                          size: 15,
                          color: Colors.green,
                          weight: 700,
                        ),
                    ],
                  ),
                  Text(
                    isReceived
                        ? localizations.onrampHistoryTransferStatusCompleted(
                            (deposit.completedRatio * 100).round(),
                          )
                        : localizations.onrampHistoryTransferStatusInitiated,
                    style: AppTextStyles.bodySmall(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
