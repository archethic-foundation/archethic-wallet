import 'package:aewallet/application/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO(redwarf03): Check if this widget could be reuse in global (accounts List, recent transactions, ..)
class TransferDetailCard extends ConsumerWidget {
  const TransferDetailCard({
    required this.children,
    this.height,
    super.key,
  });

  final List<Widget> children;
  final double? height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return SizedBox.fromSize(
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: theme.backgroundTransferListOutline!,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        color: theme.backgroundTransferListCard,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          ),
        ),
      ),
    );
  }
}
