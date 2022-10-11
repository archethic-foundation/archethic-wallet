// ignore_for_file: must_be_immutable
/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/token_transfer_wallet.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/number_util.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenTransferListWidget extends ConsumerWidget {
  TokenTransferListWidget({
    super.key,
    required this.listTokenTransfer,
    required this.feeEstimation,
    required this.symbol,
  });

  List<TokenTransferWallet>? listTokenTransfer;
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
                return displayTokenDetail(
                  context,
                  ref,
                  listTokenTransfer![index],
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

  // TODO(Chralu): extract to a [Widget] subclass
  Widget displayTokenDetail(
    BuildContext context,
    WidgetRef ref,
    TokenTransferWallet tokenTransfer,
  ) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              AppLocalization.of(context)!.txListTo,
              style: theme.textStyleSize14W600Primary,
            ),
            Text(
              tokenTransfer.toContactName == null
                  ? Address(tokenTransfer.to!).getShortString()
                  : '${tokenTransfer.toContactName!}\n${Address(tokenTransfer.to!).getShortString()}',
              style: theme.textStyleSize14W600Primary,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          '${NumberUtil.formatThousands(fromBigInt(tokenTransfer.amount))} $symbol',
          style: theme.textStyleSize14W600Primary,
        ),
      ],
    );
  }
}
