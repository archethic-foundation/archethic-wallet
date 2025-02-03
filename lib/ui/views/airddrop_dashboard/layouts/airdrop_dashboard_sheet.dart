import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/airdrop/airdrop_notifier.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_lp_available.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_lp_current_value.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_participants_count.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_personal_multiplier.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_personal_rewards.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_step_tab.dart';
import 'package:aewallet/ui/views/main/bloc/providers.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AirdropDashboardSheet extends ConsumerStatefulWidget {
  const AirdropDashboardSheet({
    super.key,
  });

  static const String routerPage = '/airdrop_dashboard';

  @override
  ConsumerState<AirdropDashboardSheet> createState() =>
      _AirdropDashboardSheetState();
}

class _AirdropDashboardSheetState extends ConsumerState<AirdropDashboardSheet>
    implements SheetSkeletonInterface {
  int personalMultiplier = 0;

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

    ref.watch(airdropNotifierProvider).when(
          data: (airdrop) {
            if (airdrop != null) {
              personalMultiplier = airdrop.personalMultiplier;
            }
          },
          loading: () {},
          error: (error, stack) {},
        );

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
          personalMultiplier > 0
              ? localizations.airdropDashboardIncreaseLevelBtn
              : localizations.airdropDashboardNoLPBtn,
          Dimens.buttonBottomDimens,
          onPressed: () async {
            await ref
                .read(SettingsProviders.settings.notifier)
                .setMainScreenCurrentPage(3);
            ref.read(mainTabControllerProvider)!.animateTo(
                  3,
                  duration: Duration.zero,
                );
            context.pop();
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

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: AirdropParticipantsCount(),
          ),
          Text(
            personalMultiplier > 0
                ? localizations.airdropDashboardCongratsTitle
                : localizations.airdropDashboardCompleteParticipationTitle,
            style: AppTextStyles.bodyLarge(context)
                .copyWith(fontWeight: FontWeight.bold),
          ),
          if (personalMultiplier == 0)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                ' ${localizations.airdropDashboardCompleteParticipationDesc}',
                style: AppTextStyles.bodyMedium(context),
              ),
            ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: AirdropPersonalMultiplier(),
              ),
              SizedBox(width: 10),
              Flexible(
                child: AirdropPersonalRewards(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const AirdropLPCurrentValue(),
          const SizedBox(height: 10),
          const AirdropAvailable(),
          const SizedBox(height: 10),
          const AirdropStepTab(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
