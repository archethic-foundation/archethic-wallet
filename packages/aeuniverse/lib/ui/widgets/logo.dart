/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/model/ae_apps.dart';
import 'package:core_ui/util/screen_util.dart';
import 'package:flutter_svg/svg.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';

Widget getLogo(BuildContext context) {
  return StateContainer.of(context).currentAEApp == AEApps.bin
      ? Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10.0),
          child: ScreenUtil.isDesktopMode()
              ? Image.asset(
                  StateContainer.of(context).curTheme.assetsFolder! +
                      StateContainer.of(context).curTheme.logo! +
                      '.png',
                  height: 40,
                )
              : kIsWeb
                  ? Image.asset(
                      StateContainer.of(context).curTheme.assetsFolder! +
                          StateContainer.of(context).curTheme.logoAlone! +
                          '.png',
                      height: 40,
                    )
                  : SvgPicture.asset(
                      StateContainer.of(context).curTheme.assetsFolder! +
                          StateContainer.of(context).curTheme.logoAlone! +
                          '.svg',
                      height: 40,
                    ),
        )
      : Container(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  if (ScreenUtil.isDesktopMode() == true) {
                    StateContainer.of(context).currentAEApp = AEApps.bin;
                    Navigator.pop(context);
                  }
                },
                child: ScreenUtil.isDesktopMode()
                    ? Image.asset(
                        StateContainer.of(context).curTheme.assetsFolder! +
                            StateContainer.of(context).curTheme.logoAlone! +
                            '.png',
                        height: 40,
                      )
                    : kIsWeb
                        ? Image.asset(
                            StateContainer.of(context).curTheme.assetsFolder! +
                                StateContainer.of(context).curTheme.logoAlone! +
                                '.png',
                            height: 40,
                          )
                        : Container(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              StateContainer.of(context)
                                      .curTheme
                                      .assetsFolder! +
                                  StateContainer.of(context)
                                      .curTheme
                                      .logoAlone! +
                                  '.svg',
                              height: 40,
                            ),
                          ),
              ),
              ScreenUtil.isDesktopMode() == true
                  ? const SizedBox(width: 20)
                  : const SizedBox(),
              ScreenUtil.isDesktopMode() == true
                  ? Text(AEAppsUtil(StateContainer.of(context).currentAEApp)
                      .getDisplayName())
                  : const SizedBox(),
            ],
          ),
        );
}
