/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:typed_data';

import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/token.dart';
import 'package:aewallet/domain/models/transaction.dart';
import 'package:aewallet/domain/models/transfer.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/infrastructure/repositories/transaction/transaction_keychain_builder.dart';
import 'package:aewallet/infrastructure/repositories/transaction/transaction_token_builder.dart';
import 'package:aewallet/infrastructure/repositories/transaction/transaction_transfer_builder.dart';
import 'package:aewallet/model/blockchain/keychain_secured_infos.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class ArchethicTransactionRepository
    implements TransactionRemoteRepositoryInterface {
  ArchethicTransactionRepository({
    required this.apiService,
  });

  final archethic.ApiService apiService;

  @override
  Future<Result<double, Failure>> calculateFees(
    Transaction transaction,
    int blockchainTxVersion,
  ) async {
    try {
      final transactionBuilt = await _buildTransaction(
        transaction,
        blockchainTxVersion,
      );

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
    int blockchainTxVersion,
  ) async {
    final originPrivateKey = apiService.getOriginKey();

    final keychain = transfer.keychainSecuredInfos.toKeychain();

    final indexMap = await apiService.getTransactionIndex(
      [transfer.genesisAddress],
    );

    final index = indexMap[transfer.genesisAddress] ?? 0;

    var tokenTransferList = <archethic.TokenTransfer>[];
    var ucoTransferList = <archethic.UCOTransfer>[];

    transfer.map(
      token: (token) {
        tokenTransferList = <archethic.TokenTransfer>[
          archethic.TokenTransfer(
            amount: archethic.toBigInt(token.amount),
            to: token.recipientAddress.address,
            tokenAddress: token.tokenAddress,
            tokenId: token.tokenId,
          ),
        ];
      },
      uco: (uco) {
        ucoTransferList = <archethic.UCOTransfer>[
          archethic.UCOTransfer(
            amount: archethic.toBigInt(uco.amount),
            to: uco.recipientAddress.address,
          ),
        ];
      },
    );

    return TransferTransactionBuilder.build(
      index: index,
      keychain: keychain,
      keyPair: archethic.KeyPair(
        privateKey: Uint8List.fromList(
          transfer.keychainSecuredInfos.services[transfer.accountSelectedName]!
              .keyPair!.privateKey,
        ),
        publicKey: Uint8List.fromList(
          transfer.keychainSecuredInfos.services[transfer.accountSelectedName]!
              .keyPair!.publicKey,
        ),
      ),
      originPrivateKey: originPrivateKey,
      serviceName: transfer.accountSelectedName,
      tokenTransferList: tokenTransferList,
      ucoTransferList: ucoTransferList,
      message: transfer.message,
      apiService: apiService,
      blockchainTxVersion: blockchainTxVersion,
    );
  }

  Future<archethic.Transaction> _buildTransactionToken(
    Token token,
    int blockchainTxVersion,
  ) async {
    final originPrivateKey = apiService.getOriginKey();
    final keychain = token.keychainSecuredInfos.toKeychain();

    final indexMap = await apiService.getTransactionIndex(
      [token.genesisAddress],
    );

    final index = indexMap[token.genesisAddress] ?? 0;

    return AddTokenTransactionBuilder.build(
      tokenName: token.name,
      tokenSymbol: token.symbol,
      tokenInitialSupply: token.initialSupply,
      tokenType: token.type,
      index: index,
      keychain: keychain,
      keyPair: archethic.KeyPair(
        privateKey: Uint8List.fromList(
          token.keychainSecuredInfos.services[token.accountSelectedName]!
              .keyPair!.privateKey,
        ),
        publicKey: Uint8List.fromList(
          token.keychainSecuredInfos.services[token.accountSelectedName]!
              .keyPair!.publicKey,
        ),
      ),
      originPrivateKey: originPrivateKey,
      serviceName: token.accountSelectedName,
      aeip: token.aeip,
      tokenProperties: token.properties,
      blockchainTxVersion: blockchainTxVersion,
    );
  }

  Future<archethic.Transaction> _buildTransactionKeychain(
    String seed,
    String nameAccount,
    int blockchainTxVersion,
  ) async {
    final originPrivateKey = apiService.getOriginKey();
    final keychain = await apiService.getKeychain(seed);

    final kDerivationPathWithoutIndex = "m/650'/$nameAccount/";
    const index = 0;
    final kDerivationPath = '$kDerivationPathWithoutIndex$index';

    return KeychainTransactionBuilder.build(
      keychain: keychain.copyWithService(nameAccount, kDerivationPath),
      originPrivateKey: originPrivateKey,
      apiService: apiService,
      blockchainTxVersion: blockchainTxVersion,
    );
  }

  @override
  Future<archethic.Transaction> buildTransactionRaw(
    KeychainSecuredInfos keychainSecuredInfos,
    archethic.Transaction transactionRaw,
    String address,
    String serviceName,
  ) async {
    final originPrivateKey = apiService.getOriginKey();

    final keychain = keychainSecuredInfos.toKeychain();

    final indexMap = await apiService.getTransactionIndex(
      [address],
    );

    final index = indexMap[address] ?? 0;

    final transactionSigned = keychain
        .buildTransaction(
          transactionRaw,
          serviceName,
          index,
        )
        .transaction
        .originSign(originPrivateKey);

    return transactionSigned;
  }

  Future<archethic.Transaction> _buildTransaction(
    Transaction transaction,
    int blockchainTxVersion,
  ) async {
    return await transaction.map(
      transfer: (transfer) async {
        return _buildTransactionTransfer(
          transfer.transfer,
          blockchainTxVersion,
        );
      },
      token: (token) async {
        return _buildTransactionToken(token.token, blockchainTxVersion);
      },
      keychain: (keychain) async {
        return _buildTransactionKeychain(
          keychain.seed,
          keychain.name,
          blockchainTxVersion,
        );
      },
    );
  }

  @override
  Future<archethic.TransactionConfirmation?> send({
    required Transaction transaction,
    required int blockchainTxVersion,
    Duration timeout = const Duration(seconds: 70),
    TransactionConfirmationHandler? onConfirmation,
  }) async =>
      sendSignedRaw(
        transaction: await _buildTransaction(
          transaction,
          blockchainTxVersion,
        ),
        timeout: timeout,
        onConfirmation: onConfirmation,
      );

  @override
  Future<archethic.TransactionConfirmation?> sendSignedRaw({
    required archethic.Transaction transaction,
    Duration timeout = const Duration(seconds: 70),
    TransactionConfirmationHandler? onConfirmation,
  }) =>
      archethic.ArchethicTransactionSender(
        apiService: apiService,
      ).send(
        timeout: timeout,
        transaction: transaction,
        onConfirmation: onConfirmation,
      );
}
