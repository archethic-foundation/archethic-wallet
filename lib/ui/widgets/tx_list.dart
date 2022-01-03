// Flutter imports:
import 'package:archethic_mobile_wallet/ui/widgets/sheet_util.dart';
import 'package:archethic_mobile_wallet/ui/widgets/transaction_infos_sheet.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
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
                child: StateContainer.of(context).wallet!.history.isNotEmpty ||
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
          height: MediaQuery.of(context).size.height * 0.68,
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
        height: getHeight(transaction.typeTx!),
        width: 100,
        color: Colors.blue,
        child: Container(
          padding: const EdgeInsets.all(3.5),
          width: MediaQuery.of(context).size.width * 0.9,
          height: getHeight(transaction.typeTx!),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AutoSizeText(
                          getTypeTransactionLabel(context, transaction.typeTx!),
                          style: AppStyles.textStyleSize24W700Primary(context)),
                    ],
                  ),
                  if (transaction.amount == null)
                    const Text('')
                  else
                    AutoSizeText(transaction.amount!.toString(),
                        style: AppStyles.textStyleSize24W700Primary(context)),
                ],
              ),
              if (transaction.typeTx == RecentTransaction.NFT_CREATION &&
                  transaction.content != null)
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(transaction.content!,
                          style: AppStyles.textStyleSize12W400Primary(context))
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
                            style:
                                AppStyles.textStyleSize12W400Primary(context))
                    ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        AppLocalization.of(context)!.txListDate +
                            DateFormat.yMEd(Localizations.localeOf(context)
                                    .languageCode)
                                .add_Hms()
                                .format(DateTime.fromMillisecondsSinceEpoch(
                                        transaction.timestamp! * 1000)
                                    .toLocal())
                                .toString(),
                        style: AppStyles.textStyleSize12W400Primary(context)),
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
                          style: AppStyles.textStyleSize12W400Primary(context)),
                    ]),
              const SizedBox(
                height: 5,
              ),
              Divider(
                  height: 4,
                  color: StateContainer.of(context).curTheme.backgroundDark),
            ],
          ),
        ),
      ),
    );
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

  static double getHeight(int typeTx) {
    switch (typeTx) {
      case RecentTransaction.NFT_CREATION:
        return 105.0;
      case RecentTransaction.TRANSFER_INPUT:
        return 75.0;
      default:
        return 100.0;
    }
  }
}
