import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:flutter/material.dart';

class BtnFooterPrimary extends StatelessWidget {
  const BtnFooterPrimary({
    required this.buttonText,
    required this.onTap,
    this.isLocked = false,
    this.lockedIcon = false,
    super.key,
  });
  final String buttonText;
  final Function()? onTap;
  final bool isLocked;
  final bool lockedIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 49,
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
            alignment: Alignment.center,
            decoration: _getButtonDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  buttonText,
                  style: isLocked == false || (isLocked && lockedIcon == true)
                      ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          )
                      : Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white.withOpacity(0.2),
                            fontWeight: FontWeight.w500,
                          ),
                ),
                if (isLocked && lockedIcon)
                  const Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 3),
                    child: Icon(
                      Icons.lock_outline,
                      size: 16,
                      color: Colors.white,
                    ),
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration? _getButtonDecoration() {
    if (isLocked == false || (isLocked && lockedIcon == false)) {
      return BoxDecoration(
        gradient: ArchethicGradients.archethicLinearBlue,
        borderRadius: BorderRadius.circular(20),
      );
    }

    return BoxDecoration(
      color: const Color(0xFF888888),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
