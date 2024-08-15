/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/menu/settings/settings_sheet.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
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
    final keychain = ref.watch(
      sessionNotifierProvider.select(
        (value) => value.loggedIn?.wallet.appKeychain,
      ),
    );
    final selectedAccount = ref
        .watch(
          AccountProviders.accounts,
        )
        .valueOrNull
        ?.selectedAccount;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

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
      leading: Padding(
        padding: const EdgeInsets.only(left: 3),
        child: IconButton(
          icon: const Icon(
            Symbols.menu,
            weight: IconSize.weightM,
            opticalSize: IconSize.opticalSizeM,
            grade: IconSize.gradeM,
          ),
          onPressed: () {
            context.go(SettingsSheetWallet.routerPage);
          },
        ),
      ),
      actions: [
        if (preferences.mainScreenCurrentPage == 0 ||
            preferences.mainScreenCurrentPage == 1 ||
            preferences.mainScreenCurrentPage == 2)
          preferences.showBalances
              ? const MainAppBarIconBalanceShowed()
              : const MainAppBarIconBalanceNotShowed(),
        if (connectivityStatusProvider == ConnectivityStatus.isDisconnected)
          const IconNetworkWarning(),
      ],
      title: preferences.mainScreenCurrentPage == 1
          ? InkWell(
              onTap: () {
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      preferences.activeVibrations,
                    );
                Clipboard.setData(
                  ClipboardData(
                    text: keychain?.address.toUpperCase() ?? '',
                  ),
                );
                UIUtil.showSnackbar(
                  localizations.addressCopied,
                  context,
                  ref,
                  ArchethicTheme.text,
                  ArchethicTheme.snackBarShadow,
                  icon: Symbols.info,
                );
              },
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: AutoSizeText(
                  localizations.keychainHeader,
                  style: ArchethicThemeStyles.textStyleSize24W700Primary,
                ),
              ).animate().fade(duration: const Duration(milliseconds: 300)),
            )
          : preferences.mainScreenCurrentPage == 2
              ? FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    selectedAccount?.nameDisplayed ?? ' ',
                    style: ArchethicThemeStyles.textStyleSize24W700Primary,
                  ),
                ).animate().fade(duration: const Duration(milliseconds: 300))
              : preferences.mainScreenCurrentPage == 3
                  ? FittedBox(
                      fit: BoxFit.fitWidth,
                      child: AutoSizeText(
                        localizations.dAppsHeader,
                        style: ArchethicThemeStyles.textStyleSize24W700Primary,
                      ),
                    )
                      .animate()
                      .fade(duration: const Duration(milliseconds: 300))
                  : FittedBox(
                      fit: BoxFit.fitWidth,
                      child: AutoSizeText(
                        localizations.addressBookHeader,
                        style: ArchethicThemeStyles.textStyleSize24W700Primary,
                      ),
                    ).animate().fade(
                        duration: const Duration(milliseconds: 300),
                      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: ArchethicTheme.text),
    );
  }
}

class MainAppBarIconBalanceShowed extends ConsumerWidget {
  const MainAppBarIconBalanceShowed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);

    return IconButton(
      icon: const Icon(
        Symbols.visibility,
        weight: IconSize.weightM,
        opticalSize: IconSize.opticalSizeM,
        grade: IconSize.gradeM,
      ),
      onPressed: () async {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );
        final preferencesNotifier =
            ref.read(SettingsProviders.settings.notifier);
        await preferencesNotifier.setShowBalances(false);
      },
    );
  }
}

class MainAppBarIconBalanceNotShowed extends ConsumerWidget {
  const MainAppBarIconBalanceNotShowed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);

    return IconButton(
      icon: const Icon(
        Symbols.visibility_off,
        weight: IconSize.weightM,
        opticalSize: IconSize.opticalSizeM,
        grade: IconSize.gradeM,
      ),
      onPressed: () async {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );
        final preferencesNotifier =
            ref.read(SettingsProviders.settings.notifier);
        await preferencesNotifier.setShowBalances(true);
      },
    );
  }
}
