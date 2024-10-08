/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/main/components/menu_widget_wallet.dart';
import 'package:aewallet/ui/views/transactions/transactions_list.dart';
import 'package:aewallet/ui/widgets/balance/balance_infos.dart';
import 'package:aewallet/ui/widgets/components/refresh_indicator.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransactionsTab extends ConsumerWidget {
  const TransactionsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentTransactions = ref.watch(
      AccountProviders.accounts.select(
        (accounts) => accounts.valueOrNull?.selectedAccount?.recentTransactions,
      ),
    );

    return SingleChildScrollView(
      child: Column(
        key: const Key('recentTransactions'),
        children: [
          if (recentTransactions != null)
            _TransactionsList(recentTransactions: recentTransactions),
        ],
      ),
    );
  }
}

class _TransactionsList extends ConsumerWidget {
  const _TransactionsList({
    required this.recentTransactions,
  });

  final List<RecentTransaction> recentTransactions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);

    return ArchethicRefreshIndicator(
      onRefresh: () => Future<void>.sync(() async {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );

        final _connectivityStatusProvider =
            ref.read(connectivityStatusProviders);
        if (_connectivityStatusProvider == ConnectivityStatus.isDisconnected) {
          return;
        }

        await (await ref
                .read(AccountProviders.accounts.notifier)
                .selectedAccountNotifier)
            ?.refreshRecentTransactions();
        ref
          ..invalidate(ContactProviders.fetchContacts)
          ..invalidate(MarketPriceProviders.currencyMarketPrice);
        final env =
            ref.read(SettingsProviders.settings).network.getNetworkLabel();
        await ref
            .read(
              aedappfm.VerifiedTokensProviders.verifiedTokens.notifier,
            )
            .init(env);
      }),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                ArchethicScrollbar(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 10,
                      bottom: 80,
                    ),
                    child: Column(
                      children: <Widget>[
                        const BalanceInfos(),
                        const SizedBox(
                          height: 10,
                        ),
                        const MenuWidgetWallet(),
                        if (recentTransactions.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: ArchethicTheme
                                      .backgroundFungiblesTokensListCard,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                              color: ArchethicTheme
                                  .backgroundFungiblesTokensListCard,
                              child: Container(
                                padding: const EdgeInsets.all(9.5),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Symbols.info,
                                      size: 18,
                                      weight: IconSize.weightM,
                                      opticalSize: IconSize.opticalSizeM,
                                      grade: IconSize.gradeM,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .recentTransactionsNoTransactionYet,
                                      style: ArchethicThemeStyles
                                          .textStyleSize12W100Primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        else
                          TransactionsList(
                            transactionsList: recentTransactions,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
