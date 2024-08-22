import 'dart:async';

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:flutter/material.dart';

class ArchethicRefreshIndicator extends StatefulWidget {
  const ArchethicRefreshIndicator({
    required this.child,
    required this.onRefresh,
    super.key,
  });
  final Widget child;
  final Future<void> Function() onRefresh;

  @override
  State<ArchethicRefreshIndicator> createState() =>
      _ArchethicRefreshIndicatorState();
}

class _ArchethicRefreshIndicatorState extends State<ArchethicRefreshIndicator>
    with TickerProviderStateMixin<ArchethicRefreshIndicator> {
  late final AnimationController _opacityController;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _opacityController, curve: Curves.easeInOut),
    );
    super.initState();
  }

  @override
  void dispose() {
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (context, child) {
        return RefreshIndicator(
          edgeOffset: 150,
          strokeWidth: 2,
          backgroundColor: Theme.of(context)
              .scaffoldBackgroundColor
              .withOpacity(_opacityAnimation.value),
          color: ArchethicTheme.text.withOpacity(_opacityAnimation.value),
          onRefresh: () async {
            unawaited(_opacityController.forward());
            await widget.onRefresh();
            _opacityController.reset();
          },
          child: child!,
        );
      },
      child: widget.child,
    );
  }
}
