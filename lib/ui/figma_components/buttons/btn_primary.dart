import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

enum BtnPrimaryType { primary, outlinePrimary, dark }

class BtnPrimary extends StatelessWidget {
  const BtnPrimary({
    required this.buttonText,
    required this.onTap,
    this.btnPrimaryType = BtnPrimaryType.primary,
    super.key,
  });
  final String buttonText;
  final Function()? onTap;
  final BtnPrimaryType btnPrimaryType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8.5),
            alignment: Alignment.center,
            decoration: _getButtonDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  buttonText,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration? _getButtonDecoration() {
    switch (btnPrimaryType) {
      case BtnPrimaryType.primary:
        return BoxDecoration(
          gradient: ArchethicGradients.archethicLinearBlue,
          borderRadius: BorderRadius.circular(20),
        );
      case BtnPrimaryType.outlinePrimary:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: GradientBoxBorder(
            gradient: ArchethicGradients.archethicLinearBlue,
            width: 2,
          ),
        );
      case BtnPrimaryType.dark:
        return BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        );
    }
  }
}
