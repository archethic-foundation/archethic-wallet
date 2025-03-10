import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/figma_components/text/gradient_text.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropOneLPCurrentValueDollars extends ConsumerWidget {
  const AirdropOneLPCurrentValueDollars({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    if (airdropForm.actualLPFiatValue == 0) {
      return const SizedBox(
        height: 20,
      );
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '${localizations.airdropLPValue}: ',
              style: Theme.of(context).textTheme.bodySmallWithOpacity,
            ),
            WidgetSpan(
              child: GradientText(
                '\$${airdropForm.actualLPFiatValue.formatNumber(precision: 2)} ',
                style: Theme.of(context).textTheme.bodySmallWithOpacity,
                gradient: ArchethicGradients.gradientArchethic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
