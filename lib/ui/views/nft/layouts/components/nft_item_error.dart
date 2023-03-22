/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTItemError extends ConsumerWidget {
  const NFTItemError({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return SizedBox(
      width: 200,
      height: 130,
      child: SizedBox(
        height: 78,
        child: Center(
          child: Text(
            message,
            style: theme.textStyleSize12W100Primary,
          ),
        ),
      ),
    );
  }
}
