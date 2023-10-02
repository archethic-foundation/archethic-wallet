import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetCurrentAccountCommandHandler extends CommandHandler<
    awc.GetCurrentAccountRequest, awc.GetCurrentAccountResult> {
  GetCurrentAccountCommandHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<awc.GetCurrentAccountRequest>,
          handle: (command) async {
            command as RPCCommand<awc.GetCurrentAccountRequest>;

            final selectedAccount =
                ref.read(AccountProviders.selectedAccount).valueOrNull;

            if (selectedAccount == null) {
              return const Result.failure(
                awc.Failure.unknownAccount,
              );
            }

            return Result.success(
              awc.GetCurrentAccountResult(
                serviceName: selectedAccount.name,
                shortName: selectedAccount.nameDisplayed,
                genesisAddress: selectedAccount.genesisAddress,
              ),
            );
          },
        );
}
