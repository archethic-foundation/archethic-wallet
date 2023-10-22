import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingListHeader extends ConsumerWidget {
  const LoadingListHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 78,
      child: Center(
        child: CircularProgressIndicator(
          color: ArchethicTheme.text,
          strokeWidth: 1,
        ),
      ),
    );
  }
}
