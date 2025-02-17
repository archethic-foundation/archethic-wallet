import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });
  final bool value;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                  color: ArchethicThemeBase.blue400,
                  border: Border.all(
                    width: 3,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
