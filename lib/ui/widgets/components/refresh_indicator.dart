import 'package:aewallet/ui/themes/archethic_theme.dart';
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
    return RefreshIndicator(
      backgroundColor: ArchethicTheme.backgroundDark,
      strokeWidth: 1,
      edgeOffset: 70,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
