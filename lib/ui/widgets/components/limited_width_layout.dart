import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/widgets/components/window_size.dart';
import 'package:flutter/material.dart';

class LimitedWidthLayout extends StatelessWidget {
  const LimitedWidthLayout({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage(ArchethicTheme.backgroundSmall),
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
                opacity: 0.3,
              ),
            ),
          ),
          Builder(
            builder: (context) => Align(
              child: ConstrainedBox(
                constraints: WindowSize().constraints,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
