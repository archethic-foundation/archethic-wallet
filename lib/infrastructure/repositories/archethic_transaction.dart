/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/token.dart';
import 'package:aewallet/domain/models/transaction.dart';
import 'package:aewallet/domain/models/transfer.dart';
import 'package:aewallet/domain/repositories/transaction.dart';
import 'package:aewallet/infrastructure/repositories/transaction_token_builder.dart';
import 'package:aewallet/infrastructure/repositories/transaction_transfer_builder.dart';
import 'package:aewallet/util/confirmations/transaction_sender.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class ArchethicTransactionRepository implements TransactionRepositoryInterface {
  ArchethicTransactionRepository({
    required this.phoenixHttpEndpoint,
    required this.websocketEndpoint,
  });

  archethic.ApiService? _apiService;
  archethic.ApiService get apiService =>
      _apiService ??= sl.get<archethic.ApiService>();

  final String phoenixHttpEndpoint;
  final String websocketEndpoint;

  @override
  Future<Result<double, Failure>> calculateFees(
    Transaction transaction,
  ) async {
    try {
      final transactionBuilt = await _buildTransaction(transaction);

      final transactionFee = await apiService.getTransactionFee(
        transactionBuilt,
      );
      if (transactionFee.errors != null) {
        return const Result.failure(
          Failure.other(),
        );
      }

      if (transactionFee.fee == null) {
        return const Result.failure(
          Failure.other(),
        );
      }

      return Result.success(
        archethic.fromBigInt(transactionFee.fee).toDouble(),
      );
    } catch (e, stack) {
      return Result.failure(
        Failure.other(
          cause: e,
          stack: stack,
        ),
      );
    }
  }

  Future<archethic.Transaction> _buildTransactionTransfer(
    Transfer transfer,
  ) async {
    final originPrivateKey = apiService.getOriginKey();
    final keychain = await apiService.getKeychain(transfer.seed);

    final nameEncoded = Uri.encodeFull(
      transfer.accountSelectedName,
    );
    final service = 'archethic-wallet-$nameEncoded';
    final index = (await apiService.getTransactionIndex(
      archethic.uint8ListToHex(
        keychain.deriveAddress(
          service,
        ),
      ),
    ))
        .chainLength!;

    var tokenTransferList = <archethic.TokenTransfer>[];
    var ucoTransferList = <archethic.UCOTransfer>[];

    transfer.map(
      token: (token) {
        tokenTransferList = <archethic.TokenTransfer>[
          archethic.TokenTransfer(
            amount: archethic.toBigInt(token.amount),
            to: token.recipientAddress.address,
            tokenAddress: token.tokenAddress,
            tokenId: 0,
          )
        ];
      },
      uco: (uco) {
        ucoTransferList = <archethic.UCOTransfer>[
          archethic.UCOTransfer(
            amount: archethic.toBigInt(uco.amount),
            to: uco.recipientAddress.address,
          )
        ];
      },
    );

    return TransferTransactionBuilder.build(
      index: index,
      keychain: keychain,
      originPrivateKey: originPrivateKey,
      serviceName: service,
      tokenTransferList: tokenTransferList,
      ucoTransferList: ucoTransferList,
      message: transfer.message,
    );
  }

  Future<archethic.Transaction> _buildTransactionToken(
    Token token,
  ) async {
    final originPrivateKey = apiService.getOriginKey();
    final keychain = await apiService.getKeychain(token.seed);

    final nameEncoded = Uri.encodeFull(
      token.accountSelectedName,
    );
    final service = 'archethic-wallet-$nameEncoded';
    final index = (await apiService.getTransactionIndex(
      archethic.uint8ListToHex(
        keychain.deriveAddress(
          service,
        ),
      ),
    ))
        .chainLength!;

    return AddTokenTransactionBuilder.build(
      tokenName: token.name,
      tokenSymbol: token.symbol,
      tokenInitialSupply: token.initialSupply,
      tokenType: token.type,
      index: index,
      keychain: keychain,
      originPrivateKey: originPrivateKey,
      serviceName: service,
    );
  }

  Future<archethic.Transaction> _buildTransaction(
    Transaction transaction,
  ) async {
    return await transaction.map(
      transfer: (transfer) async {
        return _buildTransactionTransfer(transfer.transfer);
      },
      token: (token) async {
        return _buildTransactionToken(token.token);
      },
    );
  }

  @override
  Future<void> send({
    required Transaction transaction,
    Duration timeout = const Duration(seconds: 10),
    required TransactionConfirmationHandler onConfirmation,
    required TransactionErrorHandler onError,
  }) async {
    final TransactionSenderInterface transactionSender =
        ArchethicTransactionSender(
      phoenixHttpEndpoint: phoenixHttpEndpoint,
      websocketEndpoint: websocketEndpoint,
    );

    transaction.map(
      transfer: (transfer) async {
        transactionSender.send(
          transaction: await _buildTransaction(transfer),
          onConfirmation: onConfirmation,
          onError: onError,
        );
      },
      token: (token) async {
        transactionSender.send(
          transaction: await _buildTransaction(token),
          onConfirmation: onConfirmation,
          onError: onError,
        );
      },
    );
  }
}
