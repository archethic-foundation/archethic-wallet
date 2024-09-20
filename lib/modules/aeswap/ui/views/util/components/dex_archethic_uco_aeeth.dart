/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/application/dex_token.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ArchethicOraclePair extends ConsumerWidget {
  const ArchethicOraclePair({
    required this.token1,
    required this.token2,
    super.key,
  });

  final DexToken token1;
  final DexToken token2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valueToken1 =
        ref.watch(DexTokensProviders.estimateTokenInFiat(token1));
    final valueToken2 =
        ref.watch(DexTokensProviders.estimateTokenInFiat(token2));

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        valueToken1.when(
          data: (fiatValueToken1) {
            if (fiatValueToken1 == 0) {
              return const SizedBox.shrink();
            }
            final timestamp = DateFormat.yMd(
              Localizations.localeOf(context).languageCode,
            ).add_Hm().format(DateTime.now().toLocal());

            return SelectableText(
              '1 ${token1.symbol} = \$${fiatValueToken1.formatNumber(precision: 2)} ($timestamp)',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (err, stack) => const SizedBox.shrink(),
        ),
        const SizedBox(width: 8),
        valueToken2.when(
          data: (fiatValueToken2) {
            if (fiatValueToken2 == 0) {
              return const SizedBox.shrink();
            }
            final timestamp = DateFormat.yMd(
              Localizations.localeOf(context).languageCode,
            ).add_Hm().format(DateTime.now().toLocal());

            return SelectableText(
              '1 ${token2.symbol} = \$${fiatValueToken2.formatNumber(precision: 4)} ($timestamp)',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (err, stack) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}
