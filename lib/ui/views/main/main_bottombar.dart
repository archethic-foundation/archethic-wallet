/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/util/preferences.dart';
// Package imports:
import 'package:bottom_bar/bottom_bar.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainBottomBar extends StatelessWidget {
  const MainBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = StateContainer.of(context).curTheme;

    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 22),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: BottomBar(
            selectedIndex: StateContainer.of(context).bottomBarCurrentPage,
            onTap: (int index) async {
              StateContainer.of(context)
                  .bottomBarPageController!
                  .jumpToPage(index);
              final preferences = await Preferences.getInstance();
              preferences.setMainScreenCurrentPage(index);
              StateContainer.of(context).bottomBarCurrentPage = index;
            },
            items: <BottomBarItem>[
              BottomBarItem(
                icon: const FaIcon(FontAwesomeIcons.keycdn),
                backgroundColorOpacity: theme.bottomBarBackgroundColorOpacity!,
                activeIconColor: theme.bottomBarActiveIconColor,
                activeTitleColor: theme.bottomBarActiveTitleColor,
                activeColor: theme.bottomBarActiveColor!,
                inactiveColor: theme.bottomBarInactiveIcon,
              ),
              BottomBarItem(
                icon: const Icon(Icons.account_circle),
                backgroundColorOpacity: theme.bottomBarBackgroundColorOpacity!,
                activeIconColor: theme.bottomBarActiveIconColor,
                activeTitleColor: theme.bottomBarActiveTitleColor,
                activeColor: theme.bottomBarActiveColor!,
                inactiveColor: theme.bottomBarInactiveIcon,
              ),
              /*BottomBarItem(
                  icon: const Icon(Icons.collections_bookmark),
                  backgroundColorOpacity: theme
                      .bottomBarBackgroundColorOpacity!,
                  activeIconColor: theme
                      .bottomBarActiveIconColor!,
                  activeTitleColor: theme
                      .bottomBarActiveTitleColor!,
                  activeColor:
                      theme.bottomBarActiveColor!,
                  inactiveColor: theme
                      .bottomBarInactiveIcon!),*/
            ],
          ),
        ),
      ),
    );
  }
}
