import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_settings_slippage_tolerance.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';

class LiquidityAddSettingsPopup {
  static Future<void> getDialog(
    BuildContext context,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        return aedappfm.PopupTemplate(
          popupContent: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: const LiquiditySettingsSlippageTolerance(),
          ),
          popupTitle: AppLocalizations.of(context)!.settingsTitle,
          popupHeight: 200,
        );
      },
    );
  }
}
