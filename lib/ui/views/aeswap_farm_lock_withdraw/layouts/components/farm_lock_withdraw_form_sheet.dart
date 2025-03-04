import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/failure_message.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/fiat_value.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/message_box/message_box.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
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
    return BtnFooterPrimary(
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
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.farmLockWithdrawFormTitle,
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

    if (farmLockWithdraw.rewardToken == null ||
        farmLockWithdraw.depositedAmount == null) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                      style: Theme.of(context).textTheme.bodyMediumWithOpacity,
                    ),
                    const SizedBox(height: 20),
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
                                        .farmLockWithdrawFormTextNoRewardText2,
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
                    Text(
                      localizations.farmLockWithdrawTextFieldLPLabel,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightBold,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const FarmLockWithdrawAmount(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                MessageBox(
                  messageBoxType: MessageBoxType.warning,
                  text: FailureMessage(
                    context: context,
                    failure: farmLockWithdraw.failure,
                  ).getMessage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
