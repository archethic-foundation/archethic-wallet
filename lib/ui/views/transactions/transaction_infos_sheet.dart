/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/transaction_infos.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/util/get_it_instance.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionInfosSheet extends StatefulWidget {
  const TransactionInfosSheet(this.txAddress, {super.key});

  final String txAddress;

  @override
  State<TransactionInfosSheet> createState() => _TransactionInfosSheetState();
}

class _TransactionInfosSheetState extends State<TransactionInfosSheet> {
  List<TransactionInfos> transactionInfos =
      List<TransactionInfos>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    final theme = StateContainer.of(context).curTheme;

    return SafeArea(
      minimum:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: FutureBuilder<List<TransactionInfos>>(
        future: sl.get<AppService>().getTransactionAllInfos(
              widget.txAddress,
              DateFormat.yMEd(Localizations.localeOf(context).languageCode),
              StateContainer.of(context)
                  .curNetwork
                  .getNetworkCryptoCurrencyLabel(),
              context,
              StateContainer.of(context)
                  .appWallet!
                  .appKeychain!
                  .getAccountSelected()!
                  .name!,
            ),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<TransactionInfos>> list,
        ) {
          return Column(
            children: <Widget>[
              SheetHeader(
                title: AppLocalization.of(context)!.transactionInfosHeader,
              ),
              Expanded(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: SafeArea(
                          minimum: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.035,
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
                                        top: 15,
                                        bottom: 15,
                                      ),
                                      itemCount: list.data == null
                                          ? 0
                                          : list.data!.length,
                                      itemBuilder: (
                                        BuildContext context,
                                        int index,
                                      ) {
                                        return _TransactionBuildInfos(
                                          transactionInfo: list.data![index],
                                        );
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
                                    AppLocalization.of(context)!.viewExplorer,
                                    Dimens.buttonBottomDimens,
                                    icon: Icon(
                                      Icons.more_horiz,
                                      color: theme.text,
                                    ),
                                    onPressed: () async {
                                      UIUtil.showWebview(
                                        context,
                                        '${await StateContainer.of(context).curNetwork.getLink()}/explorer/transaction/${widget.txAddress}',
                                        '',
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TransactionBuildInfos extends StatelessWidget {
  const _TransactionBuildInfos({required this.transactionInfo, super.key});

  final TransactionInfos transactionInfo;

  @override
  Widget build(BuildContext context) {
    final theme = StateContainer.of(context).curTheme;

    return (StateContainer.of(context).showBalance == true ||
            (StateContainer.of(context).showBalance == false &&
                transactionInfo.titleInfo != 'Amount'))
        ? Row(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    if (transactionInfo.titleInfo == '')
                      const SizedBox()
                    else
                      Container(
                        padding: const EdgeInsets.only(left: 10, top: 20),
                        width: 50,
                        height: 50,
                        child: IconWidget.build(
                          context,
                          'assets/icons/txInfos/${transactionInfo.titleInfo}.png',
                          50,
                          50,
                        ),
                      ),
                    if (transactionInfo.titleInfo == '')
                      Container(
                        color: theme.text05,
                        child: Container(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: Column(
                            children: <Widget>[
                              // Main Container
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 45,
                                  right: 5,
                                  bottom: 15,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  AutoSizeText(
                                                    TransactionInfos
                                                        .getDisplayName(
                                                      context,
                                                      transactionInfo.domain,
                                                    ),
                                                    style: AppStyles
                                                        .textStyleSize16W600Primary(
                                                      context,
                                                    ),
                                                  ),
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
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.only(left: 15, top: 15),
                        child: Column(
                          children: <Widget>[
                            // Main Container
                            Container(
                              padding: const EdgeInsets.only(
                                left: 45,
                                right: 5,
                                bottom: 15,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        AutoSizeText(
                                          TransactionInfos.getDisplayName(
                                            context,
                                            transactionInfo.titleInfo,
                                          ),
                                          style: AppStyles
                                              .textStyleSize14W600Primary(
                                            context,
                                          ),
                                        ),
                                        SelectableText(
                                          transactionInfo.valueInfo,
                                          style: AppStyles
                                              .textStyleSize14W100Primary(
                                            context,
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
                    Divider(
                      height: 2,
                      color: theme.text15,
                    ),
                  ],
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
