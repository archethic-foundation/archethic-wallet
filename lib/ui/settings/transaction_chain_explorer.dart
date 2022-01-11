// ignore_for_file: must_be_immutable

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:archethic_wallet/service_locator.dart';
import 'package:archethic_wallet/styles.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show Transaction, ApiService;

class TransactionChainExplorer extends StatefulWidget {
  @override
  _TransactionChainExplorerState createState() =>
      _TransactionChainExplorerState();
}

class _TransactionChainExplorerState extends State<TransactionChainExplorer> {
  Future<List<Transaction>> _getTransactionChain() async {
    await Future<Duration>.delayed(const Duration(seconds: 3));
    List<Transaction>? _transactions;
    _transactions = await sl.get<ApiService>().getTransactionChain(
        '007BCAA30EF42EEB507A0D47CAEE914C176525BF1E10CE5E53F7A5465421E7DE4B',
        0);
    return _transactions;
  }

  @override
  void initState() {
    _getTransactionChain();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: StateContainer.of(context).curTheme.backgroundDark,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: StateContainer.of(context).curTheme.overlay30!,
                offset: const Offset(-5, 0),
                blurRadius: 20),
          ],
        ),
        child: SafeArea(
          minimum: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.035,
            top: 60,
          ),
          child: Column(
            children: <Widget>[
              // Back button
              Container(
                margin: const EdgeInsets.only(bottom: 10.0, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          AppLocalization.of(context)!
                              .transactionChainExplorerHeader,
                          style: AppStyles.textStyleSize28W700Primary(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.3,
                isFirst: true,
                indicatorStyle: IndicatorStyle(
                  width: 30,
                  height: 30,
                  indicator: _Start(),
                ),
                beforeLineStyle:
                    LineStyle(color: Colors.white.withOpacity(0.7)),
                endChild: _ContainerHeader(),
              ),
              FutureBuilder<List<Transaction>>(
                future: _getTransactionChain(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Transaction>> transactions) {
                  return Expanded(
                    child: Stack(
                      children: <Widget>[
                        if (!transactions.hasData)
                          const CircularProgressIndicator()
                        else
                          ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 15),
                            itemCount: transactions.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _buildTimelineTile(
                                indicator: const _IconIndicator(
                                  iconData: Icons.arrow_circle_down_outlined,
                                  size: 25,
                                ),
                                hour: transactions
                                    .data![index].validationStamp!.timestamp
                                    .toString(),
                                address: transactions.data![index].address,
                                balance: transactions.data![index].balance!.uco
                                    .toString(),
                              );
                            },
                          ),
                        //List Top Gradient End
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 20.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  StateContainer.of(context)
                                      .curTheme
                                      .backgroundDark!,
                                  StateContainer.of(context)
                                      .curTheme
                                      .backgroundDark00!
                                ],
                                begin: const AlignmentDirectional(0.5, -1.0),
                                end: const AlignmentDirectional(0.5, 1.0),
                              ),
                            ),
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
                                begin: const AlignmentDirectional(0.5, -1.0),
                                end: const AlignmentDirectional(0.5, 1.0),
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
        ));
  }

  Widget buildSingleTransaction(BuildContext context, Transaction transaction) {
    return Divider(
      height: 2,
      color: StateContainer.of(context).curTheme.primary15,
    );
  }
}

class _ContainerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 120),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            const Text(
              'now - 17:30',
            ),
            const Text(
              'Sunny',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                Expanded(
                  child: Text(
                    'Humidity 40%',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  '30°C',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.white,
            blurRadius: 25,
            spreadRadius: 20,
          ),
        ],
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}

TimelineTile _buildTimelineTile({
  _IconIndicator? indicator,
  String? hour,
  String? address,
  String? balance,
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
    isLast: isLast,
    startChild: Center(
      child: Container(
        alignment: const Alignment(0.0, -0.50),
        child: Text(
          hour!,
        ),
      ),
    ),
    endChild: Padding(
      padding: const EdgeInsets.only(left: 16, right: 10, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            address!,
          ),
          const SizedBox(height: 4),
          Text(
            balance!,
          ),
          const SizedBox(height: 4),
        ],
      ),
    ),
  );
}

class _IconIndicator extends StatelessWidget {
  const _IconIndicator({
    Key? key,
    this.iconData,
    this.size,
  }) : super(key: key);

  final IconData? iconData;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.7),
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
