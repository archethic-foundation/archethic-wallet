import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class EarnSectionDepositFunds extends ConsumerWidget {
  const EarnSectionDepositFunds({
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
            '1. ${localizations.earnSectionDepositFundsV1Title1}',
            style: AppTextStyles.bodyLargeSecondaryColor(context).copyWith(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              text: '',
              children: <InlineSpan>[
                TextSpan(
                  text: '${localizations.earnSectionDepositFundsV1Desc1} - ',
                  style: AppTextStyles.bodySmallWithOpacity(context),
                ),
                TextSpan(
                  text: localizations.earnSectionDepositFundsV1Desc1ComingSoon,
                  style: AppTextStyles.bodySmall(context).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text(
            localizations.earnSectionDepositFundsV1Title2,
            style: AppTextStyles.bodyLargeSecondaryColor(context).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            localizations.earnSectionDepositFundsV1Desc2,
            style: AppTextStyles.bodySmallWithOpacity(context),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              CustomSmallBtn(
                buttonText: localizations.earnSectionDepositFundsTutoBtn,
                onPressed: () async {
                  await launchUrl(
                    Uri.parse(
                      'https://www.archethic.net/buy-and-farm-uco-tutorial',
                    ),
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            localizations.earnSectionDepositFundsNote,
            style: AppTextStyles.bodySmallWithOpacity(context)
                .copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
