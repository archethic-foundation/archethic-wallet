import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_bloc_info.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AirdropParticipateStepWelcomeSheet extends ConsumerStatefulWidget {
  const AirdropParticipateStepWelcomeSheet({super.key});

  @override
  ConsumerState<AirdropParticipateStepWelcomeSheet> createState() =>
      _AirdropParticipateStepWelcomeSheetState();
}

class _AirdropParticipateStepWelcomeSheetState
    extends ConsumerState<AirdropParticipateStepWelcomeSheet>
    implements SheetSkeletonInterface {
  @override
  Widget build(BuildContext context) {
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
          localizations.airdropParticipateStepWelcomeBtn,
          Dimens.buttonBottomDimens,
          onPressed: () {
            ref
                .read(airdropFormNotifierProvider.notifier)
                .setAirdropProcessStep(AirdropProcessStep.joinWaitlist);
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
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () => context.pop(),
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final boldBodyLarge =
        AppTextStyles.bodyLarge(context).copyWith(fontWeight: FontWeight.bold);
    final bodyMediumWithOpacity = AppTextStyles.bodyMediumWithOpacity(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.airdropParticipateStepWelcomeTitle,
            style: boldBodyLarge,
          ),
          const SizedBox(height: 10),
          Text(
            localizations.airdropParticipateStepWelcomeDesc1,
            style: bodyMediumWithOpacity,
          ),
          const SizedBox(height: 40),
          const AirdropBlocInfo(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
