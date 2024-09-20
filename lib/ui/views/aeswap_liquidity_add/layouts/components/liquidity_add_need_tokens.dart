import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiquidityAddNeedTokens extends ConsumerWidget {
  const LiquidityAddNeedTokens({
    required this.balance,
    required this.token,
    super.key,
  });

  final double balance;
  final DexToken token;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: ArchethicThemeBase.raspberry300,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Buy ${token.symbol}'),
            const SizedBox(
              width: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Icon(
                Icons.arrow_forward_outlined,
                size: 16,
              ),
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
