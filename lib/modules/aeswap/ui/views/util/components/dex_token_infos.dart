/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_icon.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class DexTokenInfos extends StatelessWidget {
  const DexTokenInfos({
    this.token,
    super.key,
  });

  final DexToken? token;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 150,
      height: 30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            aedappfm.ArchethicThemeBase.purple500,
            aedappfm.ArchethicThemeBase.purple500.withOpacity(0.4),
          ],
          stops: const [0, 1],
        ),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              aedappfm.ArchethicThemeBase.paleTransparentBackground,
              aedappfm.ArchethicThemeBase.paleTransparentBackground
                  .withOpacity(0.4),
            ],
            stops: const [0, 1],
          ),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: token != null
          ? Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Row(
                children: [
                  DexTokenIcon(
                    tokenAddress:
                        token!.address == null ? 'UCO' : token!.address!,
                  ),
                  Tooltip(
                    message: token!.symbol,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2, left: 10),
                      child: Text(token!.symbol.reduceSymbol()),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
