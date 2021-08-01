// Flutter imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/model/address.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:intl/intl.dart';

class TxListWidget {
  static Widget buildTxList(
      BuildContext context, List<Transaction> transactions) {
    return Stack(
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
                    return displayTxDetail(context, transactions[index]);
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
                      style: AppStyles.textStyleSmallW600Primary(context)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Container displayTxDetail(
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
                        style: AppStyles.textStyleSmallW700Primary(context)),
                  ],
                ),
                transaction.type != 'transfer'
                    ? const SizedBox()
                    : Text(
                        transaction.data!.ledger!.uco!.transfers![0].amount
                                .toString() +
                            ' UCO',
                        style: AppStyles.textStyleSmallW600Primary(context)),
              ],
            ),
            transaction.type != 'transfer'
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        Text(
                            'To: ' +
                                Address(transaction
                                        .data!.ledger!.uco!.transfers![0].to!)
                                    .getShortString3(),
                            style: AppStyles.textStyleTinyW100Primary(context))
                      ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              transaction.type != 'transfer' && transaction.type != 'nft'
                  ? const SizedBox()
                  : Text(
                      'Date: ' +
                          DateFormat.yMEd(
                                  Localizations.localeOf(context).languageCode)
                              .add_Hm()
                              .format(DateTime.fromMillisecondsSinceEpoch(
                                      transaction.validationStamp!.timestamp! *
                                          1000)
                                  .toLocal())
                              .toString(),
                      style: AppStyles.textStyleTinyW100Primary(context)),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              transaction.type != 'transfer' && transaction.type != 'nft'
                  ? const SizedBox()
                  : Text(
                      'Fees: ' +
                          transaction.validationStamp!.ledgerOperations!.fee
                              .toString() +
                          ' UCO',
                      style: AppStyles.textStyleTinyW100Primary(context)),
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
