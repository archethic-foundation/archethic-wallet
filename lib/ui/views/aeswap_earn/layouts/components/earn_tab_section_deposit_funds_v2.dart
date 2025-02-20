import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/sheets/bridge_sheet.dart';
import 'package:aewallet/ui/views/sheets/buy_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EarnSectionDepositFundsV2 extends ConsumerWidget {
  const EarnSectionDepositFundsV2({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return aedappfm.BlockInfo(
      blockInfoColor: aedappfm.BlockInfoColor.purple,
      borderWidth: 0,
      paddingEdgeInsetsInfo: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      info: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1. ${localizations.earnSectionDepositFundsTitle}',
            style: AppTextStyles.bodyLargeSecondaryColor(context).copyWith(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(height: 20),
          subSection(
            context,
            ref,
            localizations.earnSectionDepositFundsBeginnerTitle,
            localizations.earnSectionDepositFundsBeginnerDesc,
            localizations.earnSectionDepositFundsBeginnerBuyBtn,
            () async {
              await context.push(BuySheet.routerPage);
            },
          ),
          const SizedBox(height: 20),
          subSection(
            context,
            ref,
            localizations.earnSectionDepositFundsIntermediaryTitle,
            localizations.earnSectionDepositFundsIntermediaryDesc,
            localizations.earnSectionDepositFundsIntermediaryBuyBtn,
            () async {
              await context.push(BuySheet.routerPage);
            },
          ),
          const SizedBox(height: 20),
          subSection(
            context,
            ref,
            localizations.earnSectionDepositFundExpertTitle,
            localizations.earnSectionDepositFundsExpertDesc,
            localizations.earnSectionDepositFundsExpertBridgeBtn,
            () async {
              await context.push(BridgeSheet.routerPage);
            },
          ),
        ],
      ),
    );
  }

  Widget subSection(
    BuildContext context,
    WidgetRef ref,
    String descriptionTitle,
    String description,
    String buttonText,
    Function()? buttonAction,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: '$descriptionTitle - ',
                    style: AppTextStyles.bodySmall(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: description,
                    style: AppTextStyles.bodySmall(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CustomSmallBtn(
                  buttonText: buttonText,
                  onPressed: buttonAction,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
