import 'package:aewallet/ui/views/aeswap_swap/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapChange extends ConsumerWidget {
  const SwapChange({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(swapFormNotifierProvider);

    if (swap.tokenSwapped == null || swap.tokenToSwap == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            aedappfm.Iconsax.arrange_square_2,
            size: 24,
            color: Colors.white.withOpacity(0.2),
          ),
        ],
      );
    }

    final swapNotifier = ref.watch(swapFormNotifierProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            await swapNotifier.swapDirections();
          },
          child: Icon(
            aedappfm.Iconsax.arrange_square_2,
            size: aedappfm.Responsive.fontSizeFromValue(
              context,
              desktopValue: 24,
            ),
          ),
        ),
      ],
    );
  }
}
