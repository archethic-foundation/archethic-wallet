import 'dart:async';
import 'dart:ui';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/ui/views/accounts/layouts/components/account_list_item.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/widgets/components/refresh_indicator.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';

class AccountsListWidget extends ConsumerWidget {
  const AccountsListWidget({
    super.key,
    this.currencyName,
    required this.accountsList,
  });
  final String? currencyName;
  final List<Account> accountsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(SettingsProviders.settings);

    return Expanded(
      child: ArchethicRefreshIndicator(
        onRefresh: () => Future<void>.sync(() async {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                settings.activeVibrations,
              );

          final connectivityStatusProvider =
              ref.read(connectivityStatusProviders);
          if (connectivityStatusProvider == ConnectivityStatus.isDisconnected) {
            return;
          }
          ShowSendingAnimation.build(context);
          await ref.read(SessionProviders.session.notifier).refresh();
          await ref
              .read(AccountProviders.selectedAccount.notifier)
              .refreshRecentTransactions();
          if (context.canPop()) context.pop();
          context.go(HomePage.routerPage);
        }),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            },
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                bottom: MediaQuery.of(context).padding.bottom + 40,
              ),
              itemCount: accountsList.length,
              itemBuilder: (BuildContext context, int index) {
                Widget item = AccountListItem(
                  account: accountsList[index],
                );

                if (!kIsWeb) {
                  item = item
                      .animate(delay: (100 * index).ms)
                      .fadeIn(duration: 900.ms, delay: 200.ms)
                      .shimmer(
                        blendMode: BlendMode.srcOver,
                        color: Colors.white12,
                      )
                      .move(
                        begin: const Offset(-16, 0),
                        curve: Curves.easeOutQuad,
                      );
                }
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: item,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
