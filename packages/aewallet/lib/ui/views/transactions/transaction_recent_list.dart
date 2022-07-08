/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:io';
import 'dart:math';

// Flutter imports:
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aewallet/ui/views/transactions/transaction_all_list.dart';
import 'package:core/model/data/recent_transaction.dart';
import 'package:core/model/primary_currency.dart';
import 'package:core/util/currency_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/address.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:aewallet/ui/views/transactions/transaction_infos_sheet.dart';

class TxListWidget extends StatefulWidget {
  const TxListWidget({super.key});
  @override
  State<TxListWidget> createState() => _TxListWidgetState();
}

class _TxListWidgetState extends State<TxListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppLocalization.of(context)!.recentTransactionsHeader,
                  style: AppStyles.textStyleSize14W600EquinoxPrimary(context)),
              if (kIsWeb || Platform.isMacOS || Platform.isWindows)
                IconButton(
                  icon: const Icon(Icons.refresh),
                  color: StateContainer.of(context).curTheme.backgroundDarkest,
                  onPressed: () async {
                    StateContainer.of(context).requestUpdate();
                  },
                ),
              InkWell(
                onTap: () async {
                  UIUtil.showWebview(
                      context,
                      '${await StateContainer.of(context).curNetwork.getLink()}/explorer/transaction/${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.lastAddress!}',
                      '');
                },
                child: buildIconDataWidget(
                    context, Icons.arrow_circle_right_outlined, 20, 20),
              )
            ],
          ),
        ),
        Container(
          height: 80 *
                  StateContainer.of(context)
                      .appWallet!
                      .appKeychain!
                      .getAccountSelected()!
                      .recentTransactions!
                      .sublist(
                          0,
                          min(
                              3,
                              StateContainer.of(context)
                                  .appWallet!
                                  .appKeychain!
                                  .getAccountSelected()!
                                  .recentTransactions!
                                  .length))
                      .length
                      .toDouble() +
              70,
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 6, right: 6, top: 6),
            child: StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .recentTransactions!
                        .isNotEmpty ||
                    StateContainer.of(context).recentTransactionsLoading == true
                ? ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .recentTransactions!
                        .sublist(
                            0,
                            min(
                                3,
                                StateContainer.of(context)
                                    .appWallet!
                                    .appKeychain!
                                    .getAccountSelected()!
                                    .recentTransactions!
                                    .length))
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return displayTxDetailTransfer(
                          context,
                          StateContainer.of(context)
                              .appWallet!
                              .appKeychain!
                              .getAccountSelected()!
                              .recentTransactions!
                              .sublist(
                                  0,
                                  min(
                                      3,
                                      StateContainer.of(context)
                                          .appWallet!
                                          .appKeychain!
                                          .getAccountSelected()!
                                          .recentTransactions!
                                          .length))[index],
                          index);
                    },
                  )
                : Container(
                    height: 30,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalization.of(context)!
                            .recentTransactionsNoTransactionYet,
                        style: AppStyles.textStyleSize14W600Primary(context),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  static Widget displayTxDetailTransfer(
      BuildContext context, RecentTransaction transaction, int index) {
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
                    : transaction.typeTx! == RecentTransaction.tokenCreation
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
                                              '-${transaction.amount!} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                              style: AppStyles
                                                  .textStyleSize20W700EquinoxRed(
                                                      context))
                                          : AutoSizeText(
                                              '${transaction.amount!} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                              style: AppStyles
                                                  .textStyleSize20W700EquinoxGreen(
                                                      context)),
                                    if (transaction.amount == null)
                                      const Text('')
                                    else
                                      Text(
                                          '${CurrencyUtil.convertAmountFormated(StateContainer.of(context).curCurrency.currency.name, StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.tokenPrice!.amount!, transaction.amount!)} ',
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
                                      transaction
                                                  .typeTx ==
                                              RecentTransaction.transferOutput
                                          ? AutoSizeText(
                                              '-${CurrencyUtil.convertAmountFormated(StateContainer.of(context).curCurrency.currency.name, StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.tokenPrice!.amount!, transaction.amount!)}',
                                              style: AppStyles
                                                  .textStyleSize20W700EquinoxRed(
                                                      context))
                                          : AutoSizeText(
                                              CurrencyUtil
                                                  .convertAmountFormated(
                                                      StateContainer.of(context)
                                                          .curCurrency
                                                          .currency
                                                          .name,
                                                      StateContainer.of(context)
                                                          .appWallet!
                                                          .appKeychain!
                                                          .getAccountSelected()!
                                                          .balance!
                                                          .tokenPrice!
                                                          .amount!,
                                                      transaction.amount!),
                                              style: AppStyles
                                                  .textStyleSize20W700EquinoxGreen(
                                                      context)),
                                    if (transaction.amount == null)
                                      const Text('')
                                    else
                                      transaction.typeTx ==
                                              RecentTransaction.transferOutput
                                          ? AutoSizeText(
                                              '-${transaction.amount!} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                              style: AppStyles
                                                  .textStyleSize12W600Primary(
                                                      context))
                                          : AutoSizeText(
                                              '${transaction.amount!} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
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
                              RecentTransaction.tokenCreation)
                            Row(
                              children: <Widget>[
                                AutoSizeText(
                                    AppLocalization.of(context)!
                                        .txListTypeTransactionLabelNewToken,
                                    style: AppStyles
                                        .textStyleSize14W600EquinoxPrimary(
                                            context)),
                              ],
                            )
                          else
                            const SizedBox(),
                          if (transaction.typeTx ==
                                  RecentTransaction.tokenCreation &&
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
                                  RecentTransaction.tokenCreation)
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
                                  RecentTransaction.tokenCreation)
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
                                  StateContainer.of(context)
                                              .curPrimaryCurrency
                                              .primaryCurrency
                                              .name ==
                                          PrimaryCurrencySetting(
                                                  AvailablePrimaryCurrency
                                                      .NATIVE)
                                              .primaryCurrency
                                              .name
                                      ? Text(
                                          '${AppLocalization.of(context)!.txListFees} ${transaction.fee!} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()} (${CurrencyUtil.convertAmountFormatedWithNumberOfDigits(StateContainer.of(context).curCurrency.currency.name, StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.tokenPrice!.amount!, transaction.fee!, 8)})',
                                          style: AppStyles
                                              .textStyleSize12W400Primary(
                                                  context))
                                      : Text(
                                          '${AppLocalization.of(context)!.txListFees} ${CurrencyUtil.convertAmountFormatedWithNumberOfDigits(StateContainer.of(context).curCurrency.currency.name, StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.tokenPrice!.amount!, transaction.fee!, 8)} (${transaction.fee!} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()})',
                                          style: AppStyles
                                              .textStyleSize12W400Primary(
                                                  context)),
                                ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              /*if (index == 2)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: GestureDetector(
                    onTap: () {
                      sl.get<HapticUtil>().feedback(FeedbackType.light,
                          StateContainer.of(context).activeVibrations);
                      Sheets.showAppHeightNineSheet(
                          context: context, widget: const TxAllListWidget());
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(19.0, 10.0, 19.0, 10.0),
                      decoration: ShapeDecoration(
                          gradient:
                              StateContainer.of(context).curTheme.gradient!,
                          shape: const StadiumBorder()),
                      child: Text(AppLocalization.of(context)!.seeAll,
                          style: AppStyles
                              .textStyleSize14W600EquinoxMiddleButtonLabel(
                                  context)),
                    ),
                  ),
                ),*/
            ],
          ),
        );
      },
    );
  }
}
