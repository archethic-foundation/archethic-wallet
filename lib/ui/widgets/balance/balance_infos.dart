/// SPDX-License-Identifier: AGPL-3.0-or-later

// Project imports:
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/theme.dart';
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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'components/balance_infos_build_chart.dart';
part 'components/balance_infos_build_kpi.dart';

class BalanceInfos extends ConsumerWidget {
  const BalanceInfos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.theme);
    final accountSelectedBalance = StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance;

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
                  child: StateContainer.of(context).curPrimaryCurrency.primaryCurrency.name ==
                          const PrimaryCurrencySetting(
                            AvailablePrimaryCurrency.native,
                          ).primaryCurrency.name
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: AutoSizeText(
                                StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel(),
                                style: theme.textStyleSize35W900EquinoxPrimary,
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
                                style: theme.textStyleSize35W900EquinoxPrimary,
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
          showPopUpMenuAtPosition(
            context,
            ref,
            details,
            accountSelectedBalance,
          );
        }
      },
    );
  }

  // TODO(Chralu): Extract to [Widget] subclass
  void showPopUpMenuAtPosition(
    BuildContext context,
    WidgetRef ref,
    TapDownDetails details,
    AccountBalance accountSelectedBalance,
  ) {
    final theme = ref.watch(ThemeProviders.theme);

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
      items: StateContainer.of(context).curPrimaryCurrency.primaryCurrency.name ==
              const PrimaryCurrencySetting(AvailablePrimaryCurrency.native).primaryCurrency.name
          ? [
              PopupMenuItem(
                value: '1',
                onTap: () {
                  copyAmount(
                    context,
                    ref,
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
                          style: theme.textStyleSize12W100Primary,
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
                    ref,
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
                          style: theme.textStyleSize12W100Primary,
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
                    ref,
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
                          style: theme.textStyleSize12W100Primary,
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
                    ref,
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
                          style: theme.textStyleSize12W100Primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
    );
  }

  void copyAmount(BuildContext context, WidgetRef ref, String amount) {
    Clipboard.setData(ClipboardData(text: amount));
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.theme);
    UIUtil.showSnackbar(
      localizations.amountCopied,
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
    );
  }
}

class _BalanceInfosNativeShowed extends ConsumerWidget {
  const _BalanceInfosNativeShowed({
    required this.accountSelectedBalance,
  });
  final AccountBalance accountSelectedBalance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.theme);
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AutoSizeText(
          accountSelectedBalance.nativeTokenValueToString(),
          style: theme.textStyleSize25W900EquinoxPrimary,
        ),
        AutoSizeText(
          CurrencyUtil.getConvertedAmount(
            currency.currency.name,
            accountSelectedBalance.fiatCurrencyValue!,
          ),
          textAlign: TextAlign.center,
          style: theme.textStyleSize12W600Primary,
        ),
      ],
    );
  }
}

class _BalanceInfosNFiatShowed extends ConsumerWidget {
  const _BalanceInfosNFiatShowed({
    required this.accountSelectedBalance,
  });
  final AccountBalance accountSelectedBalance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.theme);
    final currency = ref.watch(CurrencyProviders.selectedCurrency);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AutoSizeText(
          CurrencyUtil.getConvertedAmount(
            currency.currency.name,
            accountSelectedBalance.fiatCurrencyValue!,
          ),
          textAlign: TextAlign.center,
          style: theme.textStyleSize25W900EquinoxPrimary,
        ),
        AutoSizeText(
          '${accountSelectedBalance.nativeTokenValueToString()} ${accountSelectedBalance.nativeTokenName!}',
          style: theme.textStyleSize12W600Primary,
        ),
      ],
    );
  }
}

class _BalanceInfosNotShowed extends ConsumerWidget {
  const _BalanceInfosNotShowed();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.theme);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AutoSizeText(
          '···········',
          style: theme.textStyleSize25W900EquinoxPrimary60,
        ),
        AutoSizeText(
          '···········',
          textAlign: TextAlign.center,
          style: theme.textStyleSize12W600Primary60,
        ),
      ],
    );
  }
}
