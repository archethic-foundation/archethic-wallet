/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/models/token.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/address_formatters.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/raw_info_popup.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/contacts/layouts/add_contact.dart';
import 'package:aewallet/ui/views/transactions/transaction_infos_sheet.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TransactionDetail extends ConsumerWidget {
  const TransactionDetail({required this.transaction, super.key});

  final RecentTransaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final settings = ref.watch(SettingsProviders.settings);
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);

    final selectedCurrencyMarketPrice =
        ref.watch(MarketPriceProviders.selectedCurrencyMarketPrice).valueOrNull;

    String? contactAddress;
    if (transaction.typeTx == RecentTransaction.transferOutput) {
      contactAddress = transaction.recipient;
    } else {
      if (transaction.typeTx == RecentTransaction.transferInput) {
        contactAddress = transaction.from;
      }
    }

    if (accountSelected == null || selectedCurrencyMarketPrice == null) {
      return const SizedBox();
    }

    // Component Color
    final borderColor = transaction.typeTx == RecentTransaction.transferOutput
        ? theme.backgroundRecentTxListCardTransferOutput!
        : transaction.typeTx! == RecentTransaction.tokenCreation
            ? theme.backgroundRecentTxListCardTokenCreation!
            : theme.backgroundRecentTxListCardTransferInput!;

    final backgroundColor =
        transaction.typeTx == RecentTransaction.transferOutput
            ? theme.backgroundRecentTxListCardTransferOutput
            : transaction.typeTx! == RecentTransaction.tokenCreation
                ? theme.backgroundRecentTxListCardTokenCreation
                : theme.backgroundRecentTxListCardTransferInput;

    return GestureDetector(
      onTap: () {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              settings.activeVibrations,
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
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            color: backgroundColor,
            child: Container(
              padding: const EdgeInsets.all(9.5),
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      if (transaction.typeTx == RecentTransaction.tokenCreation)
                        settings.showBalances
                            ? AutoSizeText(
                                '${NumberUtil.formatThousands(transaction.tokenInformations!.supply!)} ${transaction.tokenInformations!.symbol! == '' ? 'NFT' : transaction.tokenInformations!.symbol!}',
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
                                    if (settings.showBalances == true)
                                      if (transaction.typeTx ==
                                          RecentTransaction.transferOutput)
                                        Row(
                                          children: [
                                            if (transaction.tokenInformations ==
                                                null)
                                              AutoSizeText(
                                                '-${NumberUtil.formatThousands(transaction.amount!, round: true)} ${AccountBalance.cryptoCurrencyLabel}',
                                                style: theme
                                                    .textStyleSize12W400Primary,
                                              )
                                            else
                                              AutoSizeText(
                                                '-${NumberUtil.formatThousands(transaction.amount!, round: true)} ${transaction.tokenInformations!.symbol! == '' ? 'NFT' : transaction.tokenInformations!.symbol!}',
                                                style: theme
                                                    .textStyleSize12W400Primary,
                                              ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            const FaIcon(
                                              FontAwesomeIcons.arrowTurnUp,
                                              size: 12,
                                              color: Colors.red,
                                            )
                                          ],
                                        )
                                      else
                                        Row(
                                          children: [
                                            if (transaction.tokenInformations ==
                                                null)
                                              AutoSizeText(
                                                '${NumberUtil.formatThousands(transaction.amount!, round: true)} ${AccountBalance.cryptoCurrencyLabel}',
                                                style: theme
                                                    .textStyleSize12W400Primary,
                                              )
                                            else
                                              AutoSizeText(
                                                '${NumberUtil.formatThousands(transaction.amount!, round: true)} ${transaction.tokenInformations!.symbol! == '' ? 'NFT' : transaction.tokenInformations!.symbol!}',
                                                style: theme
                                                    .textStyleSize12W400Primary,
                                              ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            const FaIcon(
                                              FontAwesomeIcons.arrowTurnDown,
                                              size: 12,
                                              color: Colors.green,
                                            )
                                          ],
                                        )
                                    else
                                      AutoSizeText(
                                        '···········',
                                        style:
                                            theme.textStyleSize12W600Primary60,
                                      ),
                                  if (transaction.tokenInformations == null &&
                                      transaction.amount != null)
                                    if (settings.showBalances == true)
                                      Text(
                                        CurrencyUtil.convertAmountFormated(
                                          settings.currency.name,
                                          selectedCurrencyMarketPrice.amount,
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
                                    if (settings.showBalances == true)
                                      Text(
                                        CurrencyUtil.convertAmountFormated(
                                          settings.currency.name,
                                          selectedCurrencyMarketPrice.amount,
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
                                    if (settings.showBalances == true)
                                      if (transaction.typeTx ==
                                          RecentTransaction.transferOutput)
                                        Row(
                                          children: [
                                            if (transaction.tokenInformations ==
                                                null)
                                              AutoSizeText(
                                                '-${NumberUtil.formatThousands(transaction.amount!)} ${AccountBalance.cryptoCurrencyLabel}',
                                                style: theme
                                                    .textStyleSize12W400Primary,
                                              )
                                            else
                                              AutoSizeText(
                                                '-${NumberUtil.formatThousands(transaction.amount!)} ${transaction.tokenInformations!.symbol!}',
                                                style: theme
                                                    .textStyleSize12W400Primary,
                                              ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            const FaIcon(
                                              FontAwesomeIcons.arrowTurnUp,
                                              size: 12,
                                              color: Colors.red,
                                            )
                                          ],
                                        )
                                      else
                                        Row(
                                          children: [
                                            if (transaction.tokenInformations ==
                                                null)
                                              AutoSizeText(
                                                '${NumberUtil.formatThousands(transaction.amount!)} ${AccountBalance.cryptoCurrencyLabel}',
                                                style: theme
                                                    .textStyleSize12W400Primary,
                                              )
                                            else
                                              AutoSizeText(
                                                '${NumberUtil.formatThousands(transaction.amount!)} ${transaction.tokenInformations!.symbol!}',
                                                style: theme
                                                    .textStyleSize12W400Primary,
                                              ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            const FaIcon(
                                              FontAwesomeIcons.arrowTurnDown,
                                              size: 12,
                                              color: Colors.green,
                                            )
                                          ],
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
                              Expanded(
                                child: AutoSizeText(
                                  '${localizations.tokenCreated} ${transaction.tokenInformations!.name}',
                                  style: theme.textStyleSize12W400Primary,
                                ),
                              )
                            else
                              Expanded(
                                child: AutoSizeText(
                                  '${localizations.nftCreated} ${transaction.tokenInformations!.name}',
                                  style: theme.textStyleSize12W400Primary,
                                ),
                              ),
                            const SizedBox(
                              width: 2,
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
                                '${localizations.txListFrom} ${AddressFormatters(
                                  Address(
                                    address:
                                        transaction.contactInformations == null
                                            ? transaction.from!
                                            : transaction
                                                .contactInformations!.format,
                                  ).address!,
                                ).getShortString4()}',
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
                                '${localizations.txListTo} ${AddressFormatters(
                                  Address(
                                    address:
                                        transaction.contactInformations == null
                                            ? transaction.recipient!
                                            : transaction
                                                .contactInformations!.format,
                                  ).address!,
                                ).getShortString4()}',
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
                            if (settings.showBalances == true)
                              primaryCurrency.primaryCurrency ==
                                      AvailablePrimaryCurrencyEnum.native
                                  ? Text(
                                      '${localizations.txListFees} ${transaction.fee!} ${AccountBalance.cryptoCurrencyLabel} (${CurrencyUtil.convertAmountFormatedWithNumberOfDigits(settings.currency.name, selectedCurrencyMarketPrice.amount, transaction.fee!, 8)})',
                                      style: theme.textStyleSize12W400Primary,
                                    )
                                  : Text(
                                      '${localizations.txListFees} ${CurrencyUtil.convertAmountFormatedWithNumberOfDigits(settings.currency.name, selectedCurrencyMarketPrice.amount, transaction.fee!, 8)} (${transaction.fee!} ${AccountBalance.cryptoCurrencyLabel})',
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
                            GestureDetector(
                              onLongPressEnd: (details) {
                                RawInfoPopup.getPopup(
                                  context,
                                  ref,
                                  details,
                                  transaction.decryptedSecret![0],
                                );
                              },
                              child: Row(
                                children: [
                                  AutoSizeText(
                                    localizations.messageInTxTransfer,
                                    style: theme.textStyleSize12W400Primary,
                                  ),
                                  const SizedBox(width: 10),
                                  FaIcon(
                                    FontAwesomeIcons.commentDots,
                                    size: 12,
                                    color: theme.text,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          if (transaction.tokenInformations != null &&
                              (kTokenFordiddenName.contains(
                                    transaction.tokenInformations!.name!
                                        .toUpperCase(),
                                  ) ||
                                  kTokenFordiddenName.contains(
                                    transaction.tokenInformations!.symbol!
                                        .toUpperCase(),
                                  )))
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  UiIcons.warning,
                                  size: 10,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  localizations.notOfficialUCOWarning,
                                  style: theme.textStyleSize12W400Primary,
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                        ],
                      ),
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
