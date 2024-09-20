/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_settings_popup.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddTokenIconSettings extends ConsumerWidget {
  const LiquidityAddTokenIconSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        LiquidityAddSettingsPopup.getDialog(
          context,
        );
      },
      child: Tooltip(
        message: AppLocalizations.of(context)!.liquidityAddTooltipSlippage,
        child: SizedBox(
          height: 40,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: aedappfm.ArchethicThemeBase.brightPurpleHoverBorder
                    .withOpacity(1),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            color: aedappfm.ArchethicThemeBase.brightPurpleHoverBackground
                .withOpacity(1),
            child: const Padding(
              padding: EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 10,
                right: 10,
              ),
              child: Icon(
                aedappfm.Iconsax.setting_2,
                size: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
