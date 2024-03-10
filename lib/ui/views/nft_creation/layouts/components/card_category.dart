/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardCategory extends ConsumerWidget {
  const CardCategory({super.key, required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: aedappfm.AppThemeBase.sheetBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: aedappfm.AppThemeBase.sheetBorder,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 4,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    categoryName,
                    textAlign: TextAlign.center,
                    style: ArchethicThemeStyles.textStyleSize12W600Primary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
