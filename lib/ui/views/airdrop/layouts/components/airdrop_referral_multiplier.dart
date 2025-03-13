import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/figma_components/box/box_dark.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropReferralMultiplier extends ConsumerWidget {
  const AirdropReferralMultiplier({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final airdropForm = ref.watch(airdropFormNotifierProvider);

    return BoxDark(
      textWidget: Text(
        '${airdropForm.referralMultiplier}x',
        style: AppTextStyles.bodyLarge(context).copyWith(
          fontSize: 24,
          fontWeight: FontWeightTelegraf.fontWeightBold,
        ),
      ),
      additionalWidget: Column(
        children: [
          Text(
            localizations.airdropReferrallMultiplier,
            style: Theme.of(context).textTheme.bodyMediumWithOpacity,
            textAlign: TextAlign.center,
          ),
          Text(
            ' ',
            style: Theme.of(context)
                .textTheme
                .bodySmallWithOpacity
                .copyWith(fontSize: 8),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
