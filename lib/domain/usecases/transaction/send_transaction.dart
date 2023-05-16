/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer';

import 'package:aewallet/domain/models/app_wallet.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/domain/usecases/usecase.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/util/confirmations/transaction_sender.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_transaction.freezed.dart';

@freezed
class SendTransactionCommand with _$SendTransactionCommand {
  const factory SendTransactionCommand({
    required Account senderAccount,

    /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
    required Data data,

    /// - Type: transaction type
    required String type,

    /// - Version: version of the transaction (used for backward compatiblity)
    required int version,
  }) = _SendTransactionCommand;
  const SendTransactionCommand._();
}

extension SendTransactionCommandConversion on SendTransactionCommand {
  Future<Transaction?> toArchethicTransaction({
    required AppWallet wallet,
    required Account senderAccount,
    required ApiService apiService,
  }) async {
    try {
      final originPrivateKey = apiService.getOriginKey();
      final keychain = wallet.keychainSecuredInfos.toKeychain();

      final serviceName =
          'archethic-wallet-${Uri.encodeFull(senderAccount.name)}';

      var indexSearchRef = '';
      switch (type) {
        case 'keychain':
          indexSearchRef = wallet.appKeychain.address;
          break;
        case 'transfer':
        case 'token':
          indexSearchRef = senderAccount.genesisAddress;
          break;
        default:
          throw UnimplementedError();
      }

      final indexMap = await apiService.getTransactionIndex(
        [indexSearchRef],
      );

      final accountIndex = indexMap[indexSearchRef] ?? 0;

      final transaction = Transaction(type: type, data: data);

      late final Transaction signedTransaction;
      switch (type) {
        case 'keychain':
          signedTransaction = transaction
              .build(
                uint8ListToHex(keychain.seed!),
                accountIndex,
              )
              .originSign(originPrivateKey);
          break;
        case 'transfer':
        case 'token':
          signedTransaction = keychain
              .buildTransaction(
                transaction,
                serviceName,
                accountIndex,
              )
              .originSign(originPrivateKey);
          break;
        default:
          throw UnimplementedError();
      }

      return signedTransaction;
    } catch (e, stack) {
      log('Transaction creation failed', error: e, stackTrace: stack);
      return null;
    }
  }
}

class SendTransactionUseCase
    implements
        UseCase<SendTransactionCommand,
            Result<TransactionConfirmation, TransactionError>> {
  const SendTransactionUseCase({
    required this.wallet,
    required this.apiService,
    required this.networkSettings,
  });

  final AppWallet wallet;
  final ApiService apiService;
  final NetworksSetting networkSettings;

  @override
  Future<Result<TransactionConfirmation, TransactionError>> run(
    SendTransactionCommand command, {
    UseCaseProgressListener? onProgress,
  }) async {
    const logName = 'SendTransactionUseCase';

    final operationCompleter =
        Completer<Result<TransactionConfirmation, TransactionError>>();

    void _fail(TransactionError error) {
      operationCompleter.complete(
        Result.failure(error),
      );
    }

    final transactionSender = ArchethicTransactionSender(
      phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
      websocketEndpoint: networkSettings.getWebsocketUri(),
    );

    final transaction = await command.toArchethicTransaction(
      wallet: wallet,
      apiService: apiService,
      senderAccount: command.senderAccount,
    );

    if (transaction == null) {
      const error = TransactionError.invalidTransaction();
      return const Result.failure(error);
    }

    try {
      // ignore: cascade_invocations
      transactionSender.send(
        transaction: transaction,
        onConfirmation: (confirmation) async {
          onProgress?.call(
            UseCaseProgress(
              total: confirmation.maxConfirmations,
              progress: confirmation.nbConfirmations,
            ),
          );
          if (confirmation.isFullyConfirmed) {
            log('Final confirmation received : $confirmation', name: logName);
            operationCompleter.complete(
              Result.success(confirmation),
            );
            return;
          }

          log('Confirmation received : $confirmation', name: logName);
        },
        onError: (error) async {
          log('Transaction error received', name: logName, error: error);
          _fail(error);
        },
      );
    } catch (e) {
      _fail(const TransactionError.other());
    }

    return operationCompleter.future;
  }
}
