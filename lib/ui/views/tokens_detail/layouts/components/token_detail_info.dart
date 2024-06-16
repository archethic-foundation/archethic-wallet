import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TokenDetailInfo extends ConsumerWidget {
  const TokenDetailInfo({
    super.key,
    required this.aeToken,
  });

  final AEToken aeToken;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(SettingsProviders.settings);
    final price = ref.watch(
      aedappfm.AETokensProviders.estimateTokenInFiat(
        aeToken,
      ),
    );
    return Column(
      children: [
        if (aeToken.icon != null && aeToken.icon!.isNotEmpty)
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              SvgPicture.asset(
                'assets/bc-logos/${aeToken.icon}',
                width: 20,
                height: 20,
              ),
            ],
          ),
        const SizedBox(
          height: 10,
        ),
        if (settings.showBalances == true)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${aeToken.balance.formatNumber(precision: 8)} ${aeToken.symbol}',
                style: ArchethicThemeStyles.textStyleSize16W600Primary,
              ),
              const SizedBox(width: 5),
              AutoSizeText(
                '\$${(aeToken.balance * price).formatNumber(precision: 2)}',
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
              ),
            ],
          )
        else
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '···········',
                style: ArchethicThemeStyles.textStyleSize16W400Primary60,
              ),
              const SizedBox(width: 5),
              AutoSizeText(
                '···········',
                style: ArchethicThemeStyles.textStyleSize12W100Primary60,
              ),
            ],
          ),
      ],
    );
  }
}
