import 'package:aewallet/ui/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTThumbnailError extends ConsumerWidget {
  const NFTThumbnailError({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 200,
      height: 130,
      child: SizedBox(
        height: 78,
        child: Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: ArchethicThemeStyles.textStyleSize12W100Primary,
          ),
        ),
      ),
    );
  }
}
