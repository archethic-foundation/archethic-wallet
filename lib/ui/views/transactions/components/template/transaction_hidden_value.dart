import 'package:aewallet/ui/themes/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionHiddenValue extends ConsumerWidget {
  const TransactionHiddenValue({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoSizeText(
      '···········',
      style: ArchethicThemeStyles.textStyleSize12W600Primary60,
    );
  }
}
