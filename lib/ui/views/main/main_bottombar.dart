/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

// Project imports:
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
// Package imports:
import 'package:bottom_bar/bottom_bar.dart';
// Flutter imports:
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
                icon: const Icon(
                  UiIcons.keychain,
                  size: 30,
                ),
                backgroundColorOpacity: theme.bottomBarBackgroundColorOpacity!,
                activeIconColor: theme.bottomBarActiveIconColor,
                activeTitleColor: theme.bottomBarActiveTitleColor,
                activeColor: theme.bottomBarActiveColor!,
                inactiveColor: theme.bottomBarInactiveIcon,
              ),
              BottomBarItem(
                icon: const Icon(
                  UiIcons.main,
                  size: 30,
                ),
                backgroundColorOpacity: theme.bottomBarBackgroundColorOpacity!,
                activeIconColor: theme.bottomBarActiveIconColor,
                activeTitleColor: theme.bottomBarActiveTitleColor,
                activeColor: theme.bottomBarActiveColor!,
                inactiveColor: theme.bottomBarInactiveIcon,
              ),
              BottomBarItem(
                icon: const Icon(
                  UiIcons.nft,
                  size: 30,
                ),
                backgroundColorOpacity: theme.bottomBarBackgroundColorOpacity!,
                activeIconColor: theme.bottomBarActiveIconColor,
                activeTitleColor: theme.bottomBarActiveTitleColor,
                activeColor: theme.bottomBarActiveColor!,
                inactiveColor: theme.bottomBarInactiveIcon,
              ),
              BottomBarItem(
                icon: const Icon(
                  UiIcons.address_book_menu,
                  size: 30,
                ),
                backgroundColorOpacity: theme.bottomBarBackgroundColorOpacity!,
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
