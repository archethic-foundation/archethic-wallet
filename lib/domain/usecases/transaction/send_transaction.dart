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
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_transaction.freezed.dart';

@freezed
class SignTransactionCommand with _$SignTransactionCommand {
  const factory SignTransactionCommand({
    required Account senderAccount,

    /// - [Data]: transaction data zone (identity, keychain, smart contract, etc.)
    required archethic.Data data,

    /// - Type: transaction type
    required String type,

    /// - Version: version of the transaction (used for backward compatiblity)
    required int version,
  }) = _SignTransactionCommand;
  const SignTransactionCommand._();
}

extension SignTransactionCommandConversion on SignTransactionCommand {
  Future<archethic.Transaction?> toArchethicTransaction({
    required AppWallet wallet,
    required Account senderAccount,
    required archethic.ApiService apiService,
  }) async {
    try {
      final keychain = wallet.keychainSecuredInfos.toKeychain();
      final serviceName =
          'archethic-wallet-${Uri.encodeFull(senderAccount.name)}';

      final indexMap = await apiService.getTransactionIndex(
        [senderAccount.genesisAddress],
      );
      final accountIndex = indexMap[senderAccount.genesisAddress] ?? 0;
      final originPrivateKey = apiService.getOriginKey();
      final transaction = archethic.Transaction(type: type, data: data);

      final builtTransaction = keychain.buildTransaction(
        transaction,
        serviceName,
        accountIndex,
      );

      final signedTransaction = builtTransaction.originSign(originPrivateKey);
      return signedTransaction;
    } catch (e, stack) {
      log('Transaction creation failed', error: e, stackTrace: stack);
      return null;
    }
  }
}

class SendTransactionUseCase
    implements
        UseCase<SignTransactionCommand,
            Result<TransactionConfirmation, TransactionError>> {
  const SendTransactionUseCase({
    required this.wallet,
    required this.apiService,
    required this.networkSettings,
  });

  final AppWallet wallet;
  final archethic.ApiService apiService;
  final NetworksSetting networkSettings;

  @override
  Future<Result<TransactionConfirmation, TransactionError>> run(
    SignTransactionCommand command, {
    UseCaseProgressListener? onProgress,
  }) async {
    const logName = 'SignTransactionHandler';

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
