import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/ui/views/accounts/layouts/account_list.dart';
import 'package:aewallet/ui/views/accounts/layouts/components/add_account_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeychainTab extends ConsumerWidget {
  const KeychainTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsList =
        ref.watch(AccountProviders.sortedAccounts).valueOrNull ?? [];

    return SingleChildScrollView(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  children: <Widget>[
                    AccountsListWidget(
                      currencyName: AvailableCurrencyEnum.usd.name,
                      accountsList: accountsList,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 10,
                  ),
                  child: const Row(
                    children: [
                      AddAccountButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
