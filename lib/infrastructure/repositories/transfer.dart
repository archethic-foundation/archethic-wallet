import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/models/transfer.dart';
import 'package:aewallet/domain/repositories/transfer.dart';
import 'package:aewallet/infrastructure/repositories/transaction_builder.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/util/confirmations/transaction_sender.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

class ArchethicTransferRepository implements TransferRepositoryInterface {
  ArchethicTransferRepository({
    required this.phoenixHttpEndpoint,
    required this.websocketEndpoint,
  });

  archethic.ApiService? _apiService;
  archethic.ApiService get apiService =>
      _apiService ??= sl.get<archethic.ApiService>();

  final String phoenixHttpEndpoint;
  final String websocketEndpoint;

  @override
  Future<Result<double, Failure>> calculateFees(Transfer transfer) async {
    try {
      final transaction = await _buildTransaction(transfer);

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

  Future<archethic.Transaction> _buildTransaction(
    var transfer,
  ) async {
    final transferType = transfer.map(
      uco: (value) => TransferType.uco,
      token: (value) => TransferType.token,
    );

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
    switch (transferType) {
      case TransferType.token:
        tokenTransferList = <archethic.TokenTransfer>[
          archethic.TokenTransfer(
            amount: archethic.toBigInt(transfer.amount),
            to: transfer.recipientAddress.address,
            tokenAddress: transfer.tokenAddress,
            tokenId: 0,
          )
        ];
        break;
      case TransferType.uco:
        ucoTransferList = <archethic.UCOTransfer>[
          archethic.UCOTransfer(
            amount: archethic.toBigInt(transfer.amount),
            to: transfer.recipientAddress.address,
          )
        ];
        break;
      case TransferType.nft:
        // TODO(reddwarf03): Handle this case.
        break;
    }

    return TransferTransactionBuilder.build(
      message: transfer.message,
      index: index,
      keychain: keychain,
      originPrivateKey: originPrivateKey,
      serviceName: service,
      tokenTransferList: tokenTransferList,
      ucoTransferList: ucoTransferList,
    );
  }

  @override
  Future<void> send({
    required Transfer transfer,
    Duration timeout = const Duration(seconds: 10),
    required TransactionConfirmationHandler onConfirmation,
    required TransactionErrorHandler onError,
  }) async {
    final TransactionSenderInterface transactionSender =
        ArchethicTransactionSender(
      phoenixHttpEndpoint: phoenixHttpEndpoint,
      websocketEndpoint: websocketEndpoint,
    );

    final transaction = await _buildTransaction(transfer);
    transactionSender.send(
      transaction: transaction,
      onConfirmation: onConfirmation,
      onError: onError,
    );
  }
}
