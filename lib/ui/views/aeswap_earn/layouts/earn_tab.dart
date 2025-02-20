import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/earn_tab_section_add_liquidity.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/earn_tab_section_deposit_funds.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/earn_tab_section_start_earning.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/earn_total_deposited.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/earn_yearly_interest.dart';
import 'package:aewallet/ui/views/aeswap_earn/layouts/components/farm_lock_block_farmed_tokens_summary.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EarnTab extends ConsumerStatefulWidget {
  const EarnTab({super.key});

  @override
  ConsumerState<EarnTab> createState() => EarnTabState();
}

class EarnTabState extends ConsumerState<EarnTab> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final boldBodyLarge =
        AppTextStyles.bodyLarge(context).copyWith(fontWeight: FontWeight.bold);
    final bodyMediumWithOpacity = AppTextStyles.bodyMediumWithOpacity(context);

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              ArchethicScrollbar(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10,
                    bottom: 80,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        localizations.earnTabTitle,
                        style: boldBodyLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        localizations.earnTabDesc,
                        style: bodyMediumWithOpacity,
                      ),
                      const SizedBox(height: 40),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: EarnTotalDeposited(),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: EarnYearlyInterest(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: FarmLockBlockFarmedTokensSummary(
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      const EarnSectionDepositFunds(),
                      const SizedBox(height: 10),
                      const EarnSectionAddLiquidity(),
                      const SizedBox(height: 10),
                      const EarnSectionStartEarning(),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
