import 'package:aewallet/domain/models/app_accounts.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/get_accounts.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/util/get_it_instance.dart';

class GetAccountsCommandHandler extends CommandHandler {
  GetAccountsCommandHandler()
      : super(
          canHandle: (command) =>
              command is RPCCommand<RPCGetAccountsCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCGetAccountsCommandData>;
            final _dbHelper = sl.get<DBHelper>();
            final appAccounts = await _dbHelper.getAccounts();
            final accounts = <AppAccount>[];
            for (final accountAppName in appAccounts) {
              accounts.add(
                AppAccount(
                  name: accountAppName.name,
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
