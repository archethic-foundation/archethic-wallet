import 'package:aewallet/application/settings/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchethicRefreshIndicator extends ConsumerWidget {
  const ArchethicRefreshIndicator({
    required this.child,
    required this.onRefresh,
    super.key,
  });

  final Widget child;
  final Future<void> Function() onRefresh;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return RefreshIndicator(
      backgroundColor: theme.backgroundDark,
      edgeOffset: 35,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
