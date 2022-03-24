// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:core/model/ae_apps.dart';
import 'package:core_ui/util/app_util.dart';
import 'package:flutter_svg/svg.dart';

Widget getLogo(BuildContext context) {
  return StateContainer.of(context).currentAEApp == AEApps.bin
      ? Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10.0),
          child: AppUtil.isDesktopMode()
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
                  if (AppUtil.isDesktopMode() == true) {
                    StateContainer.of(context).currentAEApp = AEApps.bin;
                    Navigator.pop(context);
                  }
                },
                child: AppUtil.isDesktopMode()
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
              AppUtil.isDesktopMode() == true
                  ? const SizedBox(width: 20)
                  : const SizedBox(),
              AppUtil.isDesktopMode() == true
                  ? Text(AEAppsUtil(StateContainer.of(context).currentAEApp)
                      .getDisplayName())
                  : const SizedBox(),
            ],
          ),
        );
}
