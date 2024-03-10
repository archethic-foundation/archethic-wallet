/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransactionOutputIcon extends ConsumerWidget {
  const TransactionOutputIcon(this.transactionRecipient, {super.key});

  final String? transactionRecipient;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const burnAddress =
        '00000000000000000000000000000000000000000000000000000000000000000000';

    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: Icon(
        transactionRecipient == null
            ? Symbols.call_made
            : transactionRecipient == burnAddress
                ? Symbols.mode_heat
                : Symbols.call_made,
        size: 12,
        color: Colors.red,
      ),
    );
  }
}
