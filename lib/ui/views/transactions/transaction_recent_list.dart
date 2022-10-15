/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/contacts/add_contact.dart';
import 'package:aewallet/ui/views/transactions/transaction_infos_sheet.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/number_util.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:intl/intl.dart';

class TxList extends ConsumerWidget {
  const TxList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (accountSelected.recentTransactions!.isEmpty)
          Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 26),
              child: Text(
                AppLocalization.of(context)!.recentTransactionsNoTransactionYet,
                style: theme.textStyleSize14W600Primary,
              ),
            ),
          ),
        _TxListLine(num: 0, accountSelected: accountSelected),
        _TxListLine(num: 1, accountSelected: accountSelected),
        _TxListLine(num: 2, accountSelected: accountSelected),
        _TxListLine(num: 3, accountSelected: accountSelected),
        _TxListLine(num: 4, accountSelected: accountSelected),
        _TxListLine(num: 5, accountSelected: accountSelected),
        _TxListLine(num: 6, accountSelected: accountSelected),
        _TxListLine(num: 7, accountSelected: accountSelected),
        _TxListLine(num: 8, accountSelected: accountSelected),
        _TxListLine(num: 9, accountSelected: accountSelected)
      ],
    );
  }
}

class _TxListLine extends ConsumerWidget {
  const _TxListLine({
    required this.num,
    required this.accountSelected,
  });

