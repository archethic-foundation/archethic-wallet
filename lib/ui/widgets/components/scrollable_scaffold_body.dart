import 'package:flutter/material.dart';

/// Fills Scaffold body height.
///
/// Makes body Scrollable when necessary.
class ScrollableScaffoldBody extends StatelessWidget {
  const ScrollableScaffoldBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Builder(
        builder: (context) => SizedBox(
          height: MediaQuery.of(context).size.height -
              (Scaffold.of(context).appBarMaxHeight ?? 0) -
              MediaQuery.of(context).viewPadding.top -
              MediaQuery.of(context).viewPadding.bottom -
              MediaQuery.of(context).viewInsets.top -
              MediaQuery.of(context).viewInsets.bottom,
          child: child,
        ),
      ),
    );
  }
}
