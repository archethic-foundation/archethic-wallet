import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/consent_uri.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_confirm_infos.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_result_sheet.dart';
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

class LiquidityAddConfirmFormSheet extends ConsumerStatefulWidget {
  const LiquidityAddConfirmFormSheet({
    super.key,
  });

  @override
  ConsumerState<LiquidityAddConfirmFormSheet> createState() =>
      LiquidityAddConfirmFormSheetState();
}

class LiquidityAddConfirmFormSheetState
    extends ConsumerState<LiquidityAddConfirmFormSheet>
    implements SheetSkeletonInterface {
  bool consentChecked = false;

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
    final liquidityAdd = ref.watch(liquidityAddFormNotifierProvider);
    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          AppLocalizations.of(context)!.btn_confirm_liquidity_add,
          Dimens.buttonBottomDimens,
          key: const Key('addLiquidity'),
          onPressed: () async {
            final resultOk = await ref
                .read(liquidityAddFormNotifierProvider.notifier)
                .add(AppLocalizations.of(context)!);
            if (resultOk) {
              await context.push(LiquidityAddResultSheet.routerPage);
            }
          },
          disabled: (!consentChecked && liquidityAdd.consentDateTime == null) ||
              liquidityAdd.isProcessInProgress,
          showProgressIndicator: liquidityAdd.isProcessInProgress,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final liquidityAddNotifier =
        ref.watch(liquidityAddFormNotifierProvider.notifier);

    return SheetAppBar(
      title: localizations.addLiquidity,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          liquidityAddNotifier.setLiquidityAddProcessStep(
            aedappfm.ProcessStep.form,
          );
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final liquidityAdd = ref.watch(liquidityAddFormNotifierProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15),
          const LiquidityAddConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          if (liquidityAdd.consentDateTime == null)
            aedappfm.ConsentToCheck(
              consentChecked: consentChecked,
              onToggleConsent: (newValue) {
                setState(() {
                  consentChecked = newValue!;
                });
              },
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
            )
          else
            aedappfm.ConsentAlready(
              consentDateTime: liquidityAdd.consentDateTime!,
              uriPrivacyPolicy: kURIPrivacyPolicy,
              uriTermsOfUse: kURITermsOfUse,
            ),
          SheetDetailCard(
            children: [
              Text(
                localizations.estimatedTxFees,
                style: AppTextStyles.bodyMedium(context),
              ),
              Text(
                AmountFormatters.standardSmallValue(
                  liquidityAdd.feesEstimatedUCO,
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
