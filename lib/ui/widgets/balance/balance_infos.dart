/// SPDX-License-Identifier: AGPL-3.0-or-later

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/chart_infos.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/sheets/chart_sheet.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/history_chart.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
// Package imports:
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'components/balance_infos_build_chart.dart';
part 'components/balance_infos_build_kpi.dart';

class BalanceInfos extends StatelessWidget {
  const BalanceInfos({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = StateContainer.of(context).curTheme;
    final accountSelectedBalance = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!
        .balance;

    return GestureDetector(
      child: SizedBox(
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Card(
            color: Colors.transparent,
            child: DecoratedBox(
              decoration: theme.getDecorationBalance(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: StateContainer.of(context)
                              .curPrimaryCurrency
                              .primaryCurrency
                              .name ==
                          PrimaryCurrencySetting(
                            AvailablePrimaryCurrency.native,
                          ).primaryCurrency.name
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: AutoSizeText(
                                StateContainer.of(context)
                                    .curNetwork
                                    .getNetworkCryptoCurrencyLabel(),
                                style:
                                    AppStyles.textStyleSize35W900EquinoxPrimary(
                                  context,
                                ),
                              ),
                            ),
                            if (StateContainer.of(context).showBalance)
                              _BalanceInfosNativeShowed(
                                accountSelectedBalance: accountSelectedBalance!,
                              )
                            else
                              const _BalanceInfosNotShowed()
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: AutoSizeText(
                                accountSelectedBalance!.fiatCurrencyCode!,
                                style:
                                    AppStyles.textStyleSize35W900EquinoxPrimary(
                                  context,
                                ),
                              ),
                            ),
                            if (StateContainer.of(context).showBalance)
                              _BalanceInfosNFiatShowed(
                                accountSelectedBalance: accountSelectedBalance,
                              )
                            else
                              const _BalanceInfosNotShowed()
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
      onTapDown: (details) {
        if (accountSelectedBalance!.fiatCurrencyValue! > 0) {
          showPopUpMenuAtPosition(context, details, accountSelectedBalance);
        }
      },
    );
  }

  void showPopUpMenuAtPosition(BuildContext context, TapDownDetails details,
      AccountBalance accountSelectedBalance,) {
    final theme = StateContainer.of(context).curTheme;

    showMenu(
      color: theme.backgroundDark,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20).copyWith(topRight: Radius.zero),
      ),
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: StateContainer.of(context)
                  .curPrimaryCurrency
                  .primaryCurrency
                  .name ==
              PrimaryCurrencySetting(AvailablePrimaryCurrency.native)
                  .primaryCurrency
                  .name
          ? [
              PopupMenuItem(
                value: '1',
                onTap: () {
                  copyAmount(
                    context,
                    accountSelectedBalance.nativeTokenValueToString(),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.copy,
                          size: 20,
                          color: theme.text,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          accountSelectedBalance.nativeTokenValueToString(),
                          style: AppStyles.textStyleSize12W100Primary(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: '2',
                onTap: () {
                  copyAmount(
                    context,
                    accountSelectedBalance.fiatCurrencyValue!.toString(),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.copy,
                          size: 20,
                          color: theme.text,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          accountSelectedBalance.fiatCurrencyValue!.toString(),
                          style: AppStyles.textStyleSize12W100Primary(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]
          : [
              PopupMenuItem(
                value: '2',
                onTap: () {
                  copyAmount(
                    context,
                    accountSelectedBalance.fiatCurrencyValue!.toString(),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.copy,
                          size: 20,
                          color: theme.text,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          accountSelectedBalance.fiatCurrencyValue!.toString(),
                          style: AppStyles.textStyleSize12W100Primary(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: '1',
                onTap: () {
                  copyAmount(
                    context,
                    accountSelectedBalance.nativeTokenValueToString(),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.copy,
                          size: 20,
                          color: theme.text,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          accountSelectedBalance.nativeTokenValueToString(),
                          style: AppStyles.textStyleSize12W100Primary(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
    );
  }

  void copyAmount(BuildContext context, String amount) {
    Clipboard.setData(ClipboardData(text: amount));
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;
    UIUtil.showSnackbar(
      localizations.amountCopied,
      context,
      theme.text!,
      theme.snackBarShadow!,
    );
  }
}

class _BalanceInfosNativeShowed extends StatelessWidget {
  const _BalanceInfosNativeShowed({
    required this.accountSelectedBalance,
  });
  final AccountBalance accountSelectedBalance;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AutoSizeText(
          accountSelectedBalance.nativeTokenValueToString(),
          style: AppStyles.textStyleSize25W900EquinoxPrimary(
            context,
          ),
        ),
        AutoSizeText(
          CurrencyUtil.getConvertedAmount(
            StateContainer.of(context).curCurrency.currency.name,
            accountSelectedBalance.fiatCurrencyValue!,
          ),
          textAlign: TextAlign.center,
          style: AppStyles.textStyleSize12W600Primary(
            context,
          ),
        ),
      ],
    );
  }
}

class _BalanceInfosNFiatShowed extends StatelessWidget {
  const _BalanceInfosNFiatShowed({
    required this.accountSelectedBalance,
  });
  final AccountBalance accountSelectedBalance;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AutoSizeText(
          CurrencyUtil.getConvertedAmount(
            StateContainer.of(context).curCurrency.currency.name,
            accountSelectedBalance.fiatCurrencyValue!,
          ),
          textAlign: TextAlign.center,
          style: AppStyles.textStyleSize25W900EquinoxPrimary(
            context,
          ),
        ),
        AutoSizeText(
          '${accountSelectedBalance.nativeTokenValueToString()} ${accountSelectedBalance.nativeTokenName!}',
          style: AppStyles.textStyleSize12W600Primary(
            context,
          ),
        ),
      ],
    );
  }
}

class _BalanceInfosNotShowed extends StatelessWidget {
  const _BalanceInfosNotShowed();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AutoSizeText(
          '···········',
          style: AppStyles.textStyleSize25W900EquinoxPrimary60(
            context,
          ),
        ),
        AutoSizeText(
          '···········',
          textAlign: TextAlign.center,
          style: AppStyles.textStyleSize12W600Primary60(
            context,
          ),
        ),
      ],
    );
  }
}
