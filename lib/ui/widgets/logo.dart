/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/svg.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/util/screen_util.dart';

Widget getLogo(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(left: 10),
    child: Row(
      children: [
        InkWell(
          onTap: () {},
          child: ScreenUtil.isDesktopMode()
              ? Image.asset(
                  '${StateContainer.of(context).curTheme.assetsFolder!}${StateContainer.of(context).curTheme.logoAlone!}.png',
                  height: 40,
                )
              : kIsWeb
                  ? Image.asset(
                      '${StateContainer.of(context).curTheme.assetsFolder!}${StateContainer.of(context).curTheme.logoAlone!}.png',
                      height: 40,
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        '${StateContainer.of(context).curTheme.assetsFolder!}${StateContainer.of(context).curTheme.logoAlone!}.svg',
                        height: 40,
                      ),
                    ),
        ),
        ScreenUtil.isDesktopMode() == true
            ? const SizedBox(width: 20)
            : const SizedBox(),
        ScreenUtil.isDesktopMode() == true
            ? const Text('Archethic Wallet')
            : const SizedBox(),
      ],
    ),
  );
}
