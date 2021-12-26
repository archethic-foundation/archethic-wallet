// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/address.dart';
import 'package:archethic_mobile_wallet/model/recent_transaction.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/util/hapticutil.dart';

class TxListWidget extends StatefulWidget {
  const TxListWidget();

  @override
  _TxListWidgetState createState() => _TxListWidgetState();
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
          StateContainer.of(context).wallet!.history;
      final bool isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final int nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StateContainer.of(context).wallet == null ||
            StateContainer.of(context).recentTransactionsLoading == true
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 301,
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
                          children: const <Widget>[],
                        )),
                  ),
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: StateContainer.of(context).wallet!.history.isNotEmpty
                      ? Text(
                          AppLocalization.of(context)!.recentTransactionsHeader,
                          style: AppStyles.textStyleSize14W600BackgroundDarkest(
                              context))
                      : Text(
                          AppLocalization.of(context)!
                              .recentTransactionsNoTransactionYet,
                          style:
                              AppStyles.textStyleSize14W600Primary(context))),
              Container(
                height: MediaQuery.of(context).size.height - 301,
                padding: const EdgeInsets.only(
                    top: 3.5, left: 3.5, right: 3.5, bottom: 3.5),
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 6, right: 6, top: 6, bottom: 0),
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
                      builderDelegate:
                          PagedChildBuilderDelegate<RecentTransaction>(
                              itemBuilder: (BuildContext context,
                                  RecentTransaction recentTransaction,
                                  int index) {
                        return displayTxDetailTransfer(
                            context, recentTransaction);
                      }),
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  static Container displayTxDetailTransfer(
      BuildContext context, RecentTransaction transaction) {
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
                    Text(getTypeTransactionLabel(context, transaction.typeTx!),
                        style: AppStyles.textStyleSize14W700Primary(context)),
                  ],
                ),
                if (transaction.amount == null)
                  const Text('')
                else
                  Text(transaction.amount!.toString() + ' UCO',
                      style: AppStyles.textStyleSize14W600Primary(context)),
              ],
            ),
            if (transaction.typeTx == RecentTransaction.NFT_CREATION &&
                transaction.content != null)
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(transaction.content!,
                        style: AppStyles.textStyleSize10W100Primary(context))
                  ])
            else
              const SizedBox(),
            if (transaction.typeTx == RecentTransaction.TRANSFER_OUTPUT ||
                transaction.typeTx == RecentTransaction.NFT_CREATION)
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
                              Address(transaction.from!).getShortString3(),
                          style: AppStyles.textStyleSize10W100Primary(context))
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
                              Address(transaction.recipient!).getShortString3(),
                          style: AppStyles.textStyleSize10W100Primary(context))
                  ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Text(
                  AppLocalization.of(context)!.txListDate +
                      DateFormat.yMEd(
                              Localizations.localeOf(context).languageCode)
                          .add_Hms()
                          .format(DateTime.fromMillisecondsSinceEpoch(
                                  transaction.timestamp! * 1000)
                              .toLocal())
                          .toString(),
                  style: AppStyles.textStyleSize10W100Primary(context)),
            ]),
            if (transaction.typeTx == RecentTransaction.TRANSFER_INPUT)
              const SizedBox()
            else
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        AppLocalization.of(context)!.txListFees +
                            transaction.fee.toString() +
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

  static String getTypeTransactionLabel(BuildContext context, int typeTx) {
    switch (typeTx) {
      case RecentTransaction.NFT_CREATION:
        return AppLocalization.of(context)!.txListTypeTransactionLabelNewNFT;
      case RecentTransaction.TRANSFER_INPUT:
        return AppLocalization.of(context)!.txListTypeTransactionLabelReceive;
      case RecentTransaction.TRANSFER_OUTPUT:
        return AppLocalization.of(context)!.txListTypeTransactionLabelSend;
      default:
        return '';
    }
  }
}
