import 'package:aewallet/ui/figma_components/checkbox/checkbox_custom.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:flutter/material.dart';

class CheckboxConfirm extends StatelessWidget {
  const CheckboxConfirm({
    super.key,
    required this.value,
    required this.onChanged,
    required this.text,
  });

  final bool value;
  final void Function(bool value) onChanged;
  final String text;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onChanged(!value),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxCustom(
              value: value,
              onChanged: onChanged,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodySmallWithOpacity,
                ),
              ),
            ),
          ],
        ),
      );
}
