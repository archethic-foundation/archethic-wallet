/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/card_cateogry.dart';
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
    final theme = ref.watch(ThemeProviders.selectedTheme);

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
            style: theme.textStyleSize12W400Primary,
          ),
        ],
      ),
    );
    ;
  }
}
