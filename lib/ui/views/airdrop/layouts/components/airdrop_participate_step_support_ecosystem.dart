import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_lp_current_value.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_step_tab.dart';
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

class AirdropParticipateStepSupportEcosystemSheet
    extends ConsumerStatefulWidget {
  const AirdropParticipateStepSupportEcosystemSheet({
    super.key,
  });

  @override
  ConsumerState<AirdropParticipateStepSupportEcosystemSheet> createState() =>
      _AirdropParticipateStepSupportEcosystemSheetState();
}

class _AirdropParticipateStepSupportEcosystemSheetState
    extends ConsumerState<AirdropParticipateStepSupportEcosystemSheet>
    implements SheetSkeletonInterface {
  @override
  Widget build(
    BuildContext context,
  ) {
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
    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          localizations.airdropParticipateStepSupportEcosystemBtn,
          Dimens.buttonBottomDimens,
          onPressed: () async {
            ref
                .read(airdropFormNotifierProvider.notifier)
                .setAirdropProcessStep(AirdropProcessStep.congrats);
          },
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.airdropParticipateTitle,
      widgetLeft: CloseButton(
        key: const Key('close'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final farmLock = ref.watch(farmLockFormFarmLockProvider).valueOrNull;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.airdropParticipateStepSupportEcosystemTitle,
            style: AppTextStyles.bodyLarge(context)
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      localizations.airdropParticipateStepSupportEcosystemDesc1,
                  style: AppTextStyles.bodyMediumWithOpacity(context),
                ),
                TextSpan(
                  text: farmLock != null && farmLock.apr3years > 0
                      ? '${(farmLock.apr3years * 100).formatNumber(precision: 2)}% return'
                      : '___% return',
                  style: AppTextStyles.bodyMediumSecondaryColor(context),
                ),
                TextSpan(
                  text:
                      localizations.airdropParticipateStepSupportEcosystemDesc2,
                  style: AppTextStyles.bodyMediumWithOpacity(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const AirdropLPCurrentValue(),
          const SizedBox(height: 10),
          const AirdropStepTab(),
        ],
      ),
    );
  }
}
