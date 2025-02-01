import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_stepper.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class AirdropParticipateStepSignSheet extends ConsumerStatefulWidget {
  const AirdropParticipateStepSignSheet({
    super.key,
  });

  @override
  ConsumerState<AirdropParticipateStepSignSheet> createState() =>
      _AirdropParticipateStepSignSheetState();
}

class _AirdropParticipateStepSignSheetState
    extends ConsumerState<AirdropParticipateStepSignSheet>
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
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          localizations.airdropParticipateStepSignBtn,
          Dimens.buttonBottomDimens,
          onPressed: () async {
            await ref.read(airdropFormNotifierProvider.notifier).joinWaitlist(
                  localizations,
                );
          },
          disabled: airdropForm.joinWaitlistInProgress,
          showProgressIndicator: airdropForm.joinWaitlistInProgress,
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
        onPressed: () {
          ref
              .read(airdropFormNotifierProvider.notifier)
              .setAirdropProcessStep(AirdropProcessStep.joinWaitlist);
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
          const AirdropStepper(),
          Text(
            localizations.airdropParticipateStepSignTitle,
            style: AppTextStyles.bodyLarge(context)
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            localizations.airdropParticipateStepSignDesc,
            style: AppTextStyles.bodyMediumWithOpacity(context),
          ),
          const SizedBox(height: 20),
          Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: Container(
                    height: 16,
                    width: 16,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: aedappfm.AppThemeBase.gradientBtn,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Symbols.verified_user,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
                TextSpan(
                  text: ' ${localizations.airdropParticipateStepSignWarn}',
                  style: AppTextStyles.bodyMedium(context),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
