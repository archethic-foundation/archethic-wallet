// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/address.dart';
import 'package:archethic_mobile_wallet/styles.dart';

class TxListWidget {
  static Widget buildTxList(BuildContext context,
      List<Transaction> transactions, Animation<double> _opacityAnimation) {
    return StateContainer.of(context).wallet == null ||
            StateContainer.of(context).wallet.transactionChainLoading == true
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                      AppLocalization.of(context)!.recentTransactionsHeader,
                      style: AppStyles.textStyleSize14W600BackgroundDarkest(
                          context))),
              SizedBox(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 120,
                      padding: const EdgeInsets.only(
                          top: 3.5, left: 3.5, right: 3.5, bottom: 3.5),
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 6, right: 6, top: 6, bottom: 6),
                          child: Column(
                            children: [
                              displayTxDetailSearching(
                                  context, _opacityAnimation),
                              displayTxDetailSearching(
                                  context, _opacityAnimation),
                              displayTxDetailSearching(
                                  context, _opacityAnimation),
                              displayTxDetailSearching(
                                  context, _opacityAnimation),
                              displayTxDetailSearching(
                                  context, _opacityAnimation),
                              displayTxDetailSearching(
                                  context, _opacityAnimation),
                              displayTxDetailSearching(
                                  context, _opacityAnimation),
                            ],
                          )),
                    ),
                  ),
                ),
              )
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                      AppLocalization.of(context)!.recentTransactionsHeader,
                      style: AppStyles.textStyleSize14W600BackgroundDarkest(
                          context))),
              SizedBox(
                child: transactions.length == 0
                    ? Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('No transaction yet')))
                    : Container(
                        child: Container(
                          height: MediaQuery.of(context).size.height - 200,
                          padding: const EdgeInsets.only(
                              top: 3.5, left: 3.5, right: 3.5, bottom: 3.5),
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, top: 6, bottom: 6),
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
                                    return displayTxDetailNFT(
                                        context, transactions[index]);
                                  } else {
                                    return const SizedBox();
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
              )
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
            transaction.inputs![1].nftAddress == null
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        Text(
                            'Address: ' +
                                Address(transaction.inputs![1].nftAddress!)
                                    .getShortString3(),
                            style:
                                AppStyles.textStyleSize10W100Primary(context)),
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

  static Container displayTxDetailSearching(
      BuildContext context, Animation<double> _opacityAnimation) {
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
                    Opacity(
                      opacity: _opacityAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: StateContainer.of(context).curTheme.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Text(
                          'Transfer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: AppFontSizes.size14 - 3,
                              fontWeight: FontWeight.w700,
                              color: Colors.transparent),
                        ),
                      ),
                    ),
                  ],
                ),
                Opacity(
                  opacity: _opacityAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: StateContainer.of(context).curTheme.primary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Text(
                      '1234567 UCO',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: AppFontSizes.size14 - 3,
                          fontWeight: FontWeight.w600,
                          color: Colors.transparent),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Opacity(
                opacity: _opacityAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: StateContainer.of(context).curTheme.primary60,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    'To: ' +
                        Address('123456789012345678901234567890123456789012345678901234567890123456')
                            .getShortString3(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: AppFontSizes.size10 - 3,
                        fontWeight: FontWeight.w100,
                        color: Colors.transparent),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 4),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Opacity(
                opacity: _opacityAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: StateContainer.of(context).curTheme.primary60,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    'Date: Mon. 01/01/2021',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: AppFontSizes.size10 - 3,
                        fontWeight: FontWeight.w100,
                        color: Colors.transparent),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 4),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Opacity(
                opacity: _opacityAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: StateContainer.of(context).curTheme.primary60,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    'Fees: 1234567 UCO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: AppFontSizes.size10 - 3,
                        fontWeight: FontWeight.w100,
                        color: Colors.transparent),
                  ),
                ),
              ),
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
