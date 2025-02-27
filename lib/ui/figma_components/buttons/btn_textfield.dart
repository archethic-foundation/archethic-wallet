import 'package:flutter/material.dart';

class BtnTextField extends StatelessWidget {
  const BtnTextField({
    required this.buttonText,
    required this.onTap,
    this.isLocked = false,
    super.key,
  });
  final String buttonText;
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    buttonText,
                    style: isLocked
                        ? Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.white.withOpacity(0.2),
                              fontWeight: FontWeight.w400,
                            )
                        : Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w400,
                            ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
