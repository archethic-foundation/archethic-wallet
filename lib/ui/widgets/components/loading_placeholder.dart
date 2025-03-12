import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/widgets/components/loading_list_header.dart';
import 'package:flutter/material.dart';

/// Shows a placeholder during loading
/// of main widget.
///
/// While [loaded] is true, placeholder is shown.
/// Once [loaded] is false, placeholder fades out and
/// is removed from widget tree.
class LoadingPlaceholder extends StatefulWidget {
  const LoadingPlaceholder({
    super.key,
    required this.child,
    required this.loaded,
    this.placeholder = const DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(ArchethicTheme.backgroundSmall),
          fit: BoxFit.cover,
        ),
      ),
      child: LoadingListHeader(),
    ),
    this.duration = const Duration(milliseconds: 1000),
  });

  final Widget placeholder;
  final Widget child;
  final bool loaded;
  final Duration duration;

  @override
  State<LoadingPlaceholder> createState() => _LoadingPlaceholderState();
}

class _LoadingPlaceholderState extends State<LoadingPlaceholder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _fadeOutAnimation;
  late bool _placeholderVisible;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addStatusListener(_onAnimationComplete);
    _fadeOutAnimation = CurvedAnimation(
      curve: Curves.easeInExpo,
      parent: _controller,
    );

    if (widget.loaded) {
      _controller.value = 1.0;
      _placeholderVisible = false;
    } else {
      _controller.value = 0.0;
      _placeholderVisible = true;
    }
    super.initState();
  }

  void _onAnimationComplete(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    setState(() {
      _placeholderVisible = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LoadingPlaceholder oldWidget) {
    if (!oldWidget.loaded && widget.loaded) {
      setState(() {
        _placeholderVisible = true;
      });
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_placeholderVisible)
          SizedBox.expand(
            child: FadeTransition(
              opacity: _fadeOutAnimation.drive(Tween(begin: 1, end: 0)),
              child: widget.placeholder,
            ),
          ),
      ],
    );
  }
}
