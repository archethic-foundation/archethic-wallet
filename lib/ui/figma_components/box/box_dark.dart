import 'package:flutter/material.dart';

class BoxDark extends StatelessWidget {
  const BoxDark({
    super.key,
    required this.textWidget,
    required this.additionalWidget,
    this.onTap,
  });

  final Widget textWidget;
  final Widget additionalWidget;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF5540BF).withOpacity(0.4),
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.4),
        ),
        child: Column(
          children: [
            textWidget,
            const SizedBox(height: 5),
            additionalWidget,
          ],
        ),
      ),
    );
  }
}
