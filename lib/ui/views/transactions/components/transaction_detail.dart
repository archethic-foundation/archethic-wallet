/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/market_price.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/ui/views/transactions/components/token_creation/token_creation.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_hosting/transaction_hosting.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_input/transaction_input.dart';
import 'package:aewallet/ui/views/transactions/components/transaction_output/transaction_output.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionDetail extends ConsumerWidget {
  const TransactionDetail({required this.transaction, super.key});

  final RecentTransaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;

    final selectedCurrencyMarketPrice =
        ref.watch(MarketPriceProviders.selectedCurrencyMarketPrice).valueOrNull;

    if (accountSelected == null || selectedCurrencyMarketPrice == null) {
      return const SizedBox();
    }

    switch (transaction.typeTx) {
      case RecentTransaction.tokenCreation:
        return TokenCreation(
          transaction: transaction,
          marketPrice: selectedCurrencyMarketPrice,
        );
      case RecentTransaction.transferInput:
        return TransactionInput(
          transaction: transaction,
          marketPrice: selectedCurrencyMarketPrice,
        );
      case RecentTransaction.transferOutput:
        return TransactionOuput(
          transaction: transaction,
          marketPrice: selectedCurrencyMarketPrice,
        );
      case RecentTransaction.hosting:
        return TransactionHosting(
          transaction: transaction,
          marketPrice: selectedCurrencyMarketPrice,
        );
      default:
        return const SizedBox();
    }
  }
}
