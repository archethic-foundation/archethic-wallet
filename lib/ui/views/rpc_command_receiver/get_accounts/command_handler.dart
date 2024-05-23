import 'package:aewallet/domain/models/app_accounts.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/get_accounts.dart';
import 'package:aewallet/infrastructure/datasources/account.hive.dart';

class GetAccountsCommandHandler extends CommandHandler {
  GetAccountsCommandHandler()
      : super(
          canHandle: (command) =>
              command is RPCCommand<RPCGetAccountsCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCGetAccountsCommandData>;
            final accountDatasource = AccountHiveDatasource.instance();
            final appAccounts = await accountDatasource.getAccounts();
            final accounts = <AppAccount>[];
            for (final accountAppName in appAccounts) {
              accounts.add(
                AppAccount(
                  serviceName: accountAppName.name,
                  shortName: accountAppName.nameDisplayed,
                  genesisAddress: accountAppName.genesisAddress,
                ),
              );
            }

            return Result.success(
              RPCGetAccountsResultData(accounts: accounts),
            );
          },
        );
}
