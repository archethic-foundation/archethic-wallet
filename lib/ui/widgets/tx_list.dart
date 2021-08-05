// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/model/address.dart';
import 'package:archethic_mobile_wallet/styles.dart';

class TxListWidget {
  static Widget buildTxList(
      BuildContext context, List<Transaction> transactions) {
        return StateContainer.of(context).wallet.transactionChainLoading == true ? Text("toto") :
     Stack(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 400,
              padding: const EdgeInsets.only(
                  top: 23.5, left: 3.5, right: 3.5, bottom: 3.5),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.background,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: StateContainer.of(context).curTheme.backgroundDark!,
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: const Offset(5.0, 5.0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 6, right: 6, top: 30, bottom: 6),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: transactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (transactions[index].type == 'transfer') {
                      return displayTxDetailTransfer(
                          context, transactions[index]);
                    } else {
                      if (transactions[index].type == 'nft') {
                        return displayTxDetailNFT(context, transactions[index]);
                      } else {
                        return const SizedBox();
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              padding: const EdgeInsets.all(3.5),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 40,
              decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.backgroundDark,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color:
                        StateContainer.of(context).curTheme.backgroundDarkest!,
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: const Offset(5.0, 5.0),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Recent transactions',
                      style: AppStyles.textStyleSize14W600Primary(context)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Container displayTxDetailTransfer(
      BuildContext context, Transaction transaction) {
    return Container(
        padding: const EdgeInsets.all(3.5),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(transaction.type!,
                        style: AppStyles.textStyleSize14W700Primary(context)),
                  ],
                ),
                Text(
                    transaction.data!.ledger!.uco!.transfers![0].amount
                            .toString() +
                        ' UCO',
                    style: AppStyles.textStyleSize14W600Primary(context)),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Text(
                  'To: ' +
                      Address(transaction.data!.ledger!.uco!.transfers![0].to!)
                          .getShortString3(),
                  style: AppStyles.textStyleSize10W100Primary(context))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Text(
                  'Date: ' +
                      DateFormat.yMEd(
                              Localizations.localeOf(context).languageCode)
                          .add_Hm()
                          .format(DateTime.fromMillisecondsSinceEpoch(
                                  transaction.validationStamp!.timestamp! *
                                      1000)
                              .toLocal())
                          .toString(),
                  style: AppStyles.textStyleSize10W100Primary(context)),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Text(
                  'Fees: ' +
                      transaction.validationStamp!.ledgerOperations!.fee
                          .toString() +
                      ' UCO',
                  style: AppStyles.textStyleSize10W100Primary(context)),
            ]),
            const SizedBox(height: 6),
            Divider(
                height: 4,
                color: StateContainer.of(context).curTheme.backgroundDark),
            const SizedBox(height: 6),
          ],
        ));
  }

  static Container displayTxDetailNFT(
      BuildContext context, Transaction transaction) {
    return Container(
        padding: const EdgeInsets.all(3.5),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(transaction.type!,
                        style: AppStyles.textStyleSize14W700Primary(context)),
                  ],
                ),
                Text(
                    transaction.inputs![1].amount.toString() +
                        ' ' +
                        transaction.data!.contentDisplay!.substring(transaction
                                .data!.contentDisplay!
                                .indexOf('name: ') +
                            'name: '.length),
                    style: AppStyles.textStyleSize14W600Primary(context)),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Text(
                  'Address: ' +
                      Address(transaction.inputs![1].nftAddress!)
                          .getShortString3(),
                  style: AppStyles.textStyleSize10W100Primary(context)),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Text(
                  'Date: ' +
                      DateFormat.yMEd(
                              Localizations.localeOf(context).languageCode)
                          .add_Hm()
                          .format(DateTime.fromMillisecondsSinceEpoch(
                                  transaction.validationStamp!.timestamp! *
                                      1000)
                              .toLocal())
                          .toString(),
                  style: AppStyles.textStyleSize10W100Primary(context)),
            ]),
            const SizedBox(height: 6),
            Divider(
                height: 4,
                color: StateContainer.of(context).curTheme.backgroundDark),
            const SizedBox(height: 6),
          ],
        ));
  }
}
