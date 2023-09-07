/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/nft/nft_category.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/messenger/layouts/create_discussion_sheet.dart';
import 'package:aewallet/ui/views/nft/layouts/configure_category_list.dart';
import 'package:aewallet/ui/widgets/components/icon_network_warning.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final hasNotifications =
        ref.watch(DeviceAbilities.hasNotificationsProvider);
    final keychain = ref.watch(
      SessionProviders.session.select(
        (value) => value.loggedIn?.wallet.appKeychain,
      ),
    );
    final selectedAccount = ref
        .watch(
          AccountProviders.selectedAccount,
        )
        .valueOrNull;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 50),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AppBar(
            systemOverlayStyle: theme.brightness == Brightness.light
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.menu_outlined),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
            actions: [
              if (preferences.mainScreenCurrentPage == 3)
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () async {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );
                    Sheets.showAppHeightNineSheet(
                      context: context,
                      ref: ref,
                      widget: const ConfigureCategoryList(),
                      onDisposed: () => ref
                          .invalidate(NftCategoryProviders.fetchNftCategories),
                    );
                  },
                ),
              if (preferences.mainScreenCurrentPage == 4)
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline),
                  onPressed: () async {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );
                    Sheets.showAppHeightNineSheet(
                      context: context,
                      ref: ref,
                      widget: const CreateDiscussionSheet(),
                    );
                  },
                )
              else if (preferences.mainScreenCurrentPage == 1 ||
                  preferences.mainScreenCurrentPage == 2)
                preferences.showBalances
                    ? const MainAppBarIconBalanceShowed()
                    : const MainAppBarIconBalanceNotShowed(),
              if (connectivityStatusProvider ==
                  ConnectivityStatus.isDisconnected)
                const IconNetworkWarning()
              else if (hasNotifications)
                preferences.activeNotifications
                    ? const MainAppBarIconNotificationEnabled()
                    : const MainAppBarIconNotificationDisabled(),
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
                        theme.text!,
                        theme.snackBarShadow!,
                      );
                    },
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: AutoSizeText(
                        localizations.keychainHeader,
                        style: theme.textStyleSize24W700EquinoxPrimary,
                      ),
                    )
                        .animate()
                        .fade(duration: const Duration(milliseconds: 300)),
                  )
                : preferences.mainScreenCurrentPage == 2
                    ? FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          selectedAccount?.nameDisplayed ?? ' ',
                          style: theme.textStyleSize24W700EquinoxPrimary,
                        ),
                      )
                        .animate()
                        .fade(duration: const Duration(milliseconds: 300))
                    : preferences.mainScreenCurrentPage == 3
                        ? FittedBox(
                            fit: BoxFit.fitWidth,
                            child: AutoSizeText(
                              'NFT',
                              style: theme.textStyleSize24W700EquinoxPrimary,
                            ),
                          )
                            .animate()
                            .fade(duration: const Duration(milliseconds: 300))
                        : preferences.mainScreenCurrentPage == 4
                            ? FittedBox(
                                fit: BoxFit.fitWidth,
                                child: AutoSizeText(
                                  localizations.messengerHeader,
                                  style:
                                      theme.textStyleSize24W700EquinoxPrimary,
                                ),
                              ).animate().fade(
                                  duration: const Duration(milliseconds: 300),
                                )
                            : FittedBox(
                                fit: BoxFit.fitWidth,
                                child: AutoSizeText(
                                  localizations.addressBookHeader,
                                  style:
                                      theme.textStyleSize24W700EquinoxPrimary,
                                ),
                              ).animate().fade(
                                  duration: const Duration(milliseconds: 300),
                                ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: theme.text),
          ),
        ),
      ),
    );
  }
}

class MainAppBarIconBalanceShowed extends ConsumerWidget {
  const MainAppBarIconBalanceShowed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);

    return IconButton(
      icon: const Icon(Icons.visibility_outlined),
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
      icon: const Icon(Icons.visibility_off_outlined),
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

class MainAppBarIconNotificationEnabled extends ConsumerWidget {
  const MainAppBarIconNotificationEnabled({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);
    return IconButton(
      icon: const Icon(Icons.notifications_outlined),
      onPressed: () async {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );
        final preferencesNotifier = ref.read(
          SettingsProviders.settings.notifier,
        );
        await preferencesNotifier.setActiveNotifications(false);
      },
    );
  }
}

class MainAppBarIconNotificationDisabled extends ConsumerWidget {
  const MainAppBarIconNotificationDisabled({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);
    return IconButton(
      icon: const Icon(Icons.notifications_off_outlined),
      onPressed: () async {
        sl.get<HapticUtil>().feedback(
              FeedbackType.light,
              preferences.activeVibrations,
            );

        final preferencesNotifier =
            ref.read(SettingsProviders.settings.notifier);
        await preferencesNotifier.setActiveNotifications(true);
      },
    );
  }
}
