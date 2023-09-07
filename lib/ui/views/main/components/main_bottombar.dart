/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/domain/repositories/features_flags.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainBottomBar extends ConsumerWidget {
  const MainBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final bottomBarCurrentPage = ref.watch(
      SettingsProviders.settings.select(
        (settings) => settings.mainScreenCurrentPage,
      ),
    );

    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 22),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: BottomBar(
            selectedIndex: bottomBarCurrentPage,
            onTap: ref
                .read(SettingsProviders.settings.notifier)
                .setMainScreenCurrentPage,
            items: <BottomBarItem>[
              BottomBarItem(
                key: const Key('bottomBarAddressBook'),
                icon: const Icon(
                  Icons.contacts_outlined,
                  size: 28,
                ),
                backgroundColorOpacity: theme.bottomBarBackgroundColorOpacity!,
                activeIconColor: theme.bottomBarActiveIconColor,
                activeTitleColor: theme.bottomBarActiveTitleColor,
                activeColor: theme.bottomBarActiveColor!,
                inactiveColor: theme.bottomBarInactiveIcon,
              ),
              BottomBarItem(
                key: const Key('bottomBarKeyChain'),
                icon: const Icon(
                  Icons.wallet_outlined,
                  size: 28,
                ),
                backgroundColorOpacity: theme.bottomBarBackgroundColorOpacity!,
                activeIconColor: theme.bottomBarActiveIconColor,
                activeTitleColor: theme.bottomBarActiveTitleColor,
                activeColor: theme.bottomBarActiveColor!,
                inactiveColor: theme.bottomBarInactiveIcon,
              ),
              BottomBarItem(
                key: const Key('bottomBarMain'),
                icon: const Icon(
                  Icons.account_circle_outlined,
                  size: 28,
                ),
                backgroundColorOpacity: theme.bottomBarBackgroundColorOpacity!,
                activeIconColor: theme.bottomBarActiveIconColor,
                activeTitleColor: theme.bottomBarActiveTitleColor,
                activeColor: theme.bottomBarActiveColor!,
                inactiveColor: theme.bottomBarInactiveIcon,
              ),
              BottomBarItem(
                key: const Key('bottomBarNFT'),
                icon: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.bottomBarActiveTitleColor!,
                      width: 2.2,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'NFT',
                        style: theme.textStyleSize10W600Primary,
                      ),
                    ],
                  ),
                ),
                backgroundColorOpacity: theme.bottomBarBackgroundColorOpacity!,
                activeIconColor: theme.bottomBarActiveIconColor,
                activeTitleColor: theme.bottomBarActiveTitleColor,
                activeColor: theme.bottomBarActiveColor!,
                inactiveColor: theme.bottomBarInactiveIcon,
              ),
              if (FeatureFlags.messagingActive)
                BottomBarItem(
                  key: const Key('bottomBarMessenger'),
                  icon: const Icon(
                    Icons.chat_outlined,
                    size: 28,
                  ),
                  backgroundColorOpacity:
                      theme.bottomBarBackgroundColorOpacity!,
                  activeIconColor: theme.bottomBarActiveIconColor,
                  activeTitleColor: theme.bottomBarActiveTitleColor,
                  activeColor: theme.bottomBarActiveColor!,
                  inactiveColor: theme.bottomBarInactiveIcon,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
