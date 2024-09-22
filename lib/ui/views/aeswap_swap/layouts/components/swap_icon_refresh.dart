/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/modules/aeswap/application/balance.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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
    return InkWell(
      onTap: () async {
        if (isRefreshSuccess != null && isRefreshSuccess == true) return;
        setState(
          () {
            isRefreshSuccess = true;
          },
        );

        final swapNotifier = ref.read(SwapFormProvider.swapForm.notifier);
        final swap = ref.read(SwapFormProvider.swapForm);
        final accountSelected = ref.watch(
          AccountProviders.accounts.select(
            (accounts) => accounts.valueOrNull?.selectedAccount,
          ),
        );
        final apiService = aedappfm.sl.get<ApiService>();
        if (swap.tokenToSwap != null) {
          final balanceToSwap = await ref.read(
            getBalanceProvider(
              accountSelected!.genesisAddress,
              swap.tokenToSwap!.isUCO ? 'UCO' : swap.tokenToSwap!.address!,
              apiService,
            ).future,
          );
          swapNotifier.setTokenToSwapBalance(balanceToSwap);
        }

        if (swap.tokenSwapped != null) {
          final balanceSwapped = await ref.read(
            getBalanceProvider(
              accountSelected!.genesisAddress,
              swap.tokenSwapped!.isUCO ? 'UCO' : swap.tokenSwapped!.address!,
              apiService,
            ).future,
          );
          swapNotifier.setTokenSwappedBalance(balanceSwapped);
        }

        if (swap.tokenToSwap != null && swap.tokenSwapped != null) {
          await swapNotifier.calculateSwapInfos(
            swap.tokenToSwap!.isUCO ? 'UCO' : swap.tokenToSwap!.address!,
            swap.tokenToSwapAmount,
            true,
          );
          await swapNotifier.getRatio();
          await swapNotifier.getPool();
        }

        await Future.delayed(const Duration(seconds: 3));
        if (mounted) {
          setState(
            () {
              isRefreshSuccess = false;
            },
          );
        }
      },
      child: Tooltip(
        message: AppLocalizations.of(context)!.swapIconRefreshTooltip,
        child: SizedBox(
          height: 40,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: isRefreshSuccess != null && isRefreshSuccess == true
                    ? aedappfm.ArchethicThemeBase.brightPurpleHoverBorder
                        .withOpacity(1)
                    : Colors.transparent,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            color: isRefreshSuccess != null && isRefreshSuccess == true
                ? aedappfm.ArchethicThemeBase.systemPositive600
                : Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 10,
                right: 10,
              ),
              child: Icon(
                isRefreshSuccess != null && isRefreshSuccess == true
                    ? Icons.check
                    : aedappfm.Iconsax.refresh,
                size: 16,
                color: isRefreshSuccess != null && isRefreshSuccess == true
                    ? Colors.white
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
