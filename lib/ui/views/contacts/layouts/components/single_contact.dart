import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/contacts/layouts/contact_detail.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class SingleContact extends ConsumerWidget {
  const SingleContact({
    super.key,
    required this.contact,
    required this.account,
  });

  final Contact contact;
  final Account? account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final settings = ref.watch(SettingsProviders.settings);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);

    final asyncFiatAmount = ref.watch(
      MarketPriceProviders.convertedToSelectedCurrency(
        nativeAmount: account?.balance?.nativeTokenValue ?? 0,
      ),
    );
    final fiatAmountString = asyncFiatAmount.maybeWhen(
      data: (fiatAmount) => CurrencyUtil.format(
        settings.currency.name,
        fiatAmount,
      ),
      orElse: () => '--',
    );

    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(),
        ),
      ),
      onPressed: () {
        Sheets.showAppHeightNineSheet(
          context: context,
          ref: ref,
          widget: ContactDetail(
            contact: contact,
          ),
        );
      },
      child: Expanded(
        child: SizedBox(
          height: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  if (contact.type == ContactType.keychainService.name)
                    Icon(
                      Symbols.account_balance_wallet,
                      color: theme.iconDrawer,
                      size: 25,
                      weight: IconSize.weightM,
                      opticalSize: IconSize.opticalSizeM,
                      grade: IconSize.gradeM,
                    )
                  else
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Icon(
                          Symbols.person,
                          color: theme.iconDrawer,
                          size: 25,
                          weight: IconSize.weightM,
                          opticalSize: IconSize.opticalSizeM,
                          grade: IconSize.gradeM,
                        ),
                        if (contact.favorite == true)
                          Icon(
                            Symbols.favorite,
                            color: theme.favoriteIconColor,
                            size: 12,
                            weight: IconSize.weightM,
                            opticalSize: IconSize.opticalSizeM,
                            grade: IconSize.gradeM,
                            fill: 1,
                          ),
                      ],
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      contact.format,
                      style: theme.textStyleSize14W600Primary,
                    ),
                  ),
                  if (account != null) ...[
                    if (settings.showBalances)
                      primaryCurrency.primaryCurrency ==
                              AvailablePrimaryCurrencyEnum.native
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                AutoSizeText(
                                  '${account!.balance!.nativeTokenValueToString(digits: 2)} ${account!.balance!.nativeTokenName}',
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
                                  '${account!.balance!.nativeTokenValueToString(digits: 2)} ${account!.balance!.nativeTokenName}',
                                  style: theme.textStyleSize12W400Primary,
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            )
                    else
                      Column(
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
                      ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
