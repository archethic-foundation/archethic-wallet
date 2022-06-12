/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:io';
import 'dart:math';

// Flutter imports:
import 'package:aeuniverse/ui/widgets/components/gradient_shadow_box_decoration.dart';
import 'package:core/model/balance_wallet.dart';
import 'package:core/model/primary_currency.dart';
import 'package:flutter/foundation.dart';
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
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:aewallet/ui/views/transactions/transaction_all_list.dart';
import 'package:aewallet/ui/views/transactions/transaction_infos_sheet.dart';

class TxListWidget extends StatefulWidget {
  const TxListWidget({super.key});
  @override
  State<TxListWidget> createState() => _TxListWidgetState();
}

class _TxListWidgetState extends State<TxListWidget> {
  static const int _pageSize = 20;
  final PagingController<int, RecentTransaction> _pagingController =
      PagingController<int, RecentTransaction>(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((int pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<RecentTransaction> newItems =
          StateContainer.of(context).wallet!.recentHistory;
      final bool isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final int nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {}
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pagingController.refresh();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: StateContainer.of(context)
                            .wallet!
                            .recentHistory
                            .isNotEmpty ||
                        StateContainer.of(context).recentTransactionsLoading ==
                            true
                    ? Text(
                        AppLocalization.of(context)!.recentTransactionsHeader,
                        style: AppStyles.textStyleSize14W600EquinoxPrimary(
                            context))
                    : Text(
                        AppLocalization.of(context)!
                            .recentTransactionsNoTransactionYet,
                        style: AppStyles.textStyleSize14W600Primary(context))),
            if (kIsWeb || Platform.isMacOS || Platform.isWindows)
              IconButton(
                icon: const Icon(Icons.refresh),
                color: StateContainer.of(context).curTheme.backgroundDarkest,
                onPressed: () async {
                  StateContainer.of(context).requestUpdate(
                      account: StateContainer.of(context).selectedAccount);
                  _pagingController.refresh();
                },
              )
            else
              const SizedBox(),
          ],
        ),
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 6, right: 6, top: 6),
                child: RefreshIndicator(
                  backgroundColor:
                      StateContainer.of(context).curTheme.backgroundDark,
                  onRefresh: () => Future<void>.sync(() {
                    sl.get<HapticUtil>().feedback(FeedbackType.light);
                    StateContainer.of(context).requestUpdate(
                        account: StateContainer.of(context).selectedAccount);
                    _pagingController.refresh();
                  }),
                  child: PagedListView<int, RecentTransaction>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<
                            RecentTransaction>(
                        animateTransitions: true,
                        transitionDuration: const Duration(milliseconds: 600),
                        noItemsFoundIndicatorBuilder: (_) => const SizedBox(),
                        itemBuilder: (BuildContext context,
                            RecentTransaction recentTransaction, int index) {
                          return displayTxDetailTransfer(
                              context, recentTransaction, index);
                        }),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  static Widget displayTxDetailTransfer(
      BuildContext context, RecentTransaction transaction, int index) {
    BalanceWallet balance = BalanceWallet(
        transaction.amount, StateContainer.of(context).curCurrency);
    balance.localCurrencyPrice =
        StateContainer.of(context).wallet!.accountBalance.localCurrencyPrice;
    return FutureBuilder<String>(
      future: transaction.recipientDisplay,
      builder: (BuildContext context, AsyncSnapshot<String> recipientDisplay) {
        return InkWell(
          onTap: () {
            sl.get<HapticUtil>().feedback(FeedbackType.light);
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
              if (index == 2)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: GestureDetector(
                    onTap: () {
                      sl.get<HapticUtil>().feedback(FeedbackType.light);
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
                          style: AppStyles.textStyleSize14W600EquinoxPrimary(
                              context)),
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
