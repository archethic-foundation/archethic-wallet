/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class DexFees extends StatelessWidget {
  const DexFees({
    required this.fees,
    this.withLabel = true,
    super.key,
  });

  final double fees;
  final bool withLabel;

  @override
  Widget build(BuildContext context) {
    if (fees == 0) {
      return const SizedBox(
        height: 30,
      );
    }

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: aedappfm.ArchethicThemeBase.blue600,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Opacity(
        opacity: AppTextStyles.kOpacityText,
        child: withLabel
            ? SelectableText(
                '${AppLocalizations.of(context)!.feesLbl}: $fees%',
                style: Theme.of(context).textTheme.labelSmall,
              )
            : SelectableText(
                '$fees%',
                style: Theme.of(context).textTheme.labelSmall,
              ),
      ),
    );
  }
}
