import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class AirdropInfoNoLP extends ConsumerWidget {
  const AirdropInfoNoLP({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    if (airdropForm.personalLP > 0) {
      return const SizedBox.shrink();
    }

    AppTextStyles.bodyMediumSecondaryColor(context);

    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: aedappfm.ArchethicThemeBase.systemDanger500,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      child: Stack(
        children: [
          Icon(
            Symbols.report,
            color: aedappfm.ArchethicThemeBase.systemDanger500,
            size: 14,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              localizations.airdropInfoNoLPDesc,
              style: AppTextStyles.bodySmall(context),
            ),
          ),
        ],
      ),
    );
  }
}
