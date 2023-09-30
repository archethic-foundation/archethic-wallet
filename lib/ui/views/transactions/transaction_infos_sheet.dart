/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:developer';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/transaction_infos.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransactionInfosSheet extends ConsumerStatefulWidget {
  const TransactionInfosSheet(this.notificationRecipientAddress, {super.key});

  final String notificationRecipientAddress;

  @override
  ConsumerState<TransactionInfosSheet> createState() =>
      _TransactionInfosSheetState();
}

class _TransactionInfosSheetState extends ConsumerState<TransactionInfosSheet> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final session = ref.watch(SessionProviders.session).loggedIn!;
    final selectedAccount =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;

    if (selectedAccount == null) return const SizedBox();

    return SafeArea(
      minimum:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: FutureBuilder<List<TransactionInfos>>(
        future: sl.get<AppService>().getTransactionAllInfos(
              widget.notificationRecipientAddress,
              DateFormat.yMEd(Localizations.localeOf(context).languageCode),
              AccountBalance.cryptoCurrencyLabel,
              context,
              session.wallet.keychainSecuredInfos
                  .services[selectedAccount.name]!.keyPair!,
            ),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<TransactionInfos>> list,
        ) {
          return Column(
            children: <Widget>[
              SheetHeader(
                title: localizations.transactionInfosHeader,
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
                          child: list.hasData
                              ? _TransactionInfos(
                                  list: list,
                                  scrollController: scrollController,
                                  notificationRecipientAddress:
                                      widget.notificationRecipientAddress,
                                )
                              : _TransactionLoading(),
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

class _TransactionLoading extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Center(
      child: CircularProgressIndicator(
        color: theme.text,
        strokeWidth: 1,
      ),
    );
  }
}

class _TransactionInfos extends ConsumerWidget {
  const _TransactionInfos({
    required this.list,
    required this.scrollController,
    required this.notificationRecipientAddress,
  });

  final AsyncSnapshot<List<TransactionInfos>> list;
  final ScrollController scrollController;
  final String notificationRecipientAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              Scrollbar(
                thumbVisibility: true,
                controller: scrollController,
                child: ListView.builder(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                  ),
                  itemCount: list.data == null ? 0 : list.data!.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: _TransactionBuildInfos(
                        transactionInfo: list.data![index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            AppButtonTinyConnectivity(
              localizations.viewExplorer,
              Dimens.buttonBottomDimens,
              icon: Symbols.more_horiz,
              key: const Key('viewExplorer'),
              onPressed: () async {
                UIUtil.showWebview(
                  context,
                  '${ref.read(SettingsProviders.settings).network.getLink()}/explorer/transaction/$notificationRecipientAddress',
                  '',
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _TransactionBuildInfos extends ConsumerWidget {
  const _TransactionBuildInfos({required this.transactionInfo});

  final TransactionInfos transactionInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    return (preferences.showBalances == true ||
            (preferences.showBalances == false &&
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
                        child: IconWidget(
                          icon:
                              'assets/icons/txInfos/${transactionInfo.titleInfo}.png',
                          width: 50,
                          height: 50,
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
                                                    style: theme
                                                        .textStyleSize16W600Primary,
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
                                          style:
                                              theme.textStyleSize14W600Primary,
                                        ),
                                        _transactionInfoValue(
                                          ref,
                                          transactionInfo,
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

  Widget _transactionInfoValue(
      WidgetRef ref, TransactionInfos transactionInfo) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    if (transactionInfo.domain == 'UCOLedger' &&
        transactionInfo.titleInfo == 'To') {
      log('transactionInfo.valueInfo: ${transactionInfo.valueInfo}');
      return ref
          .watch(
            ContactProviders.getContactWithAddress(transactionInfo.valueInfo),
          )
          .map(
            data: (data) {
              if (data.value == null) {
                log('transactionInfo.valueInfo: ${transactionInfo.valueInfo} : data null');
                return SelectableText(
                  transactionInfo.valueInfo,
                  style: theme.textStyleSize14W100Primary,
                );
              } else {
                log('transactionInfo.valueInfo: ${transactionInfo.valueInfo} : data not null');
                return SelectableText(
                  data.value!.format,
                  style: theme.textStyleSize14W100Primary,
                );
              }
            },
            error: (error) => SelectableText(
              transactionInfo.valueInfo,
              style: theme.textStyleSize14W100Primary,
            ),
            loading: (loading) => SelectableText(
              transactionInfo.valueInfo,
              style: theme.textStyleSize14W100Primary,
            ),
          );
    } else {
      return SelectableText(
        transactionInfo.valueInfo,
        style: theme.textStyleSize14W100Primary,
      );
    }
  }
}
