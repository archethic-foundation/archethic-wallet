/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:core/model/balance_wallet.dart';
import 'package:core/model/primary_currency.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/address.dart';
import 'package:core/model/recent_transaction.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:aewallet/ui/views/transactions/transaction_infos_sheet.dart';

class TxAllListWidget extends StatefulWidget {
  const TxAllListWidget({super.key});

  @override
  State<TxAllListWidget> createState() => _TxAllListWidgetState();
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
                    color: StateContainer.of(context).curTheme.text10,
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
              padding:
                  const EdgeInsets.only(bottom: 20.0, left: 10.0, right: 10.0),
              child: AutoSizeText(
                AppLocalization.of(context)!.transactionsAllListHeader,
                style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
              ),
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: Stack(children: <Widget>[
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: SafeArea(
                    minimum: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.035,
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
    BalanceWallet balance = BalanceWallet(
        transaction.amount, StateContainer.of(context).curCurrency);
    balance.localCurrencyPrice =
        StateContainer.of(context).wallet!.accountBalance.localCurrencyPrice;
    return FutureBuilder<String>(
      future: transaction.recipientDisplay,
      builder: (BuildContext context, AsyncSnapshot<String> recipientDisplay) {
        return InkWell(
          onTap: () {
            sl.get<HapticUtil>().feedback(FeedbackType.light,
                StateContainer.of(context).activeVibrations);
            Sheets.showAppHeightNineSheet(
                context: context,
                widget: TransactionInfosSheet(transaction.address!));
          },
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 0,
                color: transaction.typeTx == RecentTransaction.transferOutput
                    ? Colors.redAccent[100]!.withOpacity(0.1)
                    : transaction.typeTx! == RecentTransaction.nftCreation
                        ? Colors.blueAccent[100]!.withOpacity(0.1)
                        : Colors.greenAccent[100]!.withOpacity(0.1),
                child: Container(
                  padding: const EdgeInsets.all(9.5),
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          StateContainer.of(context)
                                      .curPrimaryCurrency
                                      .primaryCurrency
                                      .name ==
                                  PrimaryCurrencySetting(
                                          AvailablePrimaryCurrency.NATIVE)
                                      .primaryCurrency
                                      .name
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (transaction.amount == null)
                                      const Text('')
                                    else
                                      transaction.typeTx ==
                                              RecentTransaction.transferOutput
                                          ? AutoSizeText(
                                              '-${transaction.amount!}',
                                              style: AppStyles
                                                  .textStyleSize20W700EquinoxRed(
                                                      context))
                                          : AutoSizeText(
                                              transaction.amount!.toString(),
                                              style: AppStyles
                                                  .textStyleSize20W700EquinoxGreen(
                                                      context)),
                                    if (transaction.amount == null)
                                      const Text('')
                                    else
                                      Text(
                                          balance
                                              .getConvertedAccountBalanceDisplay(),
                                          style: AppStyles
                                              .textStyleSize12W600Primary(
                                                  context)),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (transaction.amount == null)
                                      const Text('')
                                    else
                                      transaction.typeTx ==
                                              RecentTransaction.transferOutput
                                          ? AutoSizeText(
                                              '-${balance.getConvertedAccountBalanceDisplay()}',
                                              style: AppStyles
                                                  .textStyleSize20W700EquinoxRed(
                                                      context))
                                          : AutoSizeText(
                                              balance
                                                  .getConvertedAccountBalanceDisplay(),
                                              style: AppStyles
                                                  .textStyleSize20W700EquinoxGreen(
                                                      context)),
                                    if (transaction.amount == null)
                                      const Text('')
                                    else
                                      transaction.typeTx ==
                                              RecentTransaction.transferOutput
                                          ? AutoSizeText(
                                              '-${transaction.amount!} ' +
                                                  StateContainer.of(context)
                                                      .curNetwork
                                                      .getNetworkCryptoCurrencyLabel(),
                                              style: AppStyles
                                                  .textStyleSize12W600Primary(
                                                      context))
                                          : AutoSizeText(
                                              transaction.amount!.toString() +
                                                  ' ' +
                                                  StateContainer.of(context)
                                                      .curNetwork
                                                      .getNetworkCryptoCurrencyLabel(),
                                              style: AppStyles
                                                  .textStyleSize12W600Primary(
                                                      context)),
                                  ],
                                )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          if (transaction.typeTx! ==
                              RecentTransaction.nftCreation)
                            Row(
                              children: <Widget>[
                                AutoSizeText(
                                    AppLocalization.of(context)!
                                        .txListTypeTransactionLabelNewNFT,
                                    style: AppStyles
                                        .textStyleSize14W600EquinoxPrimary(
                                            context)),
                              ],
                            )
                          else
                            const SizedBox(),
                          if (transaction.typeTx ==
                                  RecentTransaction.nftCreation &&
                              transaction.content != null)
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(transaction.content!,
                                      style:
                                          AppStyles.textStyleSize12W400Primary(
                                              context))
                                ])
                          else
                            const SizedBox(),
                          if (transaction.typeTx ==
                                  RecentTransaction.transferOutput ||
                              transaction.typeTx ==
                                  RecentTransaction.nftCreation)
                            const SizedBox()
                          else
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  if (transaction.from == null)
                                    const Text('')
                                  else
                                    Text(
                                        AppLocalization.of(context)!
                                                .txListFrom +
                                            Address(transaction.from!)
                                                .getShortString4(),
                                        style: AppStyles
                                            .textStyleSize12W400Primary(
                                                context))
                                ]),
                          if (transaction.typeTx ==
                                  RecentTransaction.transferInput ||
                              transaction.typeTx ==
                                  RecentTransaction.nftCreation)
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
                                            Address(recipientDisplay.data ==
                                                        null
                                                    ? transaction.recipient!
                                                    : recipientDisplay.data!)
                                                .getShortString4(),
                                        style: AppStyles
                                            .textStyleSize12W400Primary(
                                                context))
                                ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    DateFormat.yMMMEd(
                                            Localizations.localeOf(context)
                                                .languageCode)
                                        .add_Hms()
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                    transaction.timestamp! *
                                                        1000)
                                                .toLocal())
                                        .toString(),
                                    style: AppStyles.textStyleSize12W400Primary(
                                        context)),
                              ]),
                          if (transaction.typeTx ==
                              RecentTransaction.transferInput)
                            const SizedBox()
                          else
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      '${AppLocalization.of(context)!.txListFees}${transaction.fee} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                      style:
                                          AppStyles.textStyleSize12W400Primary(
                                              context)),
                                ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
