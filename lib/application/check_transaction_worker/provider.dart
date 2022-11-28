import 'dart:async';
import 'dart:developer';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';
part 'state.dart';

abstract class CheckTransactionsProvider {
  static final provider = _checkTransactionNotifierProvider;
}

@Riverpod(keepAlive: true)
class _CheckTransactionNotifier
    extends AsyncNotifier<List<ReceivedTransaction>> {
  Timer? _checkTransactionsTimer;

  Future<void> _cancelCheck() async {
    if (_checkTransactionsTimer == null) return;
    log('[CheckTransactionScheduler] cancelling scheduler');
    _checkTransactionsTimer?.cancel();
    _checkTransactionsTimer = null;
  }

  Future<void> _scheduleCheck() async {
    if (_checkTransactionsTimer != null && _checkTransactionsTimer!.isActive) {
      log('[CheckTransactionScheduler] start abort : scheduler already running');
      return;
    }
    log('[CheckTransactionScheduler] starting scheduler');

    _checkTransactionsTimer = Timer.periodic(
      const Duration(seconds: 30),
      (Timer t) async {
        try {
          final accounts = await ref.read(AccountProviders.accounts.future);

          var transactionInputMap = <String, List<TransactionInput>>{};
          final lastAddressContactList = <String>[];
          for (final account in accounts) {
            if (account.lastAddress != null) {
              lastAddressContactList.add(account.lastAddress!);
            }
          }
          transactionInputMap = await sl.get<AppService>().getTransactionInputs(
                lastAddressContactList,
                'from, amount, timestamp, tokenAddress ',
              );

          final tokenAddressList = <String>[];
          for (final transactionInputList in transactionInputMap.values) {
            for (final transactionInput in transactionInputList) {
              if (transactionInput.tokenAddress != null &&
                  transactionInput.tokenAddress!.isNotEmpty) {
                tokenAddressList.add(transactionInput.tokenAddress!);
              }
            }
          }

          final symbolMap = await sl
              .get<ApiService>()
              .getToken(tokenAddressList, request: 'symbol, type');

          final transactionsToNotify = <ReceivedTransaction>[];

          for (final account in accounts) {
            final transactionInputList =
                transactionInputMap[account.lastAddress!] ?? [];
            for (final transactionInput in transactionInputList) {
              if (account.lastLoadingTransactionInputs != null &&
                  transactionInput.timestamp! <=
                      account.lastLoadingTransactionInputs!) {
                continue;
              }
              if (transactionInput.from != account.lastAddress) {
                var symbol = 'UCO';
                if (symbolMap.isNotEmpty &&
                    symbolMap[transactionInput.tokenAddress] != null) {
                  switch (symbolMap[transactionInput.tokenAddress]!.type) {
                    case 'non-fungible':
                      if (symbolMap[transactionInput.tokenAddress!]!.symbol !=
                              null &&
                          symbolMap[transactionInput.tokenAddress!]!
                              .symbol!
                              .isNotEmpty) {
                        symbol =
                            symbolMap[transactionInput.tokenAddress!]!.symbol!;
                      } else {
                        symbol = 'NFT';
                      }
                      break;
                    case 'fungible':
                      if (symbolMap[transactionInput.tokenAddress!]!.symbol !=
                              null &&
                          symbolMap[transactionInput.tokenAddress!]!
                              .symbol!
                              .isNotEmpty) {
                        symbol =
                            symbolMap[transactionInput.tokenAddress!]!.symbol!;
                      } else {
                        symbol = 'token(s)';
                      }
                      break;
                  }
                }
                transactionsToNotify.add(
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

          state = AsyncValue.data(transactionsToNotify);
        } catch (e, stack) {
          log(
            '[CheckTransactionScheduler] refresh failed.',
            error: e,
            stackTrace: stack,
          );
        }
      },
    );
  }

  @override
  Future<List<ReceivedTransaction>> build() async {
    ref.onDispose(
      _cancelCheck,
    );

    final activeNotifications = ref.watch(
      SettingsProviders.settings.select(
        (settings) => settings.activeNotifications,
      ),
    );
    final isLoggedIn = ref.watch(
      SessionProviders.session.select((session) => session.isLoggedIn),
    );

    if (!activeNotifications || !isLoggedIn) {
      await _cancelCheck();
      return [];
    }

    _scheduleCheck();
    return [];
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}



// Stream<ReceivedTransaction> _checkTransactions(
//   Ref ref,
// ) async* {
//   Timer? _checkTransactionsTimer;
//   final streamController = StreamController<ReceivedTransaction>.broadcast();

//   Future<void> _cancelCheck() async {
//     if (_checkTransactionsTimer == null) return;
//     log('[CheckTransactionScheduler] cancelling scheduler');
//     _checkTransactionsTimer?.cancel();
//     _checkTransactionsTimer = null;
//   }

//   void _scheduleCheck() {
//     if (_checkTransactionsTimer != null && _checkTransactionsTimer!.isActive) {
//       log('[CheckTransactionScheduler] start abort : scheduler already running');
//       return;
//     }
//     log('[CheckTransactionScheduler] starting scheduler');

//     _checkTransactionsTimer = Timer.periodic(
//       const Duration(seconds: 30),
//       (Timer t) async {
//         try {
//           final accounts = await ref.read(AccountProviders.accounts.future);

//           var transactionInputMap = <String, List<TransactionInput>>{};
//           final lastAddressContactList = <String>[];
//           for (final account in accounts) {
//             if (account.lastAddress != null) {
//               lastAddressContactList.add(account.lastAddress!);
//             }
//           }
//           transactionInputMap = await sl.get<AppService>().getTransactionInputs(
//                 lastAddressContactList,
//                 'from, amount, timestamp, tokenAddress ',
//               );

//           final tokenAddressList = <String>[];
//           for (final transactionInputList in transactionInputMap.values) {
//             for (final transactionInput in transactionInputList) {
//               if (transactionInput.tokenAddress != null &&
//                   transactionInput.tokenAddress!.isNotEmpty) {
//                 tokenAddressList.add(transactionInput.tokenAddress!);
//               }
//             }
//           }

//           final symbolMap = await sl
//               .get<ApiService>()
//               .getToken(tokenAddressList, request: 'symbol, type');

//           for (final account in accounts) {
//             final transactionInputList =
//                 transactionInputMap[account.lastAddress!] ?? [];
//             for (final transactionInput in transactionInputList) {
//               if (account.lastLoadingTransactionInputs != null &&
//                   transactionInput.timestamp! <=
//                       account.lastLoadingTransactionInputs!) {
//                 continue;
//               }
//               if (transactionInput.from != account.lastAddress) {
//                 var symbol = 'UCO';
//                 if (symbolMap.isNotEmpty &&
//                     symbolMap[transactionInput.tokenAddress] != null) {
//                   switch (symbolMap[transactionInput.tokenAddress]!.type) {
//                     case 'non-fungible':
//                       if (symbolMap[transactionInput.tokenAddress!]!.symbol !=
//                               null &&
//                           symbolMap[transactionInput.tokenAddress!]!
//                               .symbol!
//                               .isNotEmpty) {
//                         symbol =
//                             symbolMap[transactionInput.tokenAddress!]!.symbol!;
//                       } else {
//                         symbol = 'NFT';
//                       }
//                       break;
//                     case 'fungible':
//                       if (symbolMap[transactionInput.tokenAddress!]!.symbol !=
//                               null &&
//                           symbolMap[transactionInput.tokenAddress!]!
//                               .symbol!
//                               .isNotEmpty) {
//                         symbol =
//                             symbolMap[transactionInput.tokenAddress!]!.symbol!;
//                       } else {
//                         symbol = 'token(s)';
//                       }
//                       break;
//                   }
//                 }
//                 streamController.add(
//                   ReceivedTransaction(
//                     accountName: account.name,
//                     amount: transactionInput.amount ?? 0,
//                     currencySymbol: symbol,
//                   ),
//                 );

//                 await ref
//                     .read(AccountProviders.account(account.name).notifier)
//                     .refreshRecentTransactions();
//               }
//             }
//           }
//         } catch (e, stack) {
//           log(
//             '[CheckTransactionScheduler] refresh failed.',
//             error: e,
//             stackTrace: stack,
//           );
//         }
//       },
//     );
//   }

//   ref.onDispose(
//     () {
//       _cancelCheck();
//       streamController.close();
//     },
//   );

//   final activeNotifications = ref.watch(
//     SettingsProviders.settings.select(
//       (settings) => settings.activeNotifications,
//     ),
//   );
//   final isLoggedIn = ref
//       .watch(SessionProviders.session.select((session) => session.isLoggedIn));

//   if (!activeNotifications || !isLoggedIn) {
//     await _cancelCheck();
//     return;
//   }

//   _scheduleCheck();
//   yield* streamController.stream;
// }
