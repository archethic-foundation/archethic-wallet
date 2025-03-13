import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

enum BtnFooterPrimaryType { primary, outlinePrimary }

class BtnFooterPrimary extends StatelessWidget {
  const BtnFooterPrimary({
    required this.buttonText,
    required this.onTap,
    this.btnPrimaryType = BtnFooterPrimaryType.primary,
    this.isLocked = false,
    this.lockedIcon = false,
    this.showProgressIndicator = false,
    super.key,
  });
  final String buttonText;
  final Function()? onTap;
  final BtnFooterPrimaryType btnPrimaryType;
  final bool isLocked;
  final bool lockedIcon;
  final bool showProgressIndicator;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isLocked ? null : onTap,
        child: IntrinsicHeight(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
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
                            fontWeight: FontWeightTelegraf.fontWeightSemibold,
                          )
                      : Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white.withValues(alpha: 0.2),
                            fontWeight: FontWeightTelegraf.fontWeightSemibold,
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
                if (showProgressIndicator)
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 1),
                    child: SizedBox.square(
                      dimension: 10,
                      child: CircularProgressIndicator(
                        color: Colors.white.withValues(alpha: 0.2),
                        strokeWidth: 2,
                      ),
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
    switch (btnPrimaryType) {
      case BtnFooterPrimaryType.primary:
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
      case BtnFooterPrimaryType.outlinePrimary:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black54,
          border: GradientBoxBorder(
            gradient: ArchethicGradients.archethicLinearBlue,
            width: 2,
          ),
        );
    }
  }
}
