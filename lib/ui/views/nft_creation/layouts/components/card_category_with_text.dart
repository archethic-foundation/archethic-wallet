import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/card_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardCategoryWithText extends ConsumerWidget {
  const CardCategoryWithText({
    super.key,
    required this.background,
    required this.text,
    this.onTap,
  });

  final Widget background;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CardCategory(
            background: background,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: ArchethicThemeStyles.textStyleSize12W400Primary,
          ),
        ],
      ),
    );
  }
}
