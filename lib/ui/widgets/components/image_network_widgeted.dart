/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageNetworkWidgeted extends ConsumerWidget {
  const ImageNetworkWidgeted({
    required this.url,
    required this.errorMessage,
    super.key,
  });

  final String url;
  final String errorMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return ImageNetwork(
      url: url,
      error: Center(
        child: Text(
          errorMessage,
          style: theme.textStyleSize16W600Primary,
        ),
      ),
      loading: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
