// import 'dart:async';
// import 'dart:io';

// import 'package:aewallet/application/wallet/wallet.dart';
// import 'package:aewallet/localization.dart';
// import 'package:aewallet/service/app_service.dart';
// import 'package:aewallet/util/get_it_instance.dart';
// import 'package:aewallet/util/notifications_util.dart';
// import 'package:archethic_lib_dart/archethic_lib_dart.dart';
// import 'package:flutter/foundation.dart';

// abstract class CheckTransactions {}


// TODO(Chralu): a declencher lorsqu'on est loggé et que SettingsProviders.settings.activeNotifications et true.
// void tansactionInputs(LoggedInSession session) {
//   final message =
//       'bonjour'; // TODO(Chralu): use the appropriate message AppLocalization.of(context)!.transactionInputNotification;
//   if (!kIsWeb &&
//       (Platform.isIOS == true ||
//           Platform.isAndroid == true ||
//           Platform.isMacOS == true)) {
//     Timer.periodic(
//       const Duration(seconds: 30),
//       (Timer t) async {
//         final accounts = session.wallet.appKeychain.accounts;
//         for (final account in accounts) {
//           final transactionInputList =
//               await sl.get<AppService>().getTransactionInputs(
//                     account.lastAddress!,
//                     'from, amount, timestamp, tokenAddress ',
//                   );

//           for (final transactionInput in transactionInputList) {
//             if (account.lastLoadingTransactionInputs == null ||
//                 transactionInput.timestamp! >
//                     account.lastLoadingTransactionInputs!) {
//               account.updateLastLoadingTransactionInputs();
//               if (transactionInput.from != account.lastAddress) {
//                 var symbol = 'UCO';
//                 if (transactionInput.tokenAddress != null) {
//                   symbol = (await sl
//                           .get<ApiService>()
//                           .getToken(transactionInput.tokenAddress!))
//                       .symbol!;
//                 }
//                 NotificationsUtil.showNotification(
//                   title: 'Archethic',
//                   body: message
//                       .replaceAll(
//                         '%1',
//                         fromBigInt(transactionInput.amount).toString(),
//                       )
//                       .replaceAll('%2', symbol)
//                       .replaceAll('%3', account.name!),
//                   payload: account.name,
//                 );
//                 await requestUpdate(forceUpdateChart: false);
//               }
//             }
//           }
//         }
//       },
//     );
//   }
// }

// // TODO(Chralu): a declencher lorsqu'on logout
// void cancelTimerCheckTransactionInputs() {
//   if (timerCheckTransactionInputs != null) {
//     timerCheckTransactionInputs!.cancel();
//   }
// }
