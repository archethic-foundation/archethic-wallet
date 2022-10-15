// ignore_for_file: must_be_immutable
/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/token_transfer_wallet.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/number_util.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenTransferDetail extends ConsumerWidget {
  const TokenTransferDetail({
    super.key,
    required this.tokenTransfer,
    required this.symbol,
  });

  final TokenTransferWallet tokenTransfer;
  final String? symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
