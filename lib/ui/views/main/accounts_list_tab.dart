// Flutter imports:
// Project imports:
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/ui/views/accounts/account_list.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AccountsListTab extends ConsumerWidget {
  const AccountsListTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!;
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
              StateContainer.of(context).appWallet =
                  await KeychainUtil().getListAccountsFromKeychain(
                StateContainer.of(context).appWallet,
                await StateContainer.of(context).getSeed(),
                currency.currency.name,
                accountSelected.balance!.nativeTokenName!,
                accountSelected.balance!.tokenPrice!,
                currentName: accountSelected.name,
              );
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
                      thumbVisibility: true,
                      child: SingleChildScrollView(
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
                                appWallet: StateContainer.of(context).appWallet,
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
