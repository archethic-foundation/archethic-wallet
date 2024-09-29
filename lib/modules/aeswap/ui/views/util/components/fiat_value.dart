/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/aeswap/dex_token.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiatValue {
  Future<String> display(
    WidgetRef ref,
    DexToken token,
    double amount, {
    bool withParenthesis = true,
    int precision = 2,
  }) async {
    final priceAsyncValue =
        ref.watch(DexTokensProviders.estimateTokenInFiat(token.address));

    return priceAsyncValue.when(
      data: (price) {
        if (price == 0) {
          return withParenthesis ? r'($--)' : r'$--';
        }
        final fiatValue = price * amount;
        return withParenthesis
            ? '(\$${fiatValue.formatNumber(precision: precision)})'
            : '\$${fiatValue.formatNumber(precision: precision)}';
      },
      loading: () {
        return withParenthesis ? r'($--)' : r'$--';
      },
      error: (error, stackTrace) {
        return withParenthesis ? r'($--)' : r'$--';
      },
    );
  }
}
