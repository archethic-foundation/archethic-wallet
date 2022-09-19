/// SPDX-License-Identifier: AGPL-3.0-or-later

// ignore_for_file: must_be_immutable

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/uco_transfer_wallet.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/number_util.dart';

class UCOTransferListWidget extends StatelessWidget {
  UCOTransferListWidget({
    super.key,
    required this.listUcoTransfer,
    required this.feeEstimation,
  });

  List<UCOTransferWallet>? listUcoTransfer;
  final double? feeEstimation;

  @override
  Widget build(BuildContext context) {
    listUcoTransfer!.sort(
        (UCOTransferWallet a, UCOTransferWallet b) => a.to!.compareTo(b.to!));
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.only(left: 3.5, right: 3.5),
      child: Column(
        children: [
          SizedBox(
            height: listUcoTransfer!.length * 60,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listUcoTransfer!.length,
              itemBuilder: (BuildContext context, int index) {
                return displayUcoDetail(context, listUcoTransfer![index]);
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
                    '${feeEstimation!.toStringAsFixed(8)} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                    style: AppStyles.textStyleSize14W600Primary(context)),
              ],
            ),
          ),
          Divider(height: 4, color: StateContainer.of(context).curTheme.text),
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
                    '${(NumberUtil.formatThousands(_getTotal()))} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
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
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(AppLocalization.of(context)!.txListTo,
                style: AppStyles.textStyleSize14W600Primary(context)),
            Text(
                ucoTransfer.toContactName == null
                    ? Address(ucoTransfer.to!).getShortString()
                    : '${ucoTransfer.toContactName!}\n${Address(ucoTransfer.to!).getShortString()}',
                style: AppStyles.textStyleSize14W600Primary(context)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
            '${(NumberUtil.formatThousands(fromBigInt(ucoTransfer.amount!)))} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
            style: AppStyles.textStyleSize14W600Primary(context)),
      ],
    );
  }

  double _getTotal() {
    double totalAmount = 0.0;
    for (int i = 0; i < listUcoTransfer!.length; i++) {
      double amount = (Decimal.parse(listUcoTransfer![i].amount!.toString()) /
              Decimal.parse('100000000'))
          .toDouble();
      totalAmount = (Decimal.parse(totalAmount.toString()) +
              Decimal.parse(amount.toString()))
          .toDouble();
    }
    totalAmount = (Decimal.parse(totalAmount.toString()) +
            Decimal.parse(feeEstimation!.toString()))
        .toDouble();
    return totalAmount;
  }
}
