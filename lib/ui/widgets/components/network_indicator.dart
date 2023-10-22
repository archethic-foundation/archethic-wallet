/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkIndicator extends ConsumerWidget {
  const NetworkIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          ref.read(SettingsProviders.settings).network.getDisplayName(context),
          style: ArchethicThemeStyles.textStyleSize10W100Primary,
        ),
      ],
    );
  }
}
