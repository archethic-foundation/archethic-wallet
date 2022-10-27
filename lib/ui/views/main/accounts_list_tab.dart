// Flutter imports:
// Project imports:
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/ui/views/accounts/account_list.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AccountsListTab extends ConsumerStatefulWidget {
  const AccountsListTab({super.key});

  @override
  ConsumerState<AccountsListTab> createState() => _AccountsListTabState();
}

class _AccountsListTabState extends ConsumerState<AccountsListTab> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final preferences = ref.watch(SettingsProviders.settings);
    return Column(
      children: [
        Expanded(
          /// REFRESH
          child: RefreshIndicator(
            backgroundColor: theme.backgroundDark,
            onRefresh: () => Future<void>.sync(() async {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    preferences.activeVibrations,
                  );
              await ref.read(SessionProviders.session.notifier).refresh();
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
                          theme.background1Small!,
                        ),
                        fit: BoxFit.fitHeight,
                        opacity: 0.7,
                      ),
                    ),
                    child: Scrollbar(
                      controller: scrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: kToolbarHeight + kTextTabBarHeight,
                            bottom: 50,
                          ),
                          child: Column(
                            children: <Widget>[
                              /// ACCOUNTS LIST
                              AccountsListWidget(
                                currencyName: currency.currency.name,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
