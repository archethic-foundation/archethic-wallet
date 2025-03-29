/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/refresh_in_progress.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/settings.dart';
import 'package:aewallet/modules/aeswap/application/session/provider.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/ui/menu/settings/settings_sheet.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_icon_refresh.dart';
import 'package:aewallet/ui/views/main/components/app_update_button.dart';
import 'package:aewallet/ui/views/main/components/main_appbar_account.dart';
import 'package:aewallet/ui/views/main/components/main_appbar_basic.dart';
import 'package:aewallet/ui/views/main/components/main_appbar_transactions.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/util/universal_platform.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);

    final tab = preferences.mainScreenTab;
    return switch (tab) {
      MainScreenTab.accountTab => MainAppBarDetail(
          key: const Key('account'),
          actions: [
            if (UniversalPlatform.isMobile) const AppUpdateButton(),
            const _RefreshButton(),
          ],
          title: const MainAppBarAccount(),
        ),
      MainScreenTab.transactionTab => const MainAppBarDetail(
          key: Key('transaction'),
          actions: [
            _RefreshButton(),
          ],
          title: MainAppBarTransactions(),
        ),
      MainScreenTab.swapTab => MainAppBarDetail(
          key: const Key('swap'),
          actions: const [
            SwapTokenIconRefresh(),
          ],
          title: MainAppBarBasic(header: localizations.swapHeader),
        ),
      MainScreenTab.earnTab => MainAppBarDetail(
          key: const Key('earn'),
          actions: const [
            _RefreshButton(),
          ],
          title: MainAppBarBasic(header: localizations.aeSwapEarnHeader),
        ),
    };
  }
}

class _RefreshButton extends ConsumerWidget {
  const _RefreshButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    if (connectivityStatusProvider == ConnectivityStatus.isDisconnected) {
      return const SizedBox.shrink();
    }

    final refreshInProgress = ref.watch(refreshInProgressNotifierProvider);
    return refreshInProgress == false
        ? IconButton(
            icon: const Icon(
              aedappfm.Iconsax.refresh,
              size: 16,
              color: Colors.white,
            ),
            onPressed: () async {
              final _connectivityStatusProvider =
                  ref.read(connectivityStatusProviders);
              if (_connectivityStatusProvider ==
                  ConnectivityStatus.isDisconnected) {
                return;
              }

              await (await ref
                      .read(accountsNotifierProvider.notifier)
                      .selectedAccountNotifier)
                  ?.refreshAll();
            },
          )
        : const Padding(
            padding: EdgeInsets.only(left: 10, right: 12),
            child: SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          );
  }
}

class MainAppBarDetail extends ConsumerWidget {
  const MainAppBarDetail({
    super.key,
    required this.actions,
    required this.title,
  });

  final List<Widget> actions;
  final Widget title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    final environment = ref.watch(environmentProvider);

    return AppBar(
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
      systemOverlayStyle: ArchethicTheme.brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      automaticallyImplyLeading: false,
      leading: const _MenuButton(),
      actions: [
        ...actions,
        if (connectivityStatusProvider == ConnectivityStatus.isDisconnected)
          const IconNetworkWarning(),
      ],
      title: Column(
        children: [
          title,
          if (environment != aedappfm.Environment.mainnet)
            Text(
              environment.label,
              style: AppTextStyles.bodySmallSecondaryColor(context),
            ),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: ArchethicTheme.text),
    );
  }
}

class _MenuButton extends ConsumerWidget {
  const _MenuButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) => IconButton(
        icon: const Icon(
          Symbols.menu,
          weight: IconSize.weightM,
          opticalSize: IconSize.opticalSizeM,
          grade: IconSize.gradeM,
        ),
        onPressed: () {
          context.push(SettingsSheetWallet.routerPage);
        },
      );
}
