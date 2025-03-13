import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class Dropdown extends StatelessWidget {
  const Dropdown({
    super.key,
    required this.badge,
    this.onTap,
  });

  final Widget badge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap == null ? 0.5 : 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          border: Border.all(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 0.5,
          ),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface.withValues(alpha: 1),
              Theme.of(context).colorScheme.surface.withValues(alpha: 0.3),
            ],
            stops: const [0, 1],
          ),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              children: [
                badge,
                const Spacer(),
                Icon(
                  Symbols.keyboard_arrow_down,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownBadge extends ConsumerWidget {
  const DropdownBadge({
    super.key,
    this.onTap,
    required this.content,
  });

  final VoidCallback? onTap;
  final Widget content;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: BoxConstraints(
        minWidth: aedappfm.Responsive.isMobile(context) ? 100 : 150,
      ),
      decoration: BoxDecoration(
        color: aedappfm.AppThemeBase.sheetBackgroundTertiary
            .withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: content,
        ),
      ),
    );
  }
}
