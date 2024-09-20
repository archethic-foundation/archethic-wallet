/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';

class DexRatio extends StatelessWidget {
  const DexRatio({
    required this.ratio,
    required this.token1Symbol,
    required this.token2Symbol,
    this.textStyle,
    super.key,
  });

  final double ratio;
  final String token1Symbol;
  final String token2Symbol;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    if (token1Symbol.isEmpty || token2Symbol.isEmpty || ratio <= 0) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      child: token1Symbol == token1Symbol.reduceSymbol() &&
              token2Symbol == token2Symbol.reduceSymbol()
          ? SelectableText(
              '${double.parse('1').formatNumber()} ${token1Symbol.reduceSymbol()} = ${ratio.formatNumber()} ${token2Symbol.reduceSymbol()}',
              style: textStyle ?? AppTextStyles.bodyLarge(context),
            )
          : Tooltip(
              message:
                  '${double.parse('1').formatNumber()} $token1Symbol = ${ratio.formatNumber()} $token2Symbol',
              child: SelectableText(
                '${double.parse('1').formatNumber()} ${token1Symbol.reduceSymbol()} = ${ratio.formatNumber()} ${token2Symbol.reduceSymbol()}',
                style: textStyle ?? AppTextStyles.bodyLarge(context),
              ),
            ),
    );
  }
}
