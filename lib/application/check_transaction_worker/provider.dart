import 'dart:async';
import 'dart:developer';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'state.dart';

abstract class CheckTransactionsProvider {
  static final provider = StreamProvider.autoDispose<ReceivedTransaction>(
    _checkTransactions,
  );
}

Stream<ReceivedTransaction> _checkTransactions(
  Ref ref,
) async* {
  Timer? _checkTransactionsTimer;
  final streamController = StreamController<ReceivedTransaction>.broadcast();

  Future<void> _cancelCheck() async {
    if (_checkTransactionsTimer == null) return;
    log('[CheckTransactionScheduler] cancelling scheduler');
    _checkTransactionsTimer?.cancel();
    _checkTransactionsTimer = null;
  }

  void _scheduleCheck() {
    if (_checkTransactionsTimer != null && _checkTransactionsTimer!.isActive) {
      log('[CheckTransactionScheduler] start abort : scheduler already running');
      return;
    }
    log('[CheckTransactionScheduler] starting scheduler');

    _checkTransactionsTimer = Timer.periodic(
      const Duration(seconds: 30),
      (Timer t) async {
        final accounts = await ref.read(AccountProviders.accounts.future);
        for (final account in accounts) {
          final transactionInputList =
              await sl.get<AppService>().getTransactionInputs(
                    account.lastAddress!,
                    'from, amount, timestamp, tokenAddress ',
                  );

          for (final transactionInput in transactionInputList) {
            if (account.lastLoadingTransactionInputs != null &&
                transactionInput.timestamp! <=
                    account.lastLoadingTransactionInputs!) {
              continue;
            }
            if (transactionInput.from != account.lastAddress) {
              var symbol = 'UCO';
              if (transactionInput.tokenAddress != null) {
                symbol = (await sl
                        .get<ApiService>()
                        .getToken(transactionInput.tokenAddress!))
                    .symbol!;
              }
              streamController.add(
                ReceivedTransaction(
                  accountName: account.name,
                  amount: transactionInput.amount ?? 0,
                  currencySymbol: symbol,
                ),
              );

              await ref
                  .read(AccountProviders.account(account.name).notifier)
                  .refreshRecentTransactions();
            }
          }
        }
      },
    );
  }

  ref.onDispose(
    () {
      _cancelCheck();
      streamController.close();
    },
  );

  final activeNotifications = ref.watch(
    SettingsProviders.settings.select(
      (settings) => settings.activeNotifications,
    ),
  );
  final session = ref.watch(SessionProviders.session).loggedIn;

  if (!activeNotifications || session == null) {
    await _cancelCheck();
    return;
  }

  _scheduleCheck();
  yield* streamController.stream;
}
