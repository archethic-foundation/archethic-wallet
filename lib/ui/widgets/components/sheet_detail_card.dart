import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SheetDetailCard extends ConsumerWidget {
  const SheetDetailCard({
    required this.children,
    this.height,
    super.key,
  });

  final List<Widget> children;
  final double? height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox.fromSize(
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: ArchethicTheme.backgroundTransferListOutline,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        color: ArchethicTheme.backgroundTransferListCard,
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
