import 'package:aewallet/application/feature_flags.dart';
import 'package:aewallet/main.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/sheets/buy_sheet.dart';
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
    final onRampFiatFeatureFlag = ref
        .watch(getFeatureFlagProvider(kApplicationCode, 'on-ramp-fiat'))
        .valueOrNull;
    final onRampCryptoFeatureFlag = ref
        .watch(getFeatureFlagProvider(kApplicationCode, 'on-ramp-crypto'))
        .valueOrNull;

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
            style: Theme.of(context).textTheme.titleSmallSemiBold,
          ),
          if (onRampFiatFeatureFlag != null && onRampFiatFeatureFlag == true)
            Column(
              children: [
                const SizedBox(height: 20),
                subSection(
                  context,
                  ref,
                  localizations.earnSectionDepositFundsOptionFiatTitle,
                  localizations.earnSectionDepositFundsOptionFiatDesc,
                  localizations.earnSectionDepositFundsOptionFiatBuyBtn,
                  () async {
                    await context.push(BuySheet.routerPage);
                  },
                ),
              ],
            ),
          if (onRampCryptoFeatureFlag != null &&
              onRampCryptoFeatureFlag == true)
            Column(
              children: [
                const SizedBox(height: 20),
                subSection(
                  context,
                  ref,
                  localizations.earnSectionDepositFundsOptionCryptoTitle,
                  localizations.earnSectionDepositFundsOptionCryptoDesc,
                  localizations.earnSectionDepositFundsOptionCryptoBuyBtn,
                  () async {
                    await context.push(BuySheet.routerPage);
                  },
                ),
              ],
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
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeightTelegraf.fontWeightBold,
                        ),
                  ),
                  TextSpan(
                    text: description,
                    style: Theme.of(context).textTheme.bodySmallWithOpacity,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                BtnPrimary(
                  buttonText: buttonText,
                  onTap: buttonAction,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
