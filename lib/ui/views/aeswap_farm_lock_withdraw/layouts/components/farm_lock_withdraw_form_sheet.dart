import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/settings.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_lp_token_fiat_value.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/fiat_value.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/complex/estimated_fees.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/message_box/message_box.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/aeswap_earn/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_farm_lock_withdraw/layouts/components/farm_lock_withdraw_textfield_amount.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmLockWithdrawFormSheet extends ConsumerWidget
    implements SheetSkeletonInterface {
  const FarmLockWithdrawFormSheet({
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
    final farmLockWithdraw = ref.watch(farmLockWithdrawFormNotifierProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        EstimatedFees(farmLockWithdraw.feeEstimation),
        BtnFooterPrimary(
          buttonText: localizations.btn_farm_withdraw,
          key: const Key('farmLockWithdraw'),
          onTap: () async {
            await ref
                .read(
                  farmLockWithdrawFormNotifierProvider.notifier,
                )
                .validateForm(AppLocalizations.of(context)!);
          },
          isLocked: !farmLockWithdraw.isControlsOk,
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
          ? localizations.farmLockWithdrawFormTitleBeginner
          : localizations.farmLockWithdrawFormTitle,
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
    final farmLockWithdraw = ref.watch(farmLockWithdrawFormNotifierProvider);
    final localizations = AppLocalizations.of(context)!;
    final boldBodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeightTelegraf.fontWeightBold);
    final earnUserLevel = ref.watch(
      SettingsProviders.settings.select((settings) => settings.earnUserLevel),
    );
    final pool = ref.watch(farmLockFormPoolProvider).valueOrNull;

    if (farmLockWithdraw.rewardToken == null ||
        farmLockWithdraw.depositedAmount == null ||
        farmLockWithdraw.rewardAmount == null) {
      return const Padding(
        padding: EdgeInsets.only(top: 120, bottom: 120),
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 0.5),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (earnUserLevel == EarnUserLevelType.advanced)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizations.farmLockWithdrawTitle,
                            style: boldBodyLarge,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            localizations.farmLockWithdrawDesc,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMediumWithOpacity,
                          ),
                        ],
                      )
                    else
                      Text(
                        localizations.farmLockWithdrawDescBeginner,
                        style:
                            Theme.of(context).textTheme.bodyMediumWithOpacity,
                      ),
                    const SizedBox(height: 20),
                    if (earnUserLevel == EarnUserLevelType.advanced)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizations.farmLockWithdrawTextFieldLPLabel,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeightTelegraf.fontWeightBold,
                                ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const FarmLockWithdrawAmount(),
                        ],
                      )
                    else if (farmLockWithdraw.depositedAmount == 0)
                      MessageBox(
                        messageBoxType: MessageBoxType.info,
                        text: AppLocalizations.of(context)!
                            .farmLockWithdrawFormTextNoLPText1,
                      )
                    else
                      Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text:
                                  '${farmLockWithdraw.depositedAmount!.formatNumber()} ${farmLockWithdraw.depositedAmount! > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken} ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMediumWithOpacity
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            TextSpan(
                              text: ref.watch(
                                dexLPTokenFiatValueProvider(
                                  pool!.pair.token1,
                                  pool.pair.token2,
                                  farmLockWithdraw.depositedAmount!,
                                  pool.poolAddress,
                                ),
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMediumWithOpacity,
                            ),
                            TextSpan(
                              text: AppLocalizations.of(context)!
                                  .farmLockWithdrawFormTextLPText2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMediumWithOpacity,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (farmLockWithdraw.rewardAmount == 0)
                  MessageBox(
                    messageBoxType: MessageBoxType.info,
                    text: AppLocalizations.of(context)!
                        .farmLockWithdrawFormTextNoRewardText1,
                  )
                else
                  FutureBuilder<String>(
                    future: FiatValue().display(
                      ref,
                      farmLockWithdraw.rewardToken!,
                      farmLockWithdraw.rewardAmount!,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text.rich(
                          TextSpan(
                            text: '',
                            children: <InlineSpan>[
                              TextSpan(
                                text:
                                    '${farmLockWithdraw.rewardAmount!.formatNumber()} ${farmLockWithdraw.rewardToken!.symbol} ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMediumWithOpacity
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              TextSpan(
                                text: '${snapshot.data}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMediumWithOpacity,
                              ),
                              TextSpan(
                                text: AppLocalizations.of(context)!
                                    .farmLockWithdrawFormTextRewardText2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMediumWithOpacity,
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                const SizedBox(
                  height: 10,
                ),
                MessageBox(
                  messageBoxType: MessageBoxType.warning,
                  text: FailureMessage(
                    context: context,
                    failure: farmLockWithdraw.failure,
                  ).getMessage(),
                ),
                if (earnUserLevel == EarnUserLevelType.beginner)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        localizations.farmLockWithdrawTitle,
                        style: boldBodyLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        localizations.farmLockWithdrawDesc2Beginner,
                        style:
                            Theme.of(context).textTheme.bodyMediumWithOpacity,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
