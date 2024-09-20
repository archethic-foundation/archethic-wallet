import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FarmLockDetailsInfoPeriod extends ConsumerWidget {
  const FarmLockDetailsInfoPeriod({
    super.key,
    required this.farmLock,
  });

  final DexFarmLock farmLock;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Column(
      children: [
        if (farmLock.startDate != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (farmLock.startDate!.isAfter(DateTime.now().toUtc()))
                SelectableText(
                  AppLocalizations.of(context)!.farmDetailsInfoPeriodWillStart,
                  style: AppTextStyles.bodyLarge(context),
                )
              else
                SelectableText(
                  AppLocalizations.of(context)!.farmDetailsInfoPeriodStarted,
                  style: AppTextStyles.bodyLarge(context),
                ),
              SelectableText(
                DateFormat.yMd(
                  Localizations.localeOf(context).languageCode,
                ).add_Hm().format(farmLock.startDate!.toLocal()),
                style: AppTextStyles.bodyLarge(context),
              ),
            ],
          ),
        if (farmLock.endDate != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (farmLock.endDate!.isAfter(DateTime.now().toUtc()))
                SelectableText(
                  AppLocalizations.of(context)!.farmDetailsInfoPeriodEndAt,
                  style: AppTextStyles.bodyLarge(context),
                )
              else
                SelectableText(
                  AppLocalizations.of(context)!.farmDetailsInfoPeriodEnded,
                  style: AppTextStyles.bodyLarge(context),
                ),
              SelectableText(
                DateFormat.yMd(
                  Localizations.localeOf(context).languageCode,
                ).add_Hm().format(farmLock.endDate!.toLocal()),
                style: AppTextStyles.bodyLarge(context),
              ),
            ],
          ),
      ],
    );
  }
}
