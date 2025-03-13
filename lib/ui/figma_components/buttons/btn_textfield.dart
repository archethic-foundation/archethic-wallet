import 'package:flutter/material.dart';

class BtnTextField extends StatelessWidget {
  const BtnTextField({
    required this.buttonText,
    required this.onTap,
    this.isLocked = false,
    super.key,
  });
  final Widget buttonText;
  final Function()? onTap;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isLocked ? null : onTap,
        child: IntrinsicWidth(
          child: IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
              ),
              child: SizedBox(
                height: 22,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isLocked)
                      Opacity(opacity: 0.2, child: buttonText)
                    else
                      Opacity(opacity: 0.8, child: buttonText),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
