/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/token_transfer_wallet.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/tokens_fungibles/layout/components/token_transfer_detail.dart';
// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenTransferListWidget extends ConsumerWidget {
  const TokenTransferListWidget({
    super.key,
    required this.listTokenTransfer,
    required this.feeEstimation,
    required this.symbol,
  });

  final List<TokenTransferWallet>? listTokenTransfer;
  final double? feeEstimation;
  final String? symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    listTokenTransfer!.sort(
      (TokenTransferWallet a, TokenTransferWallet b) => a.to!.compareTo(b.to!),
    );
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.only(left: 3.5, right: 3.5),
      child: Column(
        children: [
          SizedBox(
            height: listTokenTransfer!.length * 90,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listTokenTransfer!.length,
              itemBuilder: (BuildContext context, int index) {
                return TokenTransferDetail(
                  tokenTransfer: listTokenTransfer![index],
                  symbol: symbol,
                );
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '+ ${localizations.estimatedFees}',
                      style: theme.textStyleSize14W600Primary,
                    ),
                  ],
                ),
                Text(
                  '${feeEstimation!.toStringAsFixed(8)} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                  style: theme.textStyleSize14W600Primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
