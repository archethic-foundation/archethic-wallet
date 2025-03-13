import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

enum BtnPrimaryType { primary, outlinePrimary, dark }

class BtnPrimary extends StatelessWidget {
  const BtnPrimary({
    required this.buttonText,
    required this.onTap,
    this.btnPrimaryType = BtnPrimaryType.primary,
    this.isLocked = false,
    this.widthExpanded = false,
    super.key,
  });
  final String buttonText;
  final Function()? onTap;
  final BtnPrimaryType btnPrimaryType;
  final bool isLocked;
  final bool widthExpanded;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: isLocked ? MouseCursor.defer : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isLocked ? null : onTap,
        child: widthExpanded
            ? _button(context)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [_button(context)],
              ),
      ),
    );
  }

  Widget _button(
    BuildContext context,
  ) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 40),
      child: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8.5),
          alignment: Alignment.center,
          decoration: _getButtonDecoration(),
          child: Text(
            buttonText,
            overflow: TextOverflow.visible,
            softWrap: false,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: isLocked
                      ? Colors.white.withValues(alpha: 0.2)
                      : Colors.white,
                  fontWeight: FontWeightTelegraf.fontWeightBold,
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
