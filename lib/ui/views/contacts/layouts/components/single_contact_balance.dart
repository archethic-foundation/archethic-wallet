import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/themes/styles.dart';
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
          // TODO(reddwarf03): This should probably not be done here
          contact: contact,
        );
        final language = ref.watch(
          LanguageProviders.selectedLanguage,
        );
        final settings = ref.watch(SettingsProviders.settings);
        final primaryCurrency =
            ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);

        final asyncFiatAmount = ref.watch(
          MarketPriceProviders.convertedToSelectedCurrency(
            nativeAmount: accountBalance.nativeTokenValue,
          ),
        );
        final fiatAmountString = asyncFiatAmount.maybeWhen(
          data: CurrencyUtil.format,
          orElse: () => '--',
        );

        if (settings.showBalances) {
          return primaryCurrency.primaryCurrency ==
                  AvailablePrimaryCurrencyEnum.native
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      '${accountBalance.nativeTokenValueToString(language.getLocaleStringWithoutDefault(), digits: accountBalance.nativeTokenValue < 1 ? 8 : 2)} ${accountBalance.nativeTokenName}',
                      style: ArchethicThemeStyles.textStyleSize12W100Primary,
                      textAlign: TextAlign.end,
                    ),
                    AutoSizeText(
                      fiatAmountString,
                      textAlign: TextAlign.end,
                      style: ArchethicThemeStyles.textStyleSize12W100Primary,
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      fiatAmountString,
                      textAlign: TextAlign.end,
                      style: ArchethicThemeStyles.textStyleSize12W100Primary,
                    ),
                    AutoSizeText(
                      '${accountBalance.nativeTokenValueToString(language.getLocaleStringWithoutDefault(), digits: accountBalance.nativeTokenValue < 1 ? 8 : 2)} ${accountBalance.nativeTokenName}',
                      style: ArchethicThemeStyles.textStyleSize12W100Primary,
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
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
                textAlign: TextAlign.end,
              ),
              AutoSizeText(
                '···········',
                textAlign: TextAlign.end,
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
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
