import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/ui/views/farm_lock/layouts/components/farm_lock_details/farm_lock_details_info_addresses.dart';
import 'package:aewallet/modules/aeswap/ui/views/farm_lock/layouts/components/farm_lock_details/farm_lock_details_info_distributed_rewards.dart';
import 'package:aewallet/modules/aeswap/ui/views/farm_lock/layouts/components/farm_lock_details/farm_lock_details_info_header.dart';
import 'package:aewallet/modules/aeswap/ui/views/farm_lock/layouts/components/farm_lock_details/farm_lock_details_info_lp_deposited.dart';
import 'package:aewallet/modules/aeswap/ui/views/farm_lock/layouts/components/farm_lock_details/farm_lock_details_info_period.dart';
import 'package:aewallet/modules/aeswap/ui/views/farm_lock/layouts/components/farm_lock_details/farm_lock_details_info_remaining_reward.dart';
import 'package:aewallet/modules/aeswap/ui/views/farm_lock/layouts/components/farm_lock_details/farm_lock_details_info_token_reward.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockDetailsFront extends ConsumerStatefulWidget {
  const FarmLockDetailsFront({
    super.key,
    required this.farmLock,
    required this.userBalance,
    this.isInPopup = false,
  });

  final DexFarmLock farmLock;
  final double? userBalance;
  final bool? isInPopup;

  @override
  FarmDetailsFrontState createState() => FarmDetailsFrontState();
}

class FarmDetailsFrontState extends ConsumerState<FarmLockDetailsFront>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(
    BuildContext context,
  ) {
    super.build(context);

    return Column(
      children: [
        FarmLockDetailsInfoHeader(farmLock: widget.farmLock),
        Opacity(
          opacity: AppTextStyles.kOpacityText,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FarmLockDetailsInfoAddresses(farmLock: widget.farmLock),
              FarmLockDetailsInfoTokenReward(farmLock: widget.farmLock),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Opacity(
          opacity: AppTextStyles.kOpacityText,
          child: FarmLockDetailsInfoPeriod(farmLock: widget.farmLock),
        ),
        const SizedBox(height: 40),
        Opacity(
          opacity: AppTextStyles.kOpacityText,
          child: FarmLockDetailsInfoRemainingReward(farmLock: widget.farmLock),
        ),
        const SizedBox(height: 10),
        Opacity(
          opacity: AppTextStyles.kOpacityText,
          child:
              FarmLockDetailsInfoDistributedRewards(farmLock: widget.farmLock),
        ),
        const SizedBox(height: 10),
        Opacity(
          opacity: AppTextStyles.kOpacityText,
          child: FarmLockDetailsInfoLPDeposited(farmLock: widget.farmLock),
        ),
        const Spacer(),
        if (widget.isInPopup == true)
          _closeButton(
            context,
          ),
      ],
    );
  }

  Widget _closeButton(BuildContext context) {
    return aedappfm.AppButton(
      backgroundGradient: LinearGradient(
        colors: [
          aedappfm.ArchethicThemeBase.blue400,
          aedappfm.ArchethicThemeBase.blue600,
        ],
      ),
      labelBtn: AppLocalizations.of(context)!.btn_close,
      onPressed: () async {
        context.pop();
      },
    );
  }
}
