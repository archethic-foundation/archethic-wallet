/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkIndicator extends ConsumerWidget {
  const NetworkIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Column(
      children: [
        Text(
          ref.read(SettingsProviders.settings).network.getDisplayName(context),
          style: theme.textStyleSize10W100Primary,
        ),
      ],
    );
  }
}
