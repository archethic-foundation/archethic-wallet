import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/provider.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_confirm_infos.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_result_sheet.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/ui/widgets/consent_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SwapConfirmFormSheet extends ConsumerStatefulWidget {
  const SwapConfirmFormSheet({
    super.key,
  });

  static const String routerPage = '/swap_confirm';

  @override
  ConsumerState<SwapConfirmFormSheet> createState() =>
      SwapConfirmFormSheetState();
}

class SwapConfirmFormSheetState extends ConsumerState<SwapConfirmFormSheet>
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
    final swap = ref.read(swapFormNotifierProvider);
    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          AppLocalizations.of(context)!.btn_confirm_swap,
          Dimens.buttonBottomDimens,
          key: const Key('swap'),
          onPressed: () async {
            final resultOk = await ref
                .read(swapFormNotifierProvider.notifier)
                .swap(AppLocalizations.of(context)!);
            if (resultOk) {
              await context.push(SwapResultSheet.routerPage);
            }
          },
          disabled: (!consentChecked && swap.consentDateTime == null) ||
              swap.isProcessInProgress,
          showProgressIndicator: swap.isProcessInProgress,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return SheetAppBar(
      title: localizations.menu_swap,
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
    final localizations = AppLocalizations.of(context)!;
    final swap = ref.read(swapFormNotifierProvider);
    if (swap.tokenToSwap == null || swap.tokenSwapped == null) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SwapConfirmInfos(),
          const SizedBox(
            height: 20,
          ),
          ConsentWidget(
            consentDateTime: swap.consentDateTime,
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
                  swap.feesEstimatedUCO,
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
