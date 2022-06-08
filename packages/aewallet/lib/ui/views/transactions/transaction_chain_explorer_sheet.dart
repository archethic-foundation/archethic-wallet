/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TransactionChainExplorerSheet extends StatefulWidget {
  const TransactionChainExplorerSheet({super.key});

  @override
  State<TransactionChainExplorerSheet> createState() =>
      _TransactionChainExplorerSheetState();
}

class _TransactionChainExplorerSheetState
    extends State<TransactionChainExplorerSheet> {
  int transactionsLength = 0;

  Future<List<Transaction>> _getTransactionChain() async {
    List<Transaction>? transactions;
    transactions = await sl.get<ApiService>().getTransactionChain(
        StateContainer.of(context).wallet!.address,
        pagingAddress: '');
    transactionsLength = transactions.length;
    return transactions;
  }

  @override
  void initState() {
    _getTransactionChain();
    super.initState();
  }

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
            if (kIsWeb || Platform.isMacOS || Platform.isWindows)
              Stack(
                children: <Widget>[
                  const SizedBox(
                    width: 60,
                    height: 40,
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: <Widget>[
                              buildIconDataWidget(
                                  context, Icons.close_outlined, 30, 30),
                            ],
                          ))),
                ],
              )
            else
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: AutoSizeText(
                  AppLocalization.of(context)!.transactionChainExplorerHeader,
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyleSize24W700Primary(context),
                ),
              ),
            )
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
                      top: 20,
                    ),
                    child: Column(
                      children: <Widget>[
                        FutureBuilder<List<Transaction>>(
                          future: _getTransactionChain(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Transaction>> transactions) {
                            return Expanded(
                              child: Stack(
                                children: <Widget>[
                                  if (!transactions.hasData)
                                    const SizedBox()
                                  else
                                    FadeIn(
                                      child: ListView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemCount: transactions.data!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return _buildTimelineTile(
                                            context,
                                            isFirst: index == 0 ? true : false,
                                            isLast: index ==
                                                    transactions.data!.length -
                                                        1
                                                ? true
                                                : false,
                                            indicator: index == 0
                                                ? const _IconIndicator(
                                                    iconData: Icons.last_page,
                                                    size: 25,
                                                  )
                                                : const _IconIndicator(
                                                    iconData: Icons
                                                        .arrow_circle_down_outlined,
                                                    size: 25,
                                                  ),
                                            dateTx: DateFormat.yMMMEd(
                                                    Localizations.localeOf(
                                                            context)
                                                        .languageCode)
                                                .add_Hms()
                                                .format(DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            transactions
                                                                    .data![
                                                                        index]
                                                                    .validationStamp!
                                                                    .timestamp! *
                                                                1000)
                                                    .toLocal())
                                                .toString(),
                                            address: transactions
                                                .data![index].address,
                                            balance: transactions
                                                .data![index].balance!.uco
                                                .toString(),
                                          );
                                        },
                                      ),
                                    ),

                                  //List Bottom Gradient End
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 15.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            StateContainer.of(context)
                                                .curTheme
                                                .backgroundDark00!,
                                            StateContainer.of(context)
                                                .curTheme
                                                .backgroundDark!,
                                          ],
                                          begin: const AlignmentDirectional(
                                              0.5, -1.0),
                                          end: const AlignmentDirectional(
                                              0.5, 1.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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
}

Widget buildSingleTransaction(BuildContext context, Transaction transaction) {
  return Divider(
    height: 2,
    color: StateContainer.of(context).curTheme.primary15,
  );
}

TimelineTile _buildTimelineTile(
  BuildContext context, {
  _IconIndicator? indicator,
  String? dateTx,
  String? address,
  String? balance,
  bool isFirst = false,
  bool isLast = false,
}) {
  return TimelineTile(
    alignment: TimelineAlign.manual,
    lineXY: 0.3,
    beforeLineStyle: LineStyle(color: Colors.white.withOpacity(0.7)),
    indicatorStyle: IndicatorStyle(
      indicatorXY: 0.3,
      drawGap: true,
      width: 30,
      height: 30,
      indicator: indicator,
    ),
    isFirst: isFirst,
    isLast: isLast,
    startChild: Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
      child: Text(
        dateTx!,
        textAlign: TextAlign.right,
      ),
    ),
    endChild: Padding(
      padding: const EdgeInsets.only(left: 16, right: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SelectableText(
            address!,
          ),
          const SizedBox(height: 4),
          Text(
            'UTXO: ' +
                balance! +
                ' ' +
                StateContainer.of(context)
                    .curNetwork
                    .getNetworkCryptoCurrencyLabel(),
          ),
          const SizedBox(height: 4),
        ],
      ),
    ),
  );
}

class _IconIndicator extends StatelessWidget {
  const _IconIndicator({
    this.iconData,
    this.size,
  });

  final IconData? iconData;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.white,
                blurRadius: 5,
                spreadRadius: 0,
              ),
            ],
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                iconData,
                size: size,
                color: StateContainer.of(context).curTheme.backgroundDark,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
