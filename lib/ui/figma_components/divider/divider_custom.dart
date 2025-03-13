import 'package:flutter/material.dart';

class DividerCustom extends StatelessWidget {
  const DividerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Divider(
            color: Colors.white.withValues(alpha: 0.2),
          ),
        ),
      ),
    );
  }
}
