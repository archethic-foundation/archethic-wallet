import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/format_address_link_copy_big_icon.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_claim/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_claim/layouts/components/farm_lock_claim_final_amount.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockClaimResultSheet extends ConsumerStatefulWidget {
  const FarmLockClaimResultSheet({
    super.key,
  });

  static const String routerPage = '/farmLockClaim_result';

  @override
  ConsumerState<FarmLockClaimResultSheet> createState() =>
      FarmLockClaimResultSheetState();
}

class FarmLockClaimResultSheetState
    extends ConsumerState<FarmLockClaimResultSheet>
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
            ref.invalidate(farmLockClaimFormNotifierProvider);
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
      title: localizations.farmLockClaimFormTitle,
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final farmLockClaim = ref.watch(farmLockClaimFormNotifierProvider);
    if (farmLockClaim.rewardAmount == 0) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetDetailCard(
              children: [
                Text(
                  AppLocalizations.of(context)!.farmLockClaimSuccessInfo,
                  style: AppTextStyles.bodyLarge(context).copyWith(
                    color: aedappfm.ArchethicThemeBase.systemPositive600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (farmLockClaim.transactionClaimFarmLock != null &&
                farmLockClaim.transactionClaimFarmLock!.address != null &&
                farmLockClaim.transactionClaimFarmLock!.address!.address !=
                    null)
              FormatAddressLinkCopyBigIcon(
                address: farmLockClaim
                    .transactionClaimFarmLock!.address!.address!
                    .toUpperCase(),
                header: AppLocalizations.of(context)!.farmLockClaimTxAddress,
                typeAddress: TypeAddressLinkCopyBigIcon.transaction,
                reduceAddress: true,
                fontSize: 16,
                iconSize: 26,
              ),
            const SizedBox(
              height: 20,
            ),
            const SheetDetailCard(
              children: [
                FarmLockClaimFinalAmount(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
