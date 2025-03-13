import 'package:flutter/material.dart';

class NumberedListItem extends StatelessWidget {
  const NumberedListItem({
    super.key,
    required this.index,
    required this.content,
  });

  factory NumberedListItem.withRichText({
    required int index,
    required List<TextSpan> text,
  }) =>
      NumberedListItem(
        index: index,
        content: Text.rich(TextSpan(children: text)),
      );

  final Widget content;
  final int index;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _iconData,
            size: 24,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: content,
            ),
          ),
        ],
      );

  IconData get _iconData => switch (index) {
        1 => Icons.looks_one_outlined,
        2 => Icons.looks_two_outlined,
        3 => Icons.looks_3_outlined,
        4 => Icons.looks_4_outlined,
        5 => Icons.looks_5_outlined,
        6 => Icons.looks_6_outlined,
        _ => Icons.looks_one_outlined,
      };
}
