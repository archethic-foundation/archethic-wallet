import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/utils.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final accountUpdateProvider = StreamProvider.autoDispose((ref) async* {
  yield await ref.watch(AccountProviders.selectedAccount.future);
});

class SubscribeCurrentAccountHandler extends CommandHandler<
    awc.SubscribeCurrentAccountRequest, awc.Subscription<awc.Account?>> {
  SubscribeCurrentAccountHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<awc.SubscribeCurrentAccountRequest>,
          handle: (command) async {
            command as RPCCommand<awc.SubscribeCurrentAccountRequest>;

            return Result.success(
              awc.Subscription(
                id: const Uuid().v4(),
                updates: ref
                    .streamWithCurrentValue(
                      accountUpdateProvider,
                    )
                    .distinct()
                    .map(
                      (account) => account == null
                          ? null
                          : awc.SubscribeAccountNotification(
                              genesisAddress: account.genesisAddress,
                              name: account.name,
                              balance: account.balance == null
                                  ? null
                                  : awc.AccountBalance(
                                      nativeTokenName:
                                          account.balance!.nativeTokenName,
                                      nativeTokenValue:
                                          account.balance!.nativeTokenValue,
                                    ),
                            ),
                    ),
              ),
            );
          },
        );
}
