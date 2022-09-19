// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/ui/views/accounts/account_list.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/keychain_util.dart';

class AccountsListTab extends StatelessWidget {
  const AccountsListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          /// REFRESH
          child: RefreshIndicator(
            backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
            onRefresh: () => Future<void>.sync(() async {
              sl.get<HapticUtil>().feedback(FeedbackType.light,
                  StateContainer.of(context).activeVibrations);
              StateContainer.of(context).appWallet = await KeychainUtil()
                  .getListAccountsFromKeychain(
                      StateContainer.of(context).appWallet,
                      await StateContainer.of(context).getSeed(),
                      StateContainer.of(context).curCurrency.currency.name,
                      StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .balance!
                          .nativeTokenName!,
                      StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .balance!
                          .tokenPrice!,
                      currentName: StateContainer.of(context)
                          .appWallet!
                          .appKeychain!
                          .getAccountSelected()!
                          .name);
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
                          image: AssetImage(StateContainer.of(context)
                              .curTheme
                              .background1Small!),
                          fit: BoxFit.fitHeight,
                          opacity: 0.7),
                    ),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: kToolbarHeight + kTextTabBarHeight,
                            bottom: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            /// ACCOUNTS LIST
                            AccountsListWidget(
                              appWallet: StateContainer.of(context).appWallet,
                              currencyName: StateContainer.of(context)
                                  .curCurrency
                                  .currency
                                  .name,
                            )
                          ],
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
