import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/verified_tokens.dart';
import 'package:aewallet/ui/views/main/bloc/nft_search_bar_provider.dart';
import 'package:aewallet/ui/views/main/bloc/nft_search_bar_state.dart';
import 'package:aewallet/ui/views/main/components/app_update_button.dart';
import 'package:aewallet/ui/views/main/components/menu_widget_wallet.dart';
import 'package:aewallet/ui/views/main/components/nft_search_bar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_list.dart';
import 'package:aewallet/ui/views/tokens_list/layouts/tokens_list_sheet.dart';
import 'package:aewallet/ui/widgets/balance/balance_infos.dart';
import 'package:aewallet/ui/widgets/components/refresh_indicator.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/universal_platform.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AccountTab extends ConsumerWidget {
  const AccountTab({super.key});

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
        await ref
            .read(
              VerifiedTokensProviders.verifiedTokens.notifier,
            )
            .init();
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
          child: Stack(
            children: [
              Padding(
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
                            ExpandablePageView(
                              children: [
                                const TokensList(),
                                Column(
                                  children: [
                                    ProviderScope(
                                      overrides: [
                                        NftSearchBarProvider.initialNftSearchBar
                                            .overrideWithValue(
                                          const NftSearchBarState(),
                                        ),
                                      ],
                                      child: const NFTSearchBar(),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const NFTList(),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (UniversalPlatform.isMobile) const AppUpdateButton(),
            ],
          ),
        ),
      ),
    );
  }
}
