/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/application/session/provider.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_token_icon.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/provider.dart';
import 'package:aewallet/ui/views/token_selection/layouts/token_selection_popup.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwapTokenSwappedSelection extends ConsumerWidget {
  const SwapTokenSwappedSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swap = ref.watch(swapFormNotifierProvider);

    return Container(
      width: aedappfm.Responsive.isMobile(context) ? 100 : 150,
      height: 30,
      decoration: BoxDecoration(
        color: aedappfm.AppThemeBase.sheetBackgroundTertiary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () async {
          final token = await TokenSelectionPopup.getDialog(
            context,
            ref.read(environmentProvider),
          );
          if (token == null) return;
          await ref
              .read(swapFormNotifierProvider.notifier)
              .setTokenSwapped(token);
        },
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
    );
  }
}
