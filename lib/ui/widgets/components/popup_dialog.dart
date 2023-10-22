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
      title: title,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        side: BorderSide(
          color: ArchethicTheme.text45,
        ),
      ),
      content: content,
    );
  }
}
