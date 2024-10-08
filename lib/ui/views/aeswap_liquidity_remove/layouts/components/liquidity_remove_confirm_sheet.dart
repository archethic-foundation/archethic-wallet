import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/layouts/components/liquidity_remove_confirm_infos.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_remove/layouts/components/liquidity_remove_result_sheet.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/ui/widgets/consent_widget.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LiquidityRemoveConfirmFormSheet extends ConsumerStatefulWidget {
  const LiquidityRemoveConfirmFormSheet({
    super.key,
  });

  @override
  ConsumerState<LiquidityRemoveConfirmFormSheet> createState() =>
      LiquidityRemoveConfirmFormSheetState();
}

class LiquidityRemoveConfirmFormSheetState
    extends ConsumerState<LiquidityRemoveConfirmFormSheet>
    implements SheetSkeletonInterface {
  bool consentChecked = false;

  @override
  Widget build(BuildContext context) {
    final accountSelected = ref.read(
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
    final liquidityRemove = ref.watch(liquidityRemoveFormNotifierProvider);
    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          AppLocalizations.of(context)!.btn_confirm_liquidity_remove,
          Dimens.buttonBottomDimens,
          key: const Key('removeLiquidity'),
          onPressed: () async {
            final liquidityRemoveFormNotifier = ref
                .read(liquidityRemoveFormNotifierProvider.notifier)
              ..setProcessInProgress(true);
            final resultOk = await liquidityRemoveFormNotifier
                .remove(AppLocalizations.of(context)!);
            if (resultOk) {
              liquidityRemoveFormNotifier.setProcessInProgress(false);
              await context.push(LiquidityRemoveResultSheet.routerPage);
            }
          },
          disabled:
              (!consentChecked && liquidityRemove.consentDateTime == null) ||
                  liquidityRemove.isProcessInProgress,
          showProgressIndicator: liquidityRemove.isProcessInProgress,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final liquidityRemoveNotifier =
        ref.read(liquidityRemoveFormNotifierProvider.notifier);

    return SheetAppBar(
      title: localizations.removeLiquidity,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          liquidityRemoveNotifier.setLiquidityRemoveProcessStep(
            aedappfm.ProcessStep.form,
          );
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final liquidityRemove = ref.read(liquidityRemoveFormNotifierProvider);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LiquidityRemoveConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          ConsentWidget(
            consentDateTime: liquidityRemove.consentDateTime,
            consentChecked: consentChecked,
            onToggleConsent: (newValue) {
              setState(() {
                consentChecked = newValue!;
              });
            },
            textStyle: AppTextStyles.bodyMedium(
              context,
            ),
          ),
          SheetDetailCard(
            children: [
              Text(
                localizations.estimatedTxFees,
                style: AppTextStyles.bodyMedium(context),
              ),
              Text(
                AmountFormatters.standardSmallValue(
                  liquidityRemove.feesEstimatedUCO,
                  'UCO',
                ),
                style: AppTextStyles.bodyMedium(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
