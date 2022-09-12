/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class NetworkIndicator extends StatelessWidget {
  const NetworkIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          '${StateContainer.of(context).curTheme.assetsFolder!}${StateContainer.of(context).curTheme.logoAlone!}.svg',
          height: 30,
        ),
        Text(StateContainer.of(context).curNetwork.getDisplayName(context),
            style: AppStyles.textStyleSize10W100Primary(context)),
      ],
    );
  }
}
