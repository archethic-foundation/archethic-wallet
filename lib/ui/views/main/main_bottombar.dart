/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bottom_bar/bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/util/preferences.dart';

class MainBottomBar extends StatelessWidget {
  const MainBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
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
              Preferences preferences = await Preferences.getInstance();
              preferences.setMainScreenCurrentPage(index);
              StateContainer.of(context).bottomBarCurrentPage = index;
            },
            items: <BottomBarItem>[
              BottomBarItem(
                  icon: const FaIcon(FontAwesomeIcons.keycdn),
                  backgroundColorOpacity: StateContainer.of(context)
                      .curTheme
                      .bottomBarBackgroundColorOpacity!,
                  activeIconColor: StateContainer.of(context)
                      .curTheme
                      .bottomBarActiveIconColor!,
                  activeTitleColor: StateContainer.of(context)
                      .curTheme
                      .bottomBarActiveTitleColor!,
                  activeColor:
                      StateContainer.of(context).curTheme.bottomBarActiveColor!,
                  inactiveColor: StateContainer.of(context)
                      .curTheme
                      .bottomBarInactiveIcon!),
              BottomBarItem(
                  icon: const Icon(Icons.account_circle),
                  backgroundColorOpacity: StateContainer.of(context)
                      .curTheme
                      .bottomBarBackgroundColorOpacity!,
                  activeIconColor: StateContainer.of(context)
                      .curTheme
                      .bottomBarActiveIconColor!,
                  activeTitleColor: StateContainer.of(context)
                      .curTheme
                      .bottomBarActiveTitleColor!,
                  activeColor:
                      StateContainer.of(context).curTheme.bottomBarActiveColor!,
                  inactiveColor: StateContainer.of(context)
                      .curTheme
                      .bottomBarInactiveIcon!),
              BottomBarItem(
                  icon: const Icon(Icons.collections_bookmark),
                  backgroundColorOpacity: StateContainer.of(context)
                      .curTheme
                      .bottomBarBackgroundColorOpacity!,
                  activeIconColor: StateContainer.of(context)
                      .curTheme
                      .bottomBarActiveIconColor!,
                  activeTitleColor: StateContainer.of(context)
                      .curTheme
                      .bottomBarActiveTitleColor!,
                  activeColor:
                      StateContainer.of(context).curTheme.bottomBarActiveColor!,
                  inactiveColor: StateContainer.of(context)
                      .curTheme
                      .bottomBarInactiveIcon!),
            ],
          ),
        ),
      ),
    );
  }
}
