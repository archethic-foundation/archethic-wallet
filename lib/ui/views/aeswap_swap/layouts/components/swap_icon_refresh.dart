import 'package:aewallet/modules/aeswap/application/balance.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapTokenIconRefresh extends ConsumerStatefulWidget {
  const SwapTokenIconRefresh({
    super.key,
  });

  @override
  ConsumerState<SwapTokenIconRefresh> createState() =>
      _SwapTokenIconRefreshState();
}

class _SwapTokenIconRefreshState extends ConsumerState<SwapTokenIconRefresh> {
  bool? isRefreshSuccess;

  @override
  void initState() {
    super.initState();
    isRefreshSuccess = false;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isRefreshSuccess != null && isRefreshSuccess == true
            ? Icons.check
            : aedappfm.Iconsax.refresh,
        size: 16,
        color: isRefreshSuccess != null && isRefreshSuccess == true
            ? Colors.white
            : null,
      ),
      onPressed: () async {
        if (isRefreshSuccess != null && isRefreshSuccess == true) return;
        setState(
          () {
            isRefreshSuccess = true;
          },
        );

        final swapNotifier = ref.read(swapFormNotifierProvider.notifier);
        final swap = ref.read(swapFormNotifierProvider);

        if (swap.tokenToSwap != null) {
          final balanceToSwap = await ref.read(
            getBalanceProvider(
              swap.tokenToSwap!.isUCO ? 'UCO' : swap.tokenToSwap!.address,
            ).future,
          );
          swapNotifier.setTokenToSwapBalance(balanceToSwap);
        }

        if (swap.tokenSwapped != null) {
          final balanceSwapped = await ref.read(
            getBalanceProvider(
              swap.tokenSwapped!.isUCO ? 'UCO' : swap.tokenSwapped!.address,
            ).future,
          );
          swapNotifier.setTokenSwappedBalance(balanceSwapped);
        }

        if (swap.tokenToSwap != null && swap.tokenSwapped != null) {
          await swapNotifier.calculateSwapInfos(
            swap.tokenToSwap!.isUCO ? 'UCO' : swap.tokenToSwap!.address,
            swap.tokenToSwapAmount,
            true,
          );
          await swapNotifier.getRatio();
          await swapNotifier.getPool();
        }

        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          setState(
            () {
              isRefreshSuccess = false;
            },
          );
        }
      },
    );
  }
}
