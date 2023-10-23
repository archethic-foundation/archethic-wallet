/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopupDialog extends ConsumerWidget {
  const PopupDialog({super.key, required this.content, required this.title});

  final Widget content;
  final Widget title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: ArchethicTheme.backgroundPopupColor,
      elevation: 0,
      title: title,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      content: content,
    );
  }
}
