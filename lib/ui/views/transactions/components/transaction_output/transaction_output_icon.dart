/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransactionOutputIcon extends ConsumerWidget {
  const TransactionOutputIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.red),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 1),
        child: Icon(
          Symbols.call_made,
          size: 12,
          color: Colors.red,
        ),
      ),
    );
  }
}
