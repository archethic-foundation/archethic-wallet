import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/blog.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/views/blog/last_articles_list.dart';
import 'package:aewallet/ui/views/home_page.dart';
import 'package:aewallet/ui/views/main/menu_widget_wallet.dart';
import 'package:aewallet/ui/views/tokens_fungibles/layouts/fungibles_tokens_list.dart';
import 'package:aewallet/ui/views/transactions/transaction_recent_list.dart';
import 'package:aewallet/ui/widgets/balance/balance_infos.dart';
import 'package:aewallet/ui/widgets/components/refresh_indicator.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AccountTab extends ConsumerWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);

    return Column(
      children: [
        Expanded(
          /// REFRESH
          child: ArchethicRefreshIndicator(
            onRefresh: () => Future<void>.sync(() async {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    preferences.activeVibrations,
                  );
              await ref
                  .read(AccountProviders.selectedAccount.notifier)
                  .refreshRecentTransactions();
              ref
                ..invalidate(BlogProviders.fetchArticles)
                ..invalidate(ContactProviders.fetchContacts)
                ..invalidate(MarketPriceProviders.currencyMarketPrice);
            }),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: Column(
                children: <Widget>[
                  /// BACKGROUND IMAGE
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          theme.background2Small!,
                        ),
                        fit: BoxFit.fitHeight,
                        opacity: 0.7,
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: kToolbarHeight + kTextTabBarHeight,
                          bottom: 50,
                        ),
                        child: Column(
                          children: <Widget>[
                            /// BALANCE
                            const BalanceInfos(),
                            const SizedBox(
                              height: 10,
                            ),

                            /// PRICE CHART
                            if (preferences.showPriceChart)
                              Stack(
                                children: const <Widget>[
                                  BalanceInfosChart(),
                                ],
                              )
                            else
                              const SizedBox(),

                            /// KPI
                            if (preferences.showPriceChart)
                              const BalanceInfosKpi()
                            else
                              const SizedBox(),

                            Divider(
                              height: 1,
                              color: theme.backgroundDarkest!.withOpacity(0.1),
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            /// ICONS
                            const MenuWidgetWallet(),
                            const SizedBox(
                              height: 15,
                            ),
                            Divider(
                              height: 1,
                              color: theme.backgroundDarkest!.withOpacity(0.1),
                            ),
                            const ExpandablePageView(
                              children: [
                                TxList(),
                                FungiblesTokensListWidget(),
                              ],
                            ),

                            /// BLOG
                            const LastArticles(),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
