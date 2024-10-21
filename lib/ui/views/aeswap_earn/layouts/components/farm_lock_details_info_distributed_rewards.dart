import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/fiat_value.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDetailsInfoDistributedRewards extends ConsumerWidget {
  const FarmLockDetailsInfoDistributedRewards({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final farmLock = ref.watch(farmLockFormFarmLockProvider).value;
    if (farmLock == null) return const SizedBox.shrink();

    return SheetDetailCard(
      children: [
        SelectableText(
          AppLocalizations.of(context)!.farmDetailsInfoDistributedRewards,
          style: AppTextStyles.bodyMedium(context),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SelectableText(
              '${farmLock.rewardDistributed.formatNumber(precision: 2)} ${farmLock.rewardToken!.symbol}',
              style: AppTextStyles.bodyMedium(context),
            ),
            FutureBuilder<String>(
              future: FiatValue().display(
                ref,
                farmLock.rewardToken!,
                farmLock.rewardDistributed,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SelectableText(
                    snapshot.data!,
                    style: AppTextStyles.bodyMedium(context),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ],
    );
  }
}
