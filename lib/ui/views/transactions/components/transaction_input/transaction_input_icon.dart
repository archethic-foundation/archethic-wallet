/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransactionInputIcon extends ConsumerWidget {
  const TransactionInputIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.only(top: 1),
      child: Icon(
        Symbols.call_received,
        size: 12,
        color: Colors.green,
      ),
    );
  }
}
