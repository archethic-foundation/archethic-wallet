import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/views/accounts/layouts/account_list.dart';
import 'package:aewallet/ui/views/accounts/layouts/components/add_account_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeychainTab extends ConsumerWidget {
  const KeychainTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final settings = ref.watch(SettingsProviders.settings);
    final accountsList =
        ref.watch(AccountProviders.sortedAccounts).valueOrNull ?? [];

    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
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
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 10,
          bottom: 80,
          left: 15,
          right: 15,
        ),
        child: Column(
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: Column(
                  children: <Widget>[
                    AccountsListWidget(
                      currencyName: settings.currency.name,
                      accountsList: accountsList,
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: const [
                AddAccountButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
