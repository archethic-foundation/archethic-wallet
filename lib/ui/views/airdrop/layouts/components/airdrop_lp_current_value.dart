import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropLPCurrentValue extends ConsumerWidget {
  const AirdropLPCurrentValue({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    if (airdropForm.actualLPFiatValue == 0) {
      return const SizedBox(
        height: 20,
      );
    }

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text:
                '\$${airdropForm.actualLPFiatValue.formatNumber(precision: 2)} ',
            style: AppTextStyles.bodyMediumSecondaryColor(context),
          ),
          TextSpan(
            text: localizations.airdropLPValue,
            style: AppTextStyles.bodyMedium(context),
          ),
        ],
      ),
    );
  }
}
