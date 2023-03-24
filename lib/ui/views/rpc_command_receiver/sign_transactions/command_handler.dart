import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/sign_transactions.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/keychain_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignTransactionsCommandHandler extends CommandHandler {
  SignTransactionsCommandHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<RPCSignTransactionsCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCSignTransactionsCommandData>;

            final signedTransactionList =
                <RPCSignTransactionResultDetailData>[];
            final serviceName = command.data.serviceName;
            final pathSuffix = command.data.pathSuffix ?? '';

            final keychain = ref
                .read(SessionProviders.session)
                .loggedIn!
                .wallet
                .keychainSecuredInfos
                .toKeychain();

            final addressGenesis = archethic.uint8ListToHex(
              keychain.deriveAddress(
                serviceName,
                pathSuffix: pathSuffix,
              ),
            );

            final originPrivateKey =
                sl.get<archethic.ApiService>().getOriginKey();

            final indexMap =
                await sl.get<archethic.ApiService>().getTransactionIndex(
              [addressGenesis],
            );

            var index = indexMap[addressGenesis] ?? 0;

            for (final rpcSignTransactionCommandData
                in command.data.rpcSignTransactionCommandData) {
              final transaction = archethic.Transaction(
                type: rpcSignTransactionCommandData.type,
                data: rpcSignTransactionCommandData.data,
              );

              final signedTransaction = keychain
                  .buildTransaction(
                    transaction,
                    serviceName,
                    index,
                    pathSuffix: pathSuffix,
                  )
                  .originSign(originPrivateKey);

              final rpcSignTransactionResultDetailData =
                  RPCSignTransactionResultDetailData(
                address: signedTransaction.address!.address ?? '',
                originSignature: signedTransaction.originSignature ?? '',
                previousPublicKey: signedTransaction.previousPublicKey ?? '',
                previousSignature: signedTransaction.previousSignature ?? '',
              );

              signedTransactionList.add(rpcSignTransactionResultDetailData);
              index++;
            }

            return Result.success(
              RPCSignTransactionsResultData(signedTxs: signedTransactionList),
            );
          },
        );
}
