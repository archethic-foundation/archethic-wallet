import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleContactBalance extends ConsumerWidget {
  const SingleContactBalance({
    super.key,
    required this.contact,
    required this.accountBalance,
  });

  final Contact contact;
  final AsyncValue<AccountBalance> accountBalance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return accountBalance.when(
      data: (accountBalance) {
        ContactProviders.saveContact(
          contact: contact,
        );

        final theme = ref.watch(ThemeProviders.selectedTheme);
        final settings = ref.watch(SettingsProviders.settings);
        final primaryCurrency =
            ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);

        final asyncFiatAmount = ref.watch(
          MarketPriceProviders.convertedToSelectedCurrency(
            nativeAmount: accountBalance.nativeTokenValue,
          ),
        );
        final fiatAmountString = asyncFiatAmount.maybeWhen(
          data: (fiatAmount) => CurrencyUtil.format(
            settings.currency.name,
            fiatAmount,
          ),
          orElse: () => '--',
        );

        if (settings.showBalances) {
          return primaryCurrency.primaryCurrency ==
                  AvailablePrimaryCurrencyEnum.native
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      '${accountBalance.nativeTokenValueToString(digits: 2)} ${accountBalance.nativeTokenName}',
                      style: theme.textStyleSize12W400Primary,
                      textAlign: TextAlign.end,
                    ),
                    AutoSizeText(
                      fiatAmountString,
                      textAlign: TextAlign.end,
                      style: theme.textStyleSize12W400Primary,
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      fiatAmountString,
                      textAlign: TextAlign.end,
                      style: theme.textStyleSize12W400Primary,
                    ),
                    AutoSizeText(
                      '${accountBalance.nativeTokenValueToString(digits: 2)} ${accountBalance.nativeTokenName}',
                      style: theme.textStyleSize12W400Primary,
                      textAlign: TextAlign.end,
                    ),
                  ],
                );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AutoSizeText(
                '···········',
                style: theme.textStyleSize12W400Primary,
                textAlign: TextAlign.end,
              ),
              AutoSizeText(
                '···········',
                textAlign: TextAlign.end,
                style: theme.textStyleSize12W400Primary,
              ),
            ],
          );
        }
      },
      error: (error, stack) => const Column(
        children: [SizedBox()],
      ),
      loading: () => const Column(
        children: [SizedBox()],
      ),
    );
  }
}
