/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/ui/views/aeswap_liquidity_add/layouts/components/liquidity_add_settings_popup.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddTokenIconSettings extends ConsumerWidget {
  const LiquidityAddTokenIconSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: aedappfm.AppThemeBase.gradientBtn,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              aedappfm.Iconsax.setting_2,
              color: Colors.white,
              size: 15,
            ),
          ),
          onTap: () {
            LiquidityAddSettingsPopup.getDialog(
              context,
            );
          },
        ),
      ],
    );
  }
}
