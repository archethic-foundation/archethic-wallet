import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_checkbox_confirm_not_multiple_registrations.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_checkbox_confirm_only_one_airdrop.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_checkbox_confirm_privacy_policy.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_stepper.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_textfield_mail.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropParticipateStepJoinWaitlistSheet extends ConsumerStatefulWidget {
  const AirdropParticipateStepJoinWaitlistSheet({
    super.key,
  });

  @override
  ConsumerState<AirdropParticipateStepJoinWaitlistSheet> createState() =>
      _AirdropParticipateStepJoinWaitlistSheetState();
}

class _AirdropParticipateStepJoinWaitlistSheetState
    extends ConsumerState<AirdropParticipateStepJoinWaitlistSheet>
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
          localizations.airdropParticipateStepWaitlistBtn,
          Dimens.buttonBottomDimens,
          onPressed: () async {
            ref
                .read(airdropFormNotifierProvider.notifier)
                .setAirdropProcessStep(AirdropProcessStep.sign);
          },
          disabled: !airdropForm.isItemsConfirmed,
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
              .setAirdropProcessStep(AirdropProcessStep.welcome);
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
            localizations.airdropParticipateStepWaitlistTitle,
            style: AppTextStyles.bodyLarge(context)
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            localizations.airdropParticipateStepWaitlistDesc2,
            style: AppTextStyles.bodyMediumWithOpacity(context),
          ),
          const SizedBox(height: 20),
          const AirdropTextFieldMail(),
          const SizedBox(height: 20),
          const AirdropCheckboxConfirmOnlyOneAirdrop(),
          const SizedBox(height: 20),
          const AirdropCheckboxConfirmNotMultipleRegistrations(),
          const SizedBox(height: 20),
          const AirdropCheckboxConfirmPrivacyPolicy(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
