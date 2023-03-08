/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:typed_data';

import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/token.dart';
import 'package:aewallet/domain/models/transaction.dart';
import 'package:aewallet/domain/models/transfer.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/infrastructure/repositories/transaction_keychain_builder.dart';
import 'package:aewallet/infrastructure/repositories/transaction_token_builder.dart';
import 'package:aewallet/infrastructure/repositories/transaction_transfer_builder.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/recent_transaction.dart';
import 'package:aewallet/model/keychain_secured_infos.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/confirmations/transaction_sender.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class ArchethicTransactionRepository
    implements TransactionRemoteRepositoryInterface {
  ArchethicTransactionRepository({
    required this.phoenixHttpEndpoint,
    required this.websocketEndpoint,
  });

  archethic.ApiService? _apiService;
  archethic.ApiService get apiService =>
      _apiService ??= sl.get<archethic.ApiService>();

  archethic.AddressService? __addressService;
  archethic.AddressService get _addressService =>
      __addressService ??= sl.get<archethic.AddressService>();

  final AppService _appService = sl.get<AppService>();

  final String phoenixHttpEndpoint;
  final String websocketEndpoint;

  @override
  Future<String> getLastTransactionAddress({
    required String genesisAddress,
  }) async {
    final lastAddressFromAddressMap =
        await _addressService.lastAddressFromAddress(
      [genesisAddress],
    );
    return (lastAddressFromAddressMap.isEmpty ||
            lastAddressFromAddressMap[genesisAddress] == null)
        ? genesisAddress
        : lastAddressFromAddressMap[genesisAddress]!;
  }

  @override
  Future<Result<List<RecentTransaction>, Failure>> getRecentTransactions({
    required Account account,
    required KeychainSecuredInfos keychainSecuredInfos,
  }) async {
    return Result.guard(
      () async {
        return _appService.getAccountRecentTransactions(
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

    final nameEncoded = Uri.encodeFull(
      transfer.accountSelectedName,
    );
    final service = 'archethic-wallet-$nameEncoded';
    final keychain = transfer.keychainSecuredInfos.toKeychain();

    final indexMap = await apiService.getTransactionIndex(
      [transfer.transactionLastAddress],
    );

    final index = indexMap[transfer.transactionLastAddress] ?? 0;

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
      keyPair: archethic.KeyPair(
        privateKey: Uint8List.fromList(
          transfer.keychainSecuredInfos.services[service]!.keyPair!.privateKey,
        ),
        publicKey: Uint8List.fromList(
          transfer.keychainSecuredInfos.services[service]!.keyPair!.publicKey,
        ),
      ),
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
    final keychain = token.keychainSecuredInfos.toKeychain();

    final nameEncoded = Uri.encodeFull(
      token.accountSelectedName,
    );
    final service = 'archethic-wallet-$nameEncoded';

    final indexMap = await apiService.getTransactionIndex(
      [token.transactionLastAddress],
    );

    final index = indexMap[token.transactionLastAddress] ?? 0;

    return AddTokenTransactionBuilder.build(
      tokenName: token.name,
      tokenSymbol: token.symbol,
      tokenInitialSupply: token.initialSupply,
      tokenType: token.type,
      index: index,
      keychain: keychain,
      keyPair: archethic.KeyPair(
        privateKey: Uint8List.fromList(
          token.keychainSecuredInfos.services[service]!.keyPair!.privateKey,
        ),
        publicKey: Uint8List.fromList(
          token.keychainSecuredInfos.services[service]!.keyPair!.publicKey,
        ),
      ),
      originPrivateKey: originPrivateKey,
      serviceName: service,
      aeip: token.aeip,
      tokenProperties: token.properties,
    );
  }

  Future<archethic.Transaction> _buildTransactionKeychain(
    String seed,
    String nameAccount,
  ) async {
    final originPrivateKey = apiService.getOriginKey();
    final keychain = await apiService.getKeychain(seed);

    final nameEncoded = Uri.encodeFull(
      nameAccount,
    );
    final kServiceName = 'archethic-wallet-$nameEncoded';
    final kDerivationPathWithoutIndex = "m/650'/$kServiceName/";
    const index = 0;
    final kDerivationPath = '$kDerivationPathWithoutIndex$index';

    return KeychainTransactionBuilder.build(
      keychain: keychain.copyWithService(kServiceName, kDerivationPath),
      originPrivateKey: originPrivateKey,
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
    final TransactionSenderInterface transactionSender =
        ArchethicTransactionSender(
      phoenixHttpEndpoint: phoenixHttpEndpoint,
      websocketEndpoint: websocketEndpoint,
    );
    // ignore: cascade_invocations
    transactionSender.send(
      transaction: await _buildTransaction(transaction),
      onConfirmation: onConfirmation,
      onError: onError,
    );
  }
}
