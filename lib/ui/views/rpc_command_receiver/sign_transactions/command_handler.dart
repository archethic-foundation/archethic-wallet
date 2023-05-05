import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/failure.dart';
import 'package:aewallet/domain/rpc/commands/sign_transactions.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/sign_transactions/layouts/sign_transactions_confirmation_form.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignTransactionsCommandHandler extends CommandHandler {
  SignTransactionsCommandHandler({
    required BuildContext context,
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

            final seed =
                ref.read(SessionProviders.session).loggedIn!.wallet.seed;

            final keychain =
                await sl.get<archethic.ApiService>().getKeychain(seed);

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

            final confirmation = await Sheets.showAppHeightNineSheet<bool>(
              context: context,
              ref: ref,
              widget: SignTransactionsConfirmationForm(
                command,
              ),
            );
            if (confirmation == null || confirmation == false) {
              return Result.failure(
                RPCFailure.userRejected(),
              );
            }

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
