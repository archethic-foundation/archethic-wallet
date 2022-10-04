/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/util/screen_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_svg/svg.dart';

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
        if (ScreenUtil.isDesktopMode() == true)
          const SizedBox(width: 20)
        else
          const SizedBox(),
        if (ScreenUtil.isDesktopMode() == true)
          const Text('Archethic Wallet')
        else
          const SizedBox(),
      ],
    ),
  );
}
