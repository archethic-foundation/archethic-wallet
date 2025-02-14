import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_info_popup.dart';
import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_stepper.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AirdropParticipateStepConfirmEmailSheet extends ConsumerStatefulWidget {
  const AirdropParticipateStepConfirmEmailSheet({
    super.key,
  });

  @override
  ConsumerState<AirdropParticipateStepConfirmEmailSheet> createState() =>
      _AirdropParticipateStepJoinWaitlistSheetState();
}

class _AirdropParticipateStepJoinWaitlistSheetState
    extends ConsumerState<AirdropParticipateStepConfirmEmailSheet>
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
                .setAirdropProcessStep(AirdropProcessStep.supportEcosystem);
            return;
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
    final airdropForm = ref.read(airdropFormNotifierProvider);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AirdropStepper(),
          Text(
            localizations.airdropParticipateStepConfirmEmailTitle,
            style: AppTextStyles.bodyLarge(context)
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            localizations.airdropParticipateStepConfirmEmailDesc1,
            style: AppTextStyles.bodyMediumWithOpacity(context),
          ),
          const SizedBox(height: 20),
          Text(
            airdropForm.mailAddress ?? '?',
            style: AppTextStyles.bodyMedium(context)
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Text(
            localizations.airdropParticipateStepConfirmEmailDesc2,
            style: AppTextStyles.bodyMediumWithOpacity(context),
          ),
          InkWell(
            onTap: () async {
              await ref
                  .read(airdropFormNotifierProvider.notifier)
                  .resendConfirmationMail(localizations);
              final airdrop = ref.read(airdropFormNotifierProvider);
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AirdropInfoPopup(
                    message: airdrop.resendConfirmationEmailInfo,
                  );
                },
              );
            },
            child: Text(
              localizations.airdropParticipateStepConfirmEmailDesc3,
              style: AppTextStyles.bodyMedium(context)
                  .copyWith(decoration: TextDecoration.underline),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Text(
                '${localizations.airdropParticipateStepConfirmEmailDesc4} ',
                style: AppTextStyles.bodyMediumWithOpacity(context),
              ),
              InkWell(
                onTap: () => ref
                    .read(airdropFormNotifierProvider.notifier)
                    .setAirdropProcessStep(AirdropProcessStep.joinWaitlist),
                child: Text(
                  localizations.airdropParticipateStepConfirmEmailDesc5,
                  style: AppTextStyles.bodyMedium(context)
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            localizations.airdropParticipateStepConfirmEmailDesc6,
            style: AppTextStyles.bodyMedium(context)
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
