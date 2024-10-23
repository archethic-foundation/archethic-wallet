import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_icon.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/provider.dart';
import 'package:aewallet/ui/views/token_selection/layouts/token_selection.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SwapTokenSwappedSelection extends ConsumerWidget {
  const SwapTokenSwappedSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(swapFormNotifierProvider);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    return Container(
      width: aedappfm.Responsive.isMobile(context) ? 100 : 150,
      height: 30,
      decoration: BoxDecoration(
        color: aedappfm.AppThemeBase.sheetBackgroundTertiary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: connectivityStatusProvider == ConnectivityStatus.isDisconnected
            ? null
            : () async {
                final token =
                    await CupertinoScaffold.showCupertinoModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Scaffold(
                      backgroundColor: aedappfm.AppThemeBase.sheetBackground
                          .withOpacity(0.2),
                      body: const TokenSelection(),
                    );
                  },
                );

                if (token == null) return;
                await ref
                    .read(swapFormNotifierProvider.notifier)
                    .setTokenSwapped(token, AppLocalizations.of(context)!);
              },
        child: Opacity(
          opacity:
              connectivityStatusProvider == ConnectivityStatus.isDisconnected
                  ? 0.5
                  : 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  if (swap.tokenSwapped == null)
                    Text(
                      AppLocalizations.of(context)!.btn_selectToken,
                      style: AppTextStyles.bodySmall(context),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: SizedBox(
                        width: aedappfm.Responsive.isMobile(context) ? 90 : 100,
                        child: Row(
                          children: [
                            DexTokenIcon(
                              tokenAddress: swap.tokenSwapped!.address,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                swap.tokenSwapped!.symbol,
                                style: AppTextStyles.bodyMedium(context),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              if (aedappfm.Responsive.isMobile(context) == false)
                const Icon(
                  aedappfm.Iconsax.search_normal,
                  size: 12,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
