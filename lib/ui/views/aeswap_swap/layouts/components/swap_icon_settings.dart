import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_settings_popup.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapTokenIconSettings extends ConsumerWidget {
  const SwapTokenIconSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Container(
            height: 36,
            width: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: aedappfm.AppThemeBase.gradientBtn,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              aedappfm.Iconsax.setting_2,
              color: Colors.white,
              size: 18,
            ),
          ),
          onTap: () {
            SwapSettingsPopup.getDialog(
              context,
            );
          },
        ),
      ],
    );
  }
}
