// Flutter imports:
// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/ui/menu/menu_widget_wallet.dart';
import 'package:aewallet/ui/views/blog/last_articles_list.dart';
import 'package:aewallet/ui/views/home_page_universe.dart';
import 'package:aewallet/ui/views/tokens_fungibles/fungibles_tokens_list.dart';
import 'package:aewallet/ui/views/transactions/transaction_recent_list.dart';
import 'package:aewallet/ui/widgets/balance_infos.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          /// REFRESH
          child: RefreshIndicator(
            backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
            onRefresh: () => Future<void>.sync(() {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    StateContainer.of(context).activeVibrations,
                  );
              StateContainer.of(context).requestUpdate();
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
                          StateContainer.of(context).curTheme.background2Small!,
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
                            BalanceInfosWidget().getBalance(context),
                            const SizedBox(
                              height: 10,
                            ),

                            /// PRICE CHART
                            if (StateContainer.of(context).showPriceChart) Stack(
                                    children: <Widget>[
                                      BalanceInfosWidget().buildInfos(context),
                                    ],
                                  ) else const SizedBox(),

                            /// KPI
                            if (StateContainer.of(context).showPriceChart) BalanceInfosWidget().buildKPI(context) else const SizedBox(),

                            Divider(
                              height: 1,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .backgroundDarkest!
                                  .withOpacity(0.1),
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
                              color: StateContainer.of(context)
                                  .curTheme
                                  .backgroundDarkest!
                                  .withOpacity(0.1),
                            ),
                            const ExpandablePageView(
                              children: [
                                TxListWidget(),
                                FungiblesTokensListWidget(),
                              ],
                            ),

                            /// BLOG
                            const LastArticlesWidget(),
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
