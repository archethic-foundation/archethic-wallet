/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionIcon extends ConsumerWidget {
  const TransactionIcon({
    super.key,
    required this.transaction,
    this.size = 20,
  });

  final RecentTransaction transaction;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    if (transaction.typeTx == RecentTransaction.transferInput) {
      return Icon(
        UiIcons.receive,
        color: theme.positiveValue,
        size: size,
      );
    }

    if (transaction.typeTx == RecentTransaction.transferOutput) {
      return Icon(
        UiIcons.send,
        color: theme.negativeValue,
        size: size,
      );
    }

    return Container();
  }
}
