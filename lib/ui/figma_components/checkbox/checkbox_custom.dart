import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:flutter/material.dart';

class CheckboxCustom extends StatelessWidget {
  const CheckboxCustom({
    super.key,
    required this.value,
    required this.onChanged,
  });
  final bool value;
  final void Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
              color: ArchethicThemeBase.neutral0.withOpacity(0.8),
              width: 2,
            ),
          ),
          child: value
              ? Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: ArchethicGradients.archethicLinearBlue,
                    border: Border.all(
                      width: 2,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
