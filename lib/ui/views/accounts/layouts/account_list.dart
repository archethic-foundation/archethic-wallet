import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/ui/views/accounts/layouts/components/account_list_item.dart';
import 'package:aewallet/ui/widgets/components/refresh_indicator.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

    return Expanded(
      child: ArchethicRefreshIndicator(
        onRefresh: () => Future<void>.sync(() async {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                settings.activeVibrations,
              );
          await ref.read(SessionProviders.session.notifier).refresh();
          await ref
              .read(AccountProviders.selectedAccount.notifier)
              .refreshRecentTransactions();
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
              // Build contact
              return AccountListItem(
                account: accountsList[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
