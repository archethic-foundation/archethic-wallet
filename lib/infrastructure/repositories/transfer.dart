import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transfer.dart';
import 'package:aewallet/domain/repositories/transfer.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/bloc/transaction_builder.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class ArchethicTransferRepository implements TransferRepositoryInterface {
  archethic.ApiService? _apiService;
  archethic.ApiService get apiService =>
      _apiService ??= sl.get<archethic.ApiService>();

  @override
  Future<Result<double, Failure>> calculateFees(Transfer transfer) async {
    try {
      final transaction = await _buildTransaction(
        seed: transfer.seed,
        accountSelectedName: transfer.accountSelectedName,
        amount: transfer.amount,
        message: transfer.message,
        transferType: transfer.map(
          uco: (_) => TransferType.uco,
        ),
        recipientAddress: transfer.recipientAddress.address,
        tokenAddress: transfer.tokenAddress,
      );

      final transactionFee = await apiService.getTransactionFee(
        transaction,
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

  Future<archethic.Transaction> _buildTransaction({
    required String seed,
    required String accountSelectedName,
    required String message,
    required TransferType transferType,
    required double amount,
    required String recipientAddress,
    String? tokenAddress,
  }) async {
    final originPrivateKey = apiService.getOriginKey();
    final keychain = await apiService.getKeychain(seed);

    final nameEncoded = Uri.encodeFull(
      accountSelectedName,
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

    return TransferTransactionBuilder.build(
      message: message,
      index: index,
      keychain: keychain,
      originPrivateKey: originPrivateKey,
      serviceName: service,
      tokenTransferList: transferType == TransferType.token
          ? <archethic.TokenTransfer>[
              archethic.TokenTransfer(
                amount: archethic.toBigInt(amount),
                to: recipientAddress,
                tokenAddress: tokenAddress,
                tokenId: 0,
              )
            ]
          : transferType == TransferType.nft
              ? <archethic.TokenTransfer>[
                  archethic.TokenTransfer(
                    amount: archethic.toBigInt(amount),
                    to: recipientAddress,
                    tokenAddress: tokenAddress,
                    // TODO(reddwarf03): to fix nft management
                    tokenId: 0,
                  )
                ]
              : <archethic.TokenTransfer>[],
      ucoTransferList: transferType == TransferType.uco
          ? <archethic.UCOTransfer>[
              archethic.UCOTransfer(
                amount: archethic.toBigInt(amount),
                to: recipientAddress,
              )
            ]
          : <archethic.UCOTransfer>[],
    );
  }
}
