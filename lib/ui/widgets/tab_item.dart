/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabItem extends ConsumerWidget {
  const TabItem({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Tab(
      child: Column(
        children: [
          Icon(
            icon,
            weight: IconSize.weightM,
            opticalSize: IconSize.opticalSizeM,
            grade: IconSize.gradeM,
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            label,
            style: theme.textStyleSize10W400Primary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
