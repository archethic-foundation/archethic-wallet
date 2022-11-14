import 'package:aewallet/application/settings/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingListHeader extends ConsumerWidget {
  const LoadingListHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return SizedBox(
      height: 78,
      child: Center(
        child: CircularProgressIndicator(
          color: theme.text,
          strokeWidth: 1,
        ),
      ),
    );
  }
}
