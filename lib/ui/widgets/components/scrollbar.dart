import 'package:flutter/material.dart';

class ScrollBar extends StatefulWidget {
  const ScrollBar({
    super.key,
    required this.child,
    this.scrollPhysics,
  });

  final Widget child;
  final ScrollPhysics? scrollPhysics;

  @override
  State<ScrollBar> createState() => _ScrollBarState();
}

class _ScrollBarState extends State<ScrollBar> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: SingleChildScrollView(
        physics: widget.scrollPhysics,
        controller: scrollController,
        child: widget.child,
      ),
    );
  }
}
