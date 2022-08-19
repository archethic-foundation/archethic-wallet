/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/transactions/transaction_infos_sheet.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/number_util.dart';

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
        if (StateContainer.of(context)
            .appWallet!
            .appKeychain!
            .getAccountSelected()!
            .recentTransactions!
            .isEmpty)
          Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 26),
              child: Text(
                  AppLocalization.of(context)!
                      .recentTransactionsNoTransactionYet,
                  style: AppStyles.textStyleSize14W600Primary(context)),
            ),
          ),
        getLign(context, 0),
        getLign(context, 1),
        getLign(context, 2),
        getLign(context, 3),
        getLign(context, 4),
        getLign(context, 5),
        getLign(context, 6),
        getLign(context, 7),
        getLign(context, 8),
        getLign(context, 9),
      ],
    );
  }

  static Container getLign(BuildContext context, int num) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: const EdgeInsets.only(left: 26, right: 26, top: 6),
          child: (StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .recentTransactions!
                          .isNotEmpty &&
                      StateContainer.of(context)
                              .appWallet!
                              .appKeychain!
                              .getAccountSelected()!
                              .recentTransactions!
                              .length >
                          num) ||
                  (StateContainer.of(context).recentTransactionsLoading ==
                          true &&
                      StateContainer.of(context)
                              .appWallet!
                              .appKeychain!
                              .getAccountSelected()!
                              .recentTransactions!
                              .length >
                          num)
              ? displayTxDetailTransfer(
                  context,
                  StateContainer.of(context)
                      .appWallet!
                      .appKeychain!
                      .getAccountSelected()!
                      .recentTransactions![num])
              : const SizedBox()),
    );
  }

  static Widget displayTxDetailTransfer(
      BuildContext context, RecentTransaction transaction) {
    return InkWell(
      onTap: () {
        sl.get<HapticUtil>().feedback(
            FeedbackType.light, StateContainer.of(context).activeVibrations);
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
                ? Colors.white.withOpacity(0.1)
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
                      transaction.typeTx == RecentTransaction.tokenCreation
                          ? StateContainer.of(context).showBalance
                              ? AutoSizeText(
                                  '${NumberUtil.formatThousands(transaction.tokenInformations!.supply!)} ${transaction.tokenInformations!.symbol}',
                                  style: AppStyles.textStyleSize12W400Primary(
                                      context))
                              : AutoSizeText('···········',
                                  style: AppStyles.textStyleSize12W600Primary60(
                                      context))
                          : StateContainer.of(context)
                                      .curPrimaryCurrency
                                      .primaryCurrency
                                      .name ==
                                  PrimaryCurrencySetting(
                                          AvailablePrimaryCurrency.native)
                                      .primaryCurrency
                                      .name
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (transaction.amount != null)
                                      if (StateContainer.of(context).showBalance ==
                                          true)
                                        if (transaction.typeTx ==
                                            RecentTransaction.transferOutput)
                                          if (transaction.tokenInformations == null)
                                            AutoSizeText(
                                                '-${NumberUtil.formatThousands(transaction.amount!)} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                                style: AppStyles.textStyleSize12W400Primary(
                                                    context))
                                          else
                                            AutoSizeText(
                                                '-${NumberUtil.formatThousands(transaction.amount!)} ${transaction.tokenInformations!.symbol!}',
                                                style: AppStyles.textStyleSize12W400Primary(
                                                    context))
                                        else if (transaction.tokenInformations ==
                                            null)
                                          AutoSizeText(
                                              '${NumberUtil.formatThousands(transaction.amount!)} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                              style: AppStyles.textStyleSize12W400Primary(
                                                  context))
                                        else
                                          AutoSizeText(
                                              '${NumberUtil.formatThousands(transaction.amount!)} ${transaction.tokenInformations!.symbol!}',
                                              style:
                                                  AppStyles.textStyleSize12W400Primary(
                                                      context))
                                      else
                                        AutoSizeText('···········',
                                            style: AppStyles.textStyleSize12W600Primary60(context)),
                                    if (transaction.tokenInformations == null &&
                                        transaction.amount != null)
                                      if (StateContainer.of(context)
                                              .showBalance ==
                                          true)
                                        Text(
                                            CurrencyUtil.convertAmountFormated(
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
                                                .textStyleSize12W400Primary(
                                                    context))
                                      else
                                        AutoSizeText('···········',
                                            style: AppStyles
                                                .textStyleSize12W600Primary60(
                                                    context)),
                                  ],
                                )
                              : (StateContainer.of(context).showBalance == true)
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        if (transaction.amount != null)
                                          transaction.typeTx ==
                                                  RecentTransaction
                                                      .transferOutput
                                              ? AutoSizeText(
                                                  '-${CurrencyUtil.convertAmountFormated(StateContainer.of(context).curCurrency.currency.name, StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.tokenPrice!.amount!, transaction.amount!)}',
                                                  style: AppStyles
                                                      .textStyleSize12W400Primary(
                                                          context))
                                              : AutoSizeText(
                                                  CurrencyUtil
                                                      .convertAmountFormated(
                                                          StateContainer.of(
                                                                  context)
                                                              .curCurrency
                                                              .currency
                                                              .name,
                                                          StateContainer.of(
                                                                  context)
                                                              .appWallet!
                                                              .appKeychain!
                                                              .getAccountSelected()!
                                                              .balance!
                                                              .tokenPrice!
                                                              .amount!,
                                                          transaction.amount!),
                                                  style: AppStyles
                                                      .textStyleSize12W400Primary(
                                                          context)),
                                        if (transaction.amount != null)
                                          transaction.typeTx ==
                                                  RecentTransaction
                                                      .transferOutput
                                              ? AutoSizeText(
                                                  '-${Decimal.parse(transaction.amount!.toString())} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                                  style: AppStyles
                                                      .textStyleSize12W400Primary(
                                                          context))
                                              : AutoSizeText(
                                                  '${Decimal.parse(transaction.amount!.toString())} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                                  style: AppStyles
                                                      .textStyleSize12W400Primary(
                                                          context)),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        AutoSizeText('···········',
                                            style: AppStyles
                                                .textStyleSize12W600Primary60(
                                                    context)),
                                        AutoSizeText('···········',
                                            style: AppStyles
                                                .textStyleSize12W600Primary60(
                                                    context))
                                      ],
                                    ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      if (transaction.typeTx == RecentTransaction.tokenCreation)
                        Row(
                          children: [
                            AutoSizeText(
                                '${AppLocalization.of(context)!.tokenCreated}: ${transaction.tokenInformations!.name}',
                                style: AppStyles.textStyleSize12W400Primary(
                                    context)),
                          ],
                        ),
                      if (transaction.typeTx ==
                              RecentTransaction.transferOutput ||
                          transaction.typeTx == RecentTransaction.tokenCreation)
                        const SizedBox()
                      else
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              if (transaction.from == null)
                                const Text('')
                              else
                                Text(
                                    AppLocalization.of(context)!.txListFrom +
                                        Address(transaction.from!)
                                            .getShortString4(),
                                    style: AppStyles.textStyleSize12W400Primary(
                                        context))
                            ]),
                      if (transaction.typeTx ==
                              RecentTransaction.transferInput ||
                          transaction.typeTx == RecentTransaction.tokenCreation)
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
                                        Address(transaction
                                                        .contactInformations ==
                                                    null
                                                ? transaction.recipient!
                                                : transaction
                                                    .contactInformations!.name!)
                                            .getShortString4(),
                                    style: AppStyles.textStyleSize12W400Primary(
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
                                    .format(DateTime.fromMillisecondsSinceEpoch(
                                            transaction.timestamp! * 1000)
                                        .toLocal())
                                    .toString(),
                                style: AppStyles.textStyleSize12W400Primary(
                                    context)),
                          ]),
                      if (transaction.typeTx != RecentTransaction.transferInput)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              if (StateContainer.of(context).showBalance == true)
                                StateContainer.of(context)
                                            .curPrimaryCurrency
                                            .primaryCurrency
                                            .name ==
                                        PrimaryCurrencySetting(
                                                AvailablePrimaryCurrency.native)
                                            .primaryCurrency
                                            .name
                                    ? Text(
                                        '${AppLocalization.of(context)!.txListFees} ${transaction.fee!} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()} (${CurrencyUtil.convertAmountFormatedWithNumberOfDigits(StateContainer.of(context).curCurrency.currency.name, StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.tokenPrice!.amount!, transaction.fee!, 8)})',
                                        style:
                                            AppStyles.textStyleSize12W400Primary(
                                                context))
                                    : Text(
                                        '${AppLocalization.of(context)!.txListFees} ${CurrencyUtil.convertAmountFormatedWithNumberOfDigits(StateContainer.of(context).curCurrency.currency.name, StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.tokenPrice!.amount!, transaction.fee!, 8)} (${transaction.fee!} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()})',
                                        style:
                                            AppStyles.textStyleSize12W400Primary(
                                                context))
                              else
                                Text('···········',
                                    style:
                                        AppStyles.textStyleSize12W600Primary60(
                                            context))
                            ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (transaction.tokenInformations == null &&
                              transaction.content != null &&
                              transaction.content != '')
                            AutoSizeText(
                                AppLocalization.of(context)!
                                    .messageInTxTransfer,
                                style: AppStyles.textStyleSize12W400Primary(
                                    context))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
