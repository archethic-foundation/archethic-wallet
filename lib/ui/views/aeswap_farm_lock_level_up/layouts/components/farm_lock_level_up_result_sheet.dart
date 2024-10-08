import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/format_address_link_copy_big_icon.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_level_up/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_level_up/layouts/components/farm_lock_level_up_final_amount.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockLevelUpResultSheet extends ConsumerStatefulWidget {
  const FarmLockLevelUpResultSheet({
    super.key,
  });

  static const String routerPage = '/farmLockLevelUp_result';

  @override
  ConsumerState<FarmLockLevelUpResultSheet> createState() =>
      FarmLockLevelUpResultSheetState();
}

class FarmLockLevelUpResultSheetState
    extends ConsumerState<FarmLockLevelUpResultSheet>
    implements SheetSkeletonInterface {
  @override
  Widget build(BuildContext context) {
    final accountSelected = ref.watch(
      AccountProviders.accounts.select(
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
    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          AppLocalizations.of(context)!.close,
          Dimens.buttonBottomDimens,
          key: const Key('close'),
          onPressed: () async {
            ref.invalidate(farmLockLevelUpFormNotifierProvider);
            context
              ..pop()
              ..pop();
          },
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return SheetAppBar(
      title: localizations.farmLockLevelUpFormTitle,
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final farmLockLevelUp = ref.watch(farmLockLevelUpFormNotifierProvider);
    if (farmLockLevelUp.amount == 0) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.levelUpFarmLockDone,
              style: AppTextStyles.bodyLarge(context).copyWith(
                color: aedappfm.ArchethicThemeBase.systemPositive600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (farmLockLevelUp.transactionFarmLockLevelUp != null &&
                farmLockLevelUp.transactionFarmLockLevelUp!.address != null &&
                farmLockLevelUp.transactionFarmLockLevelUp!.address!.address !=
                    null)
              FormatAddressLinkCopyBigIcon(
                address: farmLockLevelUp
                    .transactionFarmLockLevelUp!.address!.address!
                    .toUpperCase(),
                header: AppLocalizations.of(context)!.farmLockLevelUpTxAddress,
                typeAddress: TypeAddressLinkCopyBigIcon.transaction,
                reduceAddress: true,
                fontSize: 16,
                iconSize: 26,
              ),
            const SizedBox(
              height: 20,
            ),
            const FarmLockLevelUpFinalAmount(),
          ],
        ),
      ),
    );
  }
}
