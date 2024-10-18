import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class ItemRemoveButton extends ConsumerWidget {
  const ItemRemoveButton({
    required this.onPressed,
    this.readOnly = false,
    super.key,
  });

  final Function onPressed;
  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (readOnly) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ArchethicTheme.backgroundDark.withOpacity(0.3),
          border: Border.all(
            color: ArchethicTheme.backgroundDarkest.withOpacity(0.2),
            width: 2,
          ),
        ),
        child: IconButton(
          icon: Icon(
            Symbols.close,
            color: ArchethicTheme.backgroundDarkest,
            size: 21,
          ),
          // ignore: unnecessary_lambdas
          onPressed: () {
            onPressed();
          },
        ),
      ),
    );
  }
}
