/// SPDX-License-Identifier: AGPL-3.0-or-later

// ignore_for_file: must_be_immutable

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:core/localization.dart';
import 'package:core/model/address.dart';
import 'package:decimal/decimal.dart';

// Project imports:
import 'package:aewallet/model/uco_transfer_wallet.dart';

class TokensTransferListWidget extends StatefulWidget {
  TokensTransferListWidget({
    super.key,
    required this.listUcoTransfer,
    required this.feeEstimation,
    this.onGet,
    this.onDelete,
  });

  List<UCOTransferWallet>? listUcoTransfer;
  final Function(UCOTransferWallet)? onGet;
  final Function()? onDelete;
  final double? feeEstimation;

  @override
  State<TokensTransferListWidget> createState() =>
      _TokensTransferListWidgetState();
}

class _TokensTransferListWidgetState extends State<TokensTransferListWidget> {
  @override
  Widget build(BuildContext context) {
    widget.listUcoTransfer!.sort(
        (UCOTransferWallet a, UCOTransferWallet b) => a.to!.compareTo(b.to!));
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.only(left: 3.5, right: 3.5),
      child: Column(
        children: [
          SizedBox(
            height: widget.listUcoTransfer!.length * 50,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.listUcoTransfer!.length,
              itemBuilder: (BuildContext context, int index) {
                return displayUcoDetail(
                    context, widget.listUcoTransfer![index]);
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
                    Text('+ ' + AppLocalization.of(context)!.estimatedFees,
                        style: AppStyles.textStyleSize14W600Primary(context)),
                  ],
                ),
                Text(
                    widget.feeEstimation!.toStringAsFixed(8) +
                        ' ' +
                        StateContainer.of(context)
                            .curNetwork
                            .getNetworkCryptoCurrencyLabel(),
                    style: AppStyles.textStyleSize14W600Primary(context)),
              ],
            ),
          ),
          Divider(
              height: 4, color: StateContainer.of(context).curTheme.primary),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(AppLocalization.of(context)!.total,
                        style: AppStyles.textStyleSize14W600Primary(context)),
                  ],
                ),
                Text(
                    (_getTotal()).toStringAsFixed(8) +
                        ' ' +
                        StateContainer.of(context)
                            .curNetwork
                            .getNetworkCryptoCurrencyLabel(),
                    style: AppStyles.textStyleSize14W600Primary(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget displayUcoDetail(BuildContext context, UCOTransferWallet ucoTransfer) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                    ucoTransfer.toContactName == null
                        ? Address(ucoTransfer.to!).getShortString()
                        : ucoTransfer.toContactName! +
                            '\n' +
                            Address(ucoTransfer.to!).getShortString(),
                    style: AppStyles.textStyleSize14W600Primary(context)),
              ],
            ),
            Text(
                (ucoTransfer.amount! / BigInt.from(100000000))
                        .toStringAsFixed(8) +
                    ' ' +
                    StateContainer.of(context)
                        .curNetwork
                        .getNetworkCryptoCurrencyLabel(),
                style: AppStyles.textStyleSize14W600Primary(context)),
          ],
        ),
      ],
    );
  }

  double _getTotal() {
    double _totalAmount = 0.0;
    for (int i = 0; i < widget.listUcoTransfer!.length; i++) {
      double _amount =
          (Decimal.parse(widget.listUcoTransfer![i].amount!.toString()) /
                  Decimal.parse('100000000'))
              .toDouble();
      _totalAmount = (Decimal.parse(_totalAmount.toString()) +
              Decimal.parse(_amount.toString()))
          .toDouble();
    }
    _totalAmount = (Decimal.parse(_totalAmount.toString()) +
            Decimal.parse(widget.feeEstimation!.toString()))
        .toDouble();
    return _totalAmount;
  }
}
