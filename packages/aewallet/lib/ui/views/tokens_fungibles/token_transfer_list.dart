// ignore_for_file: must_be_immutable
/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:core/localization.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:core/model/address.dart';

// Project imports:
import 'package:aewallet/model/token_transfer_wallet.dart';

class TokenTransferListWidget extends StatefulWidget {
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
  State<TokenTransferListWidget> createState() =>
      _TokenTransferListWidgetState();
}

class _TokenTransferListWidgetState extends State<TokenTransferListWidget> {
  @override
  Widget build(BuildContext context) {
    widget.listTokenTransfer!.sort(
        (TokenTransferWallet a, TokenTransferWallet b) =>
            a.to!.compareTo(b.to!));
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.only(left: 3.5, right: 3.5),
      child: Column(
        children: [
          SizedBox(
            height: widget.listTokenTransfer!.length * 50,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.listTokenTransfer!.length,
              itemBuilder: (BuildContext context, int index) {
                return displayTokenDetail(
                    context, widget.listTokenTransfer![index]);
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
                    Text('+ ${AppLocalization.of(context)!.estimatedFees}',
                        style: AppStyles.textStyleSize14W600Primary(context)),
                  ],
                ),
                Text(
                    '${widget.feeEstimation!.toStringAsFixed(8)} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                    style: AppStyles.textStyleSize14W600Primary(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget displayTokenDetail(
      BuildContext context, TokenTransferWallet tokenTransfer) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                    tokenTransfer.toContactName == null
                        ? Address(tokenTransfer.to!).getShortString()
                        : '${tokenTransfer.toContactName!}\n${Address(tokenTransfer.to!).getShortString()}',
                    style: AppStyles.textStyleSize14W600Primary(context)),
              ],
            ),
            Text(
                '${(tokenTransfer.amount! / BigInt.from(100000000)).toStringAsFixed(0)} ${widget.symbol}',
                style: AppStyles.textStyleSize14W600Primary(context)),
          ],
        ),
      ],
    );
  }
}
