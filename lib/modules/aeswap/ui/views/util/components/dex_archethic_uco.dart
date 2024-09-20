import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';

class DexArchethicOracleUco extends StatelessWidget {
  const DexArchethicOracleUco({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Opacity(
      opacity: AppTextStyles.kOpacityText,
      child: aedappfm.ArchethicOracleUco(
        faqLink:
            'https://wiki.archethic.net/FAQ/dex/#how-is-the-price-of-uco-estimated',
        precision: 4,
      ),
    );
  }
}
