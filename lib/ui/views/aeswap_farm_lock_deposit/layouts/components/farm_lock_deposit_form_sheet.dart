import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/settings.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/farm_lock_duration_type.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/complex/estimated_fees.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/message_box/message_box.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/components/farm_lock_deposit_lock_duration_btn.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_deposit/layouts/components/farm_lock_deposit_textfield_amount.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockDepositFormSheet extends ConsumerWidget
    implements SheetSkeletonInterface {
  const FarmLockDepositFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected = ref.watch(
      accountsNotifierProvider.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );

    if (accountSelected == null) return const SizedBox();

    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final farmLockDeposit = ref.watch(farmLockDepositFormNotifierProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        EstimatedFees(farmLockDeposit.feeEstimation),
        BtnFooterPrimary(
          buttonText: localizations.btn_farmLockDeposit,
          onTap: () async {
            await ref
                .read(
                  farmLockDepositFormNotifierProvider.notifier,
                )
                .validateForm(localizations);
          },
          key: const Key('farmLockDeposit'),
          isLocked: !farmLockDeposit.isControlsOk,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final earnUserLevel = ref.watch(
      SettingsProviders.settings.select((settings) => settings.earnUserLevel),
    );

    return SheetAppBar(
      title: earnUserLevel == EarnUserLevelType.beginner
          ? localizations.farmLockDepositFormTitleBeginner
          : localizations.farmLockDepositFormTitle,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final farmLockDeposit = ref.watch(farmLockDepositFormNotifierProvider);
    final earnUserLevel = ref.watch(
      SettingsProviders.settings.select((settings) => settings.earnUserLevel),
    );

    if (farmLockDeposit.pool == null) {
      return const Padding(
        padding: EdgeInsets.only(top: 80, bottom: 80),
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 0.5),
        ),
      );
    }

    final localizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.farmLockDepositDesc,
            style: Theme.of(context).textTheme.bodySmallWithOpacity,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const FarmLockDepositLPAmount(),
                if (farmLockDeposit.failure != null)
                  MessageBox(
                    messageBoxType: MessageBoxType.warning,
                    text: FailureMessage(
                      context: context,
                      failure: farmLockDeposit.failure,
                    ).getMessage(),
                  ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.farmLockDepositTitle2,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      localizations.farmLockDepositDesc2,
                      style: Theme.of(context).textTheme.bodySmallWithOpacity,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Wrap(
                  children: [
                    ...farmLockDeposit.filterAvailableLevels.entries
                        .map((entry) {
                          return FarmLockDepositDurationButton(
                            farmLockDepositDuration:
                                getFarmLockDepositDurationTypeFromLevel(
                              entry.key,
                            ),
                            level: entry.key,
                            aprEstimation: (farmLockDeposit.farmLock!
                                        .stats[entry.key]?.aprEstimation ??
                                    0) *
                                100,
                          );
                        })
                        .toList()
                        .reversed,
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (earnUserLevel == EarnUserLevelType.beginner)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.farmLockDepositTitle3,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        localizations.farmLockDepositDesc3,
                        style: Theme.of(context).textTheme.bodySmallWithOpacity,
                      ),
                    ],
                  ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
