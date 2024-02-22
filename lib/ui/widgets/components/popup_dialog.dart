/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopupDialog extends ConsumerWidget {
  const PopupDialog({super.key, required this.content, required this.title});

  final Widget content;
  final Widget title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent.withAlpha(180),
      body: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ArchethicTheme.sheetBackground.withOpacity(0.2),
              border: Border.all(
                color: ArchethicTheme.sheetBorder,
              ),
            ),
            child: AlertDialog(
              title: title,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: content,
            ),
          ),
        ),
      ),
    );
  }
}
