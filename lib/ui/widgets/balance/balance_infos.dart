/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/price_history/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/chart_option_label.dart';
import 'package:aewallet/ui/widgets/balance/components/price_evolution_indicator.dart';
import 'package:aewallet/ui/widgets/components/history_chart.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'components/balance_infos_build_chart.dart';
part 'components/balance_infos_build_kpi.dart';

class BalanceInfos extends ConsumerWidget {
  const BalanceInfos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelectedBalance = ref
        .watch(
          AccountProviders.accounts,
        )
        .value
        ?.selectedAccount
        ?.balance;

    if (accountSelectedBalance == null) return const SizedBox();

    final preferences = ref.watch(SettingsProviders.settings);
    return SizedBox(
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: preferences.showBalances == true
              ? _BalanceTotalUSDShowed(
                  accountSelectedBalance: accountSelectedBalance,
                )
              : const _BalanceTotalUSDNotShowed(),
        ),
      ),
    );
  }
}

class _BalanceTotalUSDShowed extends ConsumerWidget {
  const _BalanceTotalUSDShowed({
    required this.accountSelectedBalance,
  });
  final AccountBalance accountSelectedBalance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          '\$${accountSelectedBalance.totalUSD.formatNumber(precision: 2)}',
          textAlign: TextAlign.center,
          style: ArchethicThemeStyles.textStyleSize35W900Primary,
        ),
      ],
    );
  }
}

class _BalanceTotalUSDNotShowed extends ConsumerWidget {
  const _BalanceTotalUSDNotShowed();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          '···········',
          textAlign: TextAlign.center,
          style: ArchethicThemeStyles.textStyleSize35W900Primary,
        ),
      ],
    );
  }
}
