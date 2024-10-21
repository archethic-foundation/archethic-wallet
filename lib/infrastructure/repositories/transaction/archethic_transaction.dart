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
import 'package:aewallet/model/blockchain/recent_transaction.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class ArchethicTransactionRepository
    implements TransactionRemoteRepositoryInterface {
  ArchethicTransactionRepository({
    required this.phoenixHttpEndpoint,
    required this.websocketEndpoint,
    required this.appService,
    required this.apiService,
    required this.addressService,
  });

  final String phoenixHttpEndpoint;
  final String websocketEndpoint;
  final AppService appService;
  final archethic.ApiService apiService;
  final archethic.AddressService addressService;

  @override
  Future<String> getLastTransactionAddress({
    required String genesisAddress,
  }) async {
    final lastAddressFromAddressMap =
        await addressService.lastAddressFromAddress(
      [genesisAddress],
    );
    return (lastAddressFromAddressMap.isEmpty ||
            lastAddressFromAddressMap[genesisAddress] == null)
        ? genesisAddress
        : lastAddressFromAddressMap[genesisAddress]!;
  }

  // TODO(chralu): Clarify the usage
  @override
  Future<Result<List<RecentTransaction>, Failure>> getRecentTransactions({
    required Account account,
    required KeychainSecuredInfos keychainSecuredInfos,
  }) async {
    return Result.guard(
      () async {
        return appService.getAccountRecentTransactions(
          account.genesisAddress,
          account.lastAddress!,
          account.name,
          keychainSecuredInfos,
          account.recentTransactions ?? [],
        );
      },
    );
  }

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

    final keychain = transfer.keychainSecuredInfos.toKeychain();

    final indexMap = await apiService.getTransactionIndex(
      [transfer.transactionLastAddress],
    );

    final index = indexMap[transfer.transactionLastAddress] ?? 0;

    final blockchainTxVersion = int.parse(
      (await apiService.getBlockchainVersion()).version.transaction,
    );

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
      txVersion: blockchainTxVersion,
      apiService: apiService,
    );
  }

  Future<archethic.Transaction> _buildTransactionToken(
    Token token,
  ) async {
    final originPrivateKey = apiService.getOriginKey();
    final keychain = token.keychainSecuredInfos.toKeychain();

    final indexMap = await apiService.getTransactionIndex(
      [token.transactionLastAddress],
    );

    final index = indexMap[token.transactionLastAddress] ?? 0;

    final blockchainTxVersion = int.parse(
      (await apiService.getBlockchainVersion()).version.transaction,
    );

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
      txVersion: blockchainTxVersion,
    );
  }

  Future<archethic.Transaction> _buildTransactionKeychain(
    String seed,
    String nameAccount,
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
    );
  }

  @override
  Future<archethic.Transaction> buildTransactionRaw(
    KeychainSecuredInfos keychainSecuredInfos,
    archethic.Transaction transactionRaw,
    String transactionLastAddress,
    String serviceName,
  ) async {
    final originPrivateKey = apiService.getOriginKey();

    final keychain = keychainSecuredInfos.toKeychain();

    final indexMap = await apiService.getTransactionIndex(
      [transactionLastAddress],
    );

    final index = indexMap[transactionLastAddress] ?? 0;

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
  ) async {
    return await transaction.map(
      transfer: (transfer) async {
        return _buildTransactionTransfer(transfer.transfer);
      },
      token: (token) async {
        return _buildTransactionToken(token.token);
      },
      keychain: (keychain) async {
        return _buildTransactionKeychain(keychain.seed, keychain.name);
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
    final transactionSender = archethic.ArchethicTransactionSender(
      phoenixHttpEndpoint: phoenixHttpEndpoint,
      websocketEndpoint: websocketEndpoint,
      apiService: apiService,
    );

    await transactionSender.send(
      timeout: timeout,
      transaction: await _buildTransaction(transaction),
      onConfirmation: (transactionConfirmation) => onConfirmation(
        transactionSender,
        transactionConfirmation,
      ),
      onError: (error) => onError(
        transactionSender,
        error,
      ),
    );
  }

  @override
  Future<void> sendSignedRaw({
    required archethic.Transaction transactionSignedRaw,
    Duration timeout = const Duration(seconds: 10),
    required TransactionConfirmationHandler onConfirmation,
    required TransactionErrorHandler onError,
  }) async {
    final transactionSender = archethic.ArchethicTransactionSender(
      phoenixHttpEndpoint: phoenixHttpEndpoint,
      websocketEndpoint: websocketEndpoint,
      apiService: apiService,
    );

    await transactionSender.send(
      timeout: timeout,
      transaction: transactionSignedRaw,
      onConfirmation: (transactionConfirmation) => onConfirmation(
        transactionSender,
        transactionConfirmation,
      ),
      onError: (error) => onError(
        transactionSender,
        error,
      ),
    );
  }
}
