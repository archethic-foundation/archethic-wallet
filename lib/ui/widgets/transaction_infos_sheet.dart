// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/transaction_infos.dart';
import 'package:archethic_mobile_wallet/service/app_service.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/widgets/icon_widget.dart';

class TransactionInfosSheet extends StatefulWidget {
  final String txAddress;

  TransactionInfosSheet(this.txAddress) : super();

  _TransactionInfosSheetState createState() => _TransactionInfosSheetState();
}

class _TransactionInfosSheetState extends State<TransactionInfosSheet> {
  List<TransactionInfos> transactionInfos =
      List<TransactionInfos>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: FutureBuilder<List<TransactionInfos>>(
            future: sl.get<AppService>().getTransactionAllInfos(
                widget.txAddress,
                DateFormat.yMEd(Localizations.localeOf(context).languageCode)),
            builder: (BuildContext context,
                AsyncSnapshot<List<TransactionInfos>> list) {
              return Column(
                children: <Widget>[
                  // A row for the address text and close button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //Empty SizedBox
                      SizedBox(
                        width: 60,
                        height: 40,
                      ),
                      Column(
                        children: <Widget>[
                          // Sheet handle
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 5,
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                              color:
                                  StateContainer.of(context).curTheme.primary10,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                        ],
                      ),
                      //Empty SizedBox
                      SizedBox(
                        width: 60,
                        height: 40,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalization.of(context)!.transactionInfosHeader,
                        style: AppStyles.textStyleSize24W700Primary(context),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Stack(children: <Widget>[
                        Container(
                            height: 500,
                            child: SafeArea(
                              minimum: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.035,
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
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          padding: EdgeInsets.only(
                                              top: 15.0, bottom: 15),
                                          itemCount: list.data == null
                                              ? 0
                                              : list.data!.length,
                                          itemBuilder: (context, index) {
                                            // Build
                                            return buildInfo(
                                                context, list.data![index]);
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
            }));
  }

  Widget buildInfo(BuildContext context, TransactionInfos transactionInfo) {
    return Row(children: [
      Expanded(
        child: Stack(
          children: <Widget>[
            transactionInfo.titleInfo == ''
                ? const SizedBox()
                : Container(
                    padding: EdgeInsets.only(left: 10.0, top: 20),
                    width: 50,
                    height: 50,
                    child: buildIconWidget(
                        context,
                        'assets/icons/txInfos/' +
                            transactionInfo.titleInfo +
                            '.png',
                        50,
                        50)),
            transactionInfo.titleInfo == ''
                ? Container(
                    padding: EdgeInsets.only(left: 15.0, top: 10),
                    child: Column(
                      children: <Widget>[
                        Divider(
                          height: 2,
                          color: StateContainer.of(context).curTheme.primary15,
                        ),
                        // Main Container
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, bottom: 0, right: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AutoSizeText(
                                                TransactionInfos.getDisplayName(
                                                    context,
                                                    transactionInfo.domain),
                                                style: AppStyles
                                                    .textStyleSize16W600Primary(
                                                        context)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(left: 15.0, top: 10),
                    child: Column(
                      children: <Widget>[
                        Divider(
                          height: 2,
                          color: StateContainer.of(context).curTheme.primary15,
                        ),
                        // Main Container
                        Container(
                          padding:
                              EdgeInsets.only(left: 45.0, top: 5, right: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AutoSizeText(
                                        TransactionInfos.getDisplayName(
                                            context, transactionInfo.titleInfo),
                                        style: AppStyles
                                            .textStyleSize14W600Primary(
                                                context)),
                                    SelectableText(transactionInfo.valueInfo,
                                        style: AppStyles
                                            .textStyleSize14W100Primary(
                                                context)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    ]);
  }
}
