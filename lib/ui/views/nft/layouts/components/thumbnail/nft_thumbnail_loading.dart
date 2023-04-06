/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTThumbnailLoading extends ConsumerWidget {
  const NFTThumbnailLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return SizedBox(
      width: 200,
      height: 130,
      child: SizedBox(
        height: 78,
        child: Center(
          child: CircularProgressIndicator(
            color: theme.text,
            strokeWidth: 1,
          ),
        ),
      ),
    );
  }
}
