import 'package:aewallet/ui/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionInformation extends ConsumerWidget {
  const TransactionInformation({
    super.key,
    required this.isEmpty,
    required this.message,
  });

  final bool isEmpty;
  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: <Widget>[
        if (isEmpty)
          const Text('')
        else
          Text(
            message,
            style: ArchethicThemeStyles.textStyleSize12W400Primary,
          ),
      ],
    );
  }
}
