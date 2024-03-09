import 'package:aewallet/ui/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransactionWarning extends ConsumerWidget {
  const TransactionWarning({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(
          Symbols.warning,
          size: 10,
          weight: IconSize.weightM,
          opticalSize: IconSize.opticalSizeM,
          grade: IconSize.gradeM,
        ),
        const SizedBox(width: 5),
        Text(
          message,
          style: ArchethicThemeStyles.textStyleSize12W100Primary,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
