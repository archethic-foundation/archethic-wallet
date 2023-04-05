/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class TransactionOutputIcon extends ConsumerWidget {
  const TransactionOutputIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Icon(
      Iconsax.export,
      size: 12,
      color: Colors.red,
    );
  }
}
