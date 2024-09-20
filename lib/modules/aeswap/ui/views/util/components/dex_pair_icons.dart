import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DexPairIcons extends ConsumerWidget {
  const DexPairIcons({
    required this.token1Address,
    required this.token2Address,
    this.iconSize = 20,
    super.key,
  });

  final String token1Address;
  final String token2Address;
  final double? iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      children: [
        DexTokenIcon(tokenAddress: token1Address, iconSize: iconSize),
        Padding(
          padding: EdgeInsets.only(left: iconSize! * 1.5),
          child: DexTokenIcon(tokenAddress: token2Address, iconSize: iconSize),
        ),
      ],
    );
  }
}
