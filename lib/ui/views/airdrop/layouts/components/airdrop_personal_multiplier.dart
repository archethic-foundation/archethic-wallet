import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropPersonalMultiplier extends ConsumerWidget {
  const AirdropPersonalMultiplier({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final airdropForm = ref.watch(airdropFormNotifierProvider);

    return aedappfm.BlackBoxInfo(
      textWidget: Text(
        '${airdropForm.personalMultiplier}x',
        style: AppTextStyles.bodyLarge(context).copyWith(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      additionalWidget: Column(
        children: [
          Text(
            localizations.airdropPersonalMultiplier,
            style: AppTextStyles.bodyMediumWithOpacity(context),
            textAlign: TextAlign.center,
          ),
          Text(
            ' ',
            style: AppTextStyles.bodySmallWithOpacity(context)
                .copyWith(fontSize: 8),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
