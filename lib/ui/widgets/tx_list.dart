// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/model/address.dart';
import 'package:archethic_wallet/model/recent_transaction.dart';
import 'package:archethic_wallet/service_locator.dart';
import 'package:archethic_wallet/styles.dart';
import 'package:archethic_wallet/ui/widgets/sheet_util.dart';
import 'package:archethic_wallet/ui/widgets/transaction_infos_sheet.dart';
import 'package:archethic_wallet/util/hapticutil.dart';

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
          children: [
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
                        style: AppStyles.textStyleSize14W600BackgroundDarkest(
                            context))
                    : Text(
                        AppLocalization.of(context)!
                            .recentTransactionsNoTransactionYet,
                        style: AppStyles.textStyleSize14W600Primary(context))),
            kIsWeb
                ? IconButton(
                    icon: Icon(Icons.refresh),
                    color:
                        StateContainer.of(context).curTheme.backgroundDarkest,
                    onPressed: () async {
                      StateContainer.of(context).requestUpdate(
                          account: StateContainer.of(context).selectedAccount);
                      _pagingController.refresh();
                    },
                  )
                : const SizedBox(),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.45,
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 0),
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
                builderDelegate: PagedChildBuilderDelegate<RecentTransaction>(
                    animateTransitions: true,
                    transitionDuration: const Duration(milliseconds: 600),
                    noItemsFoundIndicatorBuilder: (_) => const SizedBox(),
                    itemBuilder: (BuildContext context,
                        RecentTransaction recentTransaction, int index) {
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
                children: [
                  transaction.typeTx! == RecentTransaction.NFT_CREATION
                      ? Row(
                          children: <Widget>[
                            AutoSizeText(
                                AppLocalization.of(context)!
                                    .txListTypeTransactionLabelNewNFT,
                                style: AppStyles.textStyleSize20W700Primary(
                                    context)),
                          ],
                        )
                      : const SizedBox(),
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
                      color:
                          StateContainer.of(context).curTheme.backgroundDark),
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
