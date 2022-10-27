/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/primary_currency.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/contacts/add_contact.dart';
import 'package:aewallet/ui/views/transactions/transaction_infos_sheet.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:intl/intl.dart';

class TransactionDetail extends ConsumerWidget {
  const TransactionDetail({required this.transaction, super.key});

  final RecentTransaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final preferences = ref.watch(SettingsProviders.settings);
    final accountSelected = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!;
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
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
                        primaryCurrency.primaryCurrency ==
                                AvailablePrimaryCurrencyEnum.native
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
                                          ? transaction
                                              .from! // TODO(Chralu): Should we show origin or destination address ?
                                          : transaction
                                              .contactInformations!.format,
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
                                              .contactInformations!.format,
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
                              primaryCurrency.primaryCurrency ==
                                      AvailablePrimaryCurrencyEnum.native
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
