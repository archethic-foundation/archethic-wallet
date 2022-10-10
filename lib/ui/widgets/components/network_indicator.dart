/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:flutter_svg/svg.dart';

class NetworkIndicator extends ConsumerWidget {
  const NetworkIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.theme);
    return Column(
      children: [
        SvgPicture.asset(
          '${theme.assetsFolder!}${theme.logoAlone!}.svg',
          height: 30,
        ),
        Text(
          StateContainer.of(context).curNetwork.getDisplayName(context),
          style: theme.textStyleSize10W100Primary,
        ),
      ],
    );
  }
}