  final int num;
  final Account accountSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 26, right: 26, top: 6),
        child: (accountSelected.recentTransactions!.isNotEmpty &&
                    accountSelected.recentTransactions!.length > num) ||
                (StateContainer.of(context).recentTransactionsLoading == true &&
                    accountSelected.recentTransactions!.length > num)
            ? displayTxDetailTransfer(
                context,
                ref,
                accountSelected.recentTransactions![num],
              )
            : const SizedBox(),
      ),
    );
  }

  // TODO(Chralu): Extract to a [Widget] subclass
  Widget displayTxDetailTransfer(
    BuildContext context,
    WidgetRef ref,
    RecentTransaction transaction,
  ) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final preferences = ref.watch(preferenceProvider);
    String? contactAddress;
    if (transaction.typeTx == RecentTransaction.transferOutput) {
      contactAddress = transaction.recipient;
    } else {
      if (transaction.typeTx == RecentTransaction.transferInput) {
        contactAddress = transaction.from;
      }
    }
    return GestureDetector(
      onTap: () {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );
        Sheets.showAppHeightNineSheet(
          context: context,
          ref: ref,
          widget: TransactionInfosSheet(transaction.address!),
        );
      },
      onLongPress: () {
        if (transaction.contactInformations == null && contactAddress != null) {
          Sheets.showAppHeightNineSheet(
            context: context,
            ref: ref,
            widget: AddContactSheet(address: contactAddress),
          );
        }
      },
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: transaction.typeTx == RecentTransaction.transferOutput
                    ? theme.backgroundRecentTxListCardTransferOutput!
                    : transaction.typeTx! == RecentTransaction.tokenCreation
                        ? theme.backgroundRecentTxListCardTokenCreation!
                        : theme.backgroundRecentTxListCardTransferInput!,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            color: transaction.typeTx == RecentTransaction.transferOutput
                ? theme.backgroundRecentTxListCardTransferOutput
                : transaction.typeTx! == RecentTransaction.tokenCreation
                    ? theme.backgroundRecentTxListCardTokenCreation
                    : theme.backgroundRecentTxListCardTransferInput,
            child: Container(
              padding: const EdgeInsets.all(9.5),
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      if (transaction.typeTx == RecentTransaction.tokenCreation)
                        preferences.showBalances
                            ? AutoSizeText(
                                '${NumberUtil.formatThousands(transaction.tokenInformations!.supply!)} ${transaction.tokenInformations!.symbol}',
                                style: theme.textStyleSize12W400Primary,
                              )
                            : AutoSizeText(
                                '···········',
                                style: theme.textStyleSize12W600Primary60,
                              )
                      else
                        StateContainer.of(context)
                                    .curPrimaryCurrency
                                    .primaryCurrency
                                    .name ==
                                const PrimaryCurrencySetting(
                                  AvailablePrimaryCurrency.native,
                                ).primaryCurrency.name
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (transaction.amount != null)
                                    if (preferences.showBalances == true)
                                      if (transaction.typeTx ==
                                          RecentTransaction.transferOutput)
                                        if (transaction.tokenInformations ==
                                            null)
                                          transaction.amount! > 1000000
                                              ? AutoSizeText(
                                                  '-${NumberUtil.formatThousands(transaction.amount!.round())} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                                  style: theme
                                                      .textStyleSize12W400Primary,
                                                )
                                              : AutoSizeText(
                                                  '-${NumberUtil.formatThousands(transaction.amount!)} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                                  style: theme
                                                      .textStyleSize12W400Primary,
                                                )
                                        else
                                          transaction.amount! > 1000000
                                              ? AutoSizeText(
                                                  '-${NumberUtil.formatThousands(transaction.amount!.round())} ${transaction.tokenInformations!.symbol!}',
                                                  style: theme
                                                      .textStyleSize12W400Primary,
                                                )
                                              : AutoSizeText(
                                                  '-${NumberUtil.formatThousands(transaction.amount!)} ${transaction.tokenInformations!.symbol!}',
                                                  style: theme
                                                      .textStyleSize12W400Primary,
                                                )
                                      else if (transaction.tokenInformations ==
                                          null)
                                        transaction.amount! > 1000000
                                            ? AutoSizeText(
                                                '${NumberUtil.formatThousands(transaction.amount!.round())} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                                style: theme
                                                    .textStyleSize12W400Primary,
                                              )
                                            : AutoSizeText(
                                                '${NumberUtil.formatThousands(transaction.amount!)} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                                style: theme
                                                    .textStyleSize12W400Primary,
                                              )
                                      else
                                        transaction.amount! > 1000000
                                            ? AutoSizeText(
                                                '${NumberUtil.formatThousands(transaction.amount!.round())} ${transaction.tokenInformations!.symbol!}',
                                                style: theme
                                                    .textStyleSize12W400Primary,
                                              )
                                            : AutoSizeText(
                                                '${NumberUtil.formatThousands(transaction.amount!)} ${transaction.tokenInformations!.symbol!}',
                                                style: theme
                                                    .textStyleSize12W400Primary,
                                              )
                                    else
                                      AutoSizeText(
                                        '···········',
                                        style:
                                            theme.textStyleSize12W600Primary60,
                                      ),
                                  if (transaction.tokenInformations == null &&
                                      transaction.amount != null)
                                    if (preferences.showBalances == true)
                                      Text(
                                        CurrencyUtil.convertAmountFormated(
                                          currency.currency.name,
                                          accountSelected
                                              .balance!.tokenPrice!.amount!,
                                          transaction.amount!,
                                        ),
                                        style: theme.textStyleSize12W400Primary,
                                      )
                                    else
                                      AutoSizeText(
                                        '···········',
                                        style:
                                            theme.textStyleSize12W600Primary60,
                                      ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (transaction.tokenInformations == null &&
                                      transaction.amount != null)
                                    if (preferences.showBalances == true)
                                      Text(
                                        CurrencyUtil.convertAmountFormated(
                                          currency.currency.name,
                                          accountSelected
                                              .balance!.tokenPrice!.amount!,
                                          transaction.amount!,
                                        ),
                                        style: theme.textStyleSize12W400Primary,
                                      )
                                    else
                                      AutoSizeText(
                                        '···········',
                                        style:
                                            theme.textStyleSize12W600Primary60,
                                      ),
                                  if (transaction.amount != null)
                                    if (preferences.showBalances == true)
                                      if (transaction.typeTx ==
                                          RecentTransaction.transferOutput)
                                        if (transaction.tokenInformations ==
                                            null)
                                          AutoSizeText(
                                            '-${NumberUtil.formatThousands(transaction.amount!)} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                            style: theme
                                                .textStyleSize12W400Primary,
                                          )
                                        else
                                          AutoSizeText(
                                            '-${NumberUtil.formatThousands(transaction.amount!)} ${transaction.tokenInformations!.symbol!}',
                                            style: theme
                                                .textStyleSize12W400Primary,
                                          )
                                      else if (transaction.tokenInformations ==
                                          null)
                                        AutoSizeText(
                                          '${NumberUtil.formatThousands(transaction.amount!)} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                          style:
                                              theme.textStyleSize12W400Primary,
                                        )
                                      else
                                        AutoSizeText(
                                          '${NumberUtil.formatThousands(transaction.amount!)} ${transaction.tokenInformations!.symbol!}',
                                          style:
                                              theme.textStyleSize12W400Primary,
                                        )
                                    else
                                      AutoSizeText(
                                        '···········',
                                        style:
                                            theme.textStyleSize12W600Primary60,
                                      ),
                                ],
                              )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      if (transaction.typeTx == RecentTransaction.tokenCreation)
                        Row(
                          children: [
                            if (transaction.tokenInformations!.type ==
                                'fungible')
                              AutoSizeText(
                                '${localizations.tokenCreated}: ${transaction.tokenInformations!.name}',
                                style: theme.textStyleSize12W400Primary,
                              )
                            else
                              AutoSizeText(
                                '${localizations.nftCreated}: ${transaction.tokenInformations!.name}',
                                style: theme.textStyleSize12W400Primary,
                              ),
                          ],
                        ),
                      if (transaction.typeTx ==
                              RecentTransaction.transferOutput ||
                          transaction.typeTx == RecentTransaction.tokenCreation)
                        const SizedBox()
                      else
                        Row(
                          children: <Widget>[
                            if (transaction.from == null)
                              const Text('')
                            else
                              Text(
                                localizations.txListFrom +
                                    Address(
                                      transaction.contactInformations == null
                                          ? transaction.from!
                                          : transaction
                                              .contactInformations!.name!
                                              .replaceFirst('@', ''),
                                    ).getShortString4(),
                                style: theme.textStyleSize12W400Primary,
                              )
                          ],
                        ),
                      if (transaction.typeTx ==
                              RecentTransaction.transferInput ||
                          transaction.typeTx == RecentTransaction.tokenCreation)
                        const SizedBox()
                      else
                        Row(
                          children: <Widget>[
                            if (transaction.recipient == null)
                              const Text('')
                            else
                              Text(
                                localizations.txListTo +
                                    Address(
                                      transaction.contactInformations == null
                                          ? transaction.recipient!
                                          : transaction
                                              .contactInformations!.name!
                                              .replaceFirst('@', ''),
                                    ).getShortString4(),
                                style: theme.textStyleSize12W400Primary,
                              )
                          ],
                        ),
                      Row(
                        children: <Widget>[
                          Text(
                            DateFormat.yMMMEd(
                              Localizations.localeOf(context).languageCode,
                            ).add_Hms().format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    transaction.timestamp! * 1000,
                                  ).toLocal(),
                                ),
                            style: theme.textStyleSize12W400Primary,
                          ),
                        ],
                      ),
                      if (transaction.typeTx != RecentTransaction.transferInput)
                        Row(
                          children: <Widget>[
                            if (preferences.showBalances == true)
                              StateContainer.of(context)
                                          .curPrimaryCurrency
                                          .primaryCurrency
                                          .name ==
                                      const PrimaryCurrencySetting(
                                        AvailablePrimaryCurrency.native,
                                      ).primaryCurrency.name
                                  ? Text(
                                      '${localizations.txListFees} ${transaction.fee!} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()} (${CurrencyUtil.convertAmountFormatedWithNumberOfDigits(currency.currency.name, accountSelected.balance!.tokenPrice!.amount!, transaction.fee!, 8)})',
                                      style: theme.textStyleSize12W400Primary,
                                    )
                                  : Text(
                                      '${localizations.txListFees} ${CurrencyUtil.convertAmountFormatedWithNumberOfDigits(currency.currency.name, accountSelected.balance!.tokenPrice!.amount!, transaction.fee!, 8)} (${transaction.fee!} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()})',
                                      style: theme.textStyleSize12W400Primary,
                                    )
                            else
                              Text(
                                '···········',
                                style: theme.textStyleSize12W600Primary60,
                              )
                          ],
                        ),
                      Row(
                        children: [
                          if (transaction.typeTx !=
                                  RecentTransaction.tokenCreation &&
                              transaction.decryptedSecret != null &&
                              transaction.decryptedSecret!.isNotEmpty)
                            AutoSizeText(
                              localizations.messageInTxTransfer,
                              style: theme.textStyleSize12W400Primary,
                            )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
