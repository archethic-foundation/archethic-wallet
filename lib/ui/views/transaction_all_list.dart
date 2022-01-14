// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/model/address.dart';
import 'package:archethic_wallet/model/recent_transaction.dart';
import 'package:archethic_wallet/ui/util/styles.dart';
import 'package:archethic_wallet/ui/views/sheets/transaction_infos_sheet.dart';
import 'package:archethic_wallet/ui/widgets/components/sheet_util.dart';

class TxAllListWidget extends StatefulWidget {
  const TxAllListWidget() : super();

  @override
  _TxAllListWidgetState createState() => _TxAllListWidgetState();
}

class _TxAllListWidgetState extends State<TxAllListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // A row for the address text and close button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Empty SizedBox
            const SizedBox(
              width: 60,
              height: 40,
            ),
            Column(
              children: <Widget>[
                // Sheet handle
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 5,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: StateContainer.of(context).curTheme.primary10,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ],
            ),
            //Empty SizedBox
            const SizedBox(
              width: 60,
              height: 40,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  top: 0.0, bottom: 20.0, left: 10.0, right: 10.0),
              child: AutoSizeText(
                AppLocalization.of(context)!.transactionsAllListHeader,
                style: AppStyles.textStyleSize24W700Primary(context),
              ),
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: Stack(children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: SafeArea(
                    minimum: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.035,
                      top: 0,
                    ),
                    child: Column(
                      children: <Widget>[
                        // list
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              //  list
                              ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 15.0, bottom: 15),
                                itemCount: StateContainer.of(context)
                                    .wallet!
                                    .history
                                    .length,
                                itemBuilder: (BuildContext context, int index) {
                                  // Build
                                  return displayTxDetailTransfer(
                                      context,
                                      StateContainer.of(context)
                                          .wallet!
                                          .history[index]);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ]),
          ),
        ),
      ],
    );
  }

  static Widget displayTxDetailTransfer(
      BuildContext context, RecentTransaction transaction) {
    return InkWell(
      onTap: () {
        Sheets.showAppHeightNineSheet(
            context: context,
            widget: TransactionInfosSheet(transaction.address!));
      },
      child: Ink(
        width: 100,
        color: Colors.blue,
        child: Container(
          padding: const EdgeInsets.all(3.5),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Stack(
            children: <Widget>[
              Container(
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <
                    Widget>[
                  if (transaction.amount == null)
                    const Text('')
                  else
                    transaction.typeTx == RecentTransaction.TRANSFER_OUTPUT
                        ? AutoSizeText('-' + transaction.amount!.toString(),
                            style:
                                AppStyles.textStyleSize20W700Primary(context))
                        : AutoSizeText(transaction.amount!.toString(),
                            style: AppStyles.textStyleSize20W700Green(context)),
                ]),
              ),
              Column(
                children: <Widget>[
                  if (transaction.typeTx! == RecentTransaction.NFT_CREATION)
                    Row(
                      children: <Widget>[
                        AutoSizeText(
                            AppLocalization.of(context)!
                                .txListTypeTransactionLabelNewNFT,
                            style:
                                AppStyles.textStyleSize20W700Primary(context)),
                      ],
                    )
                  else
                    const SizedBox(),
                  if (transaction.typeTx == RecentTransaction.NFT_CREATION &&
                      transaction.content != null)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(transaction.content!,
                              style:
                                  AppStyles.textStyleSize12W400Primary(context))
                        ])
                  else
                    const SizedBox(),
                  if (transaction.typeTx == RecentTransaction.TRANSFER_OUTPUT ||
                      transaction.typeTx == RecentTransaction.NFT_CREATION)
                    const SizedBox()
                  else
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: <
                        Widget>[
                      if (transaction.from == null)
                        const Text('')
                      else
                        Text(
                            AppLocalization.of(context)!.txListFrom +
                                Address(transaction.from!).getShortString3(),
                            style:
                                AppStyles.textStyleSize12W400Primary(context))
                    ]),
                  if (transaction.typeTx == RecentTransaction.TRANSFER_INPUT ||
                      transaction.typeTx == RecentTransaction.NFT_CREATION)
                    const SizedBox()
                  else
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          if (transaction.recipient == null)
                            const Text('')
                          else
                            Text(
                                AppLocalization.of(context)!.txListTo +
                                    Address(transaction.recipient!)
                                        .getShortString3(),
                                style: AppStyles.textStyleSize12W400Primary(
                                    context))
                        ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            getTypeTransactionLabelForDate(
                                    context, transaction.typeTx!) +
                                DateFormat.yMMMEd(
                                        Localizations.localeOf(context)
                                            .languageCode)
                                    .add_Hms()
                                    .format(DateTime.fromMillisecondsSinceEpoch(
                                            transaction.timestamp! * 1000)
                                        .toLocal())
                                    .toString(),
                            style:
                                AppStyles.textStyleSize12W400Primary(context)),
                      ]),
                  if (transaction.typeTx == RecentTransaction.TRANSFER_INPUT)
                    const SizedBox()
                  else
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: <
                        Widget>[
                      Text(
                          AppLocalization.of(context)!.txListFees +
                              transaction.fee.toString() +
                              ' UCO',
                          style: AppStyles.textStyleSize12W400Primary(context)),
                    ]),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(
                      height: 4,
                      color: StateContainer.of(context)
                          .curTheme
                          .backgroundDarkest),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String getTypeTransactionLabelForDate(
      BuildContext context, int typeTx) {
    switch (typeTx) {
      case RecentTransaction.TRANSFER_INPUT:
        return AppLocalization.of(context)!.txListTypeTransactionLabelReceive;
      case RecentTransaction.TRANSFER_OUTPUT:
        return AppLocalization.of(context)!.txListTypeTransactionLabelSend;
      default:
        return AppLocalization.of(context)!.txListDate;
    }
  }
}
