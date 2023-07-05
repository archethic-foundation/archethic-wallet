import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/ui/views/accounts/layouts/components/account_list_item.dart';
import 'package:aewallet/ui/widgets/components/refresh_indicator.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

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
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Expanded(
      child: ArchethicRefreshIndicator(
        onRefresh: () => Future<void>.sync(() async {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                settings.activeVibrations,
              );
          ShowSendingAnimation.build(context, theme);
          final connectivityStatusProvider =
              ref.read(connectivityStatusProviders);
          if (connectivityStatusProvider == ConnectivityStatus.isDisconnected) {
            return;
          }

          await ref.read(SessionProviders.session.notifier).refresh();
          await ref
              .read(AccountProviders.selectedAccount.notifier)
              .refreshRecentTransactions();

          Navigator.of(context).pop();
        }),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            },
          ),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 15,
            ),
            itemCount: accountsList.length,
            itemBuilder: (BuildContext context, int index) {
              return AccountListItem(
                account: accountsList[index],
              )
                  .animate(delay: (100 * index).ms)
                  .fadeIn(duration: 900.ms, delay: 200.ms)
                  .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
                  .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad);
            },
          ),
        ),
      ),
    );
  }
}
