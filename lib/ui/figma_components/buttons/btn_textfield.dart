import 'package:aewallet/ui/figma_components/custom_styles.dart';
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
                              color: Colors.white.withValues(alpha: 0.2),
                              fontWeight: FontWeightTelegraf.fontWeightRegular,
                            )
                        : Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontWeight: FontWeightTelegraf.fontWeightRegular,
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
