import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

class GetAccountsCommandHandler
    extends CommandHandler<awc.GetAccountsRequest, awc.GetAccountsResult> {
  GetAccountsCommandHandler()
      : super(
          canHandle: (command) => command is RPCCommand<awc.GetAccountsRequest>,
          handle: (command) async {
            final _dbHelper = sl.get<DBHelper>();
            final appAccounts = await _dbHelper.getAccounts();
            final accounts = <awc.AppAccount>[];
            for (final accountAppName in appAccounts) {
              accounts.add(
                awc.AppAccount(
                  serviceName: accountAppName.name,
                  shortName: accountAppName.nameDisplayed,
                  genesisAddress: accountAppName.genesisAddress,
                ),
              );
            }

            return Result.success(
              awc.GetAccountsResult(accounts: accounts),
            );
          },
        );
}
