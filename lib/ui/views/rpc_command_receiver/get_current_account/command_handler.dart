import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/domain/models/app_accounts.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/failure.dart';
import 'package:aewallet/domain/rpc/commands/get_current_account.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetCurrentAccountCommandHandler extends CommandHandler {
  GetCurrentAccountCommandHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<RPCGetCurrentAccountCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCGetCurrentAccountCommandData>;

            final selectedAccount =
                ref.read(AccountProviders.selectedAccount).valueOrNull;

            if (selectedAccount == null) {
              return Result.failure(
                RPCFailure.unknownAccount(),
              );
            }

            final account = AppAccount(
              name: selectedAccount.nameDisplayed,
              genesisAddress: selectedAccount.genesisAddress,
            );

            return Result.success(
              RPCGetCurrentAccountResultData(account: account),
            );
          },
        );
}
