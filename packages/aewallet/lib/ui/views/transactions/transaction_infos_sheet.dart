// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/transaction_infos.dart';
import 'package:core/service/app_service.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:intl/intl.dart';

class TransactionInfosSheet extends StatefulWidget {
  const TransactionInfosSheet(this.txAddress, {Key? key}) : super(key: key);

  final String txAddress;

  @override
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
                DateFormat.yMEd(Localizations.localeOf(context).languageCode),
                StateContainer.of(context)
                    .curNetwork
                    .getNetworkCryptoCurrencyLabel()),
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
                              color:
                                  StateContainer.of(context).curTheme.primary10,
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
                        padding: const EdgeInsets.only(
                            top: 0.0, bottom: 0.0, left: 10.0, right: 10.0),
                        child: AutoSizeText(
                          AppLocalization.of(context)!.transactionInfosHeader,
                          style: AppStyles.textStyleSize24W700Primary(context),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
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
                                          padding: const EdgeInsets.only(
                                              top: 15.0, bottom: 15),
                                          itemCount: list.data == null
                                              ? 0
                                              : list.data!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            // Build
                                            return buildInfo(
                                                context, list.data![index]);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      AppButton.buildAppButton(
                                          const Key('viewExplorer'),
                                          context,
                                          AppButtonType.primary,
                                          AppLocalization.of(context)!
                                              .viewExplorer,
                                          Dimens.buttonTopDimens,
                                          icon: Icon(
                                            Icons.more_horiz,
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .primary,
                                          ), onPressed: () async {
                                        UIUtil.showWebview(
                                            context,
                                            StateContainer.of(context)
                                                    .curNetwork
                                                    .getLink() +
                                                '/explorer/transaction/' +
                                                widget.txAddress,
                                            '');
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
                    ),
                  ),
                ],
              );
            }));
  }

  Widget buildInfo(BuildContext context, TransactionInfos transactionInfo) {
    return Row(children: <Widget>[
      Expanded(
        child: Stack(
          children: <Widget>[
            if (transactionInfo.titleInfo == '')
              const SizedBox()
            else
              Container(
                  padding: const EdgeInsets.only(left: 10.0, top: 20),
                  width: 50,
                  height: 50,
                  child: buildIconWidget(
                      context,
                      'packages/aewallet/assets/icons/txInfos/' +
                          transactionInfo.titleInfo +
                          '.png',
                      50,
                      50)),
            if (transactionInfo.titleInfo == '')
              Container(
                padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 0),
                child: Column(
                  children: <Widget>[
                    // Main Container
                    Container(
                      padding: const EdgeInsets.only(
                          left: 45.0, top: 0, right: 5, bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
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
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                  ],
                ),
              )
            else
              Container(
                padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 0),
                child: Column(
                  children: <Widget>[
                    // Main Container
                    Container(
                      padding: const EdgeInsets.only(
                          left: 45.0, top: 0, right: 5, bottom: 5),
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
                                    style: AppStyles.textStyleSize14W600Primary(
                                        context)),
                                SelectableText(transactionInfo.valueInfo,
                                    style: AppStyles.textStyleSize14W100Primary(
                                        context)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
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
