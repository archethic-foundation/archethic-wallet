import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/utils.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final accountUpdateProvider = StreamProvider.autoDispose
    .family<Account?, String>((ref, serviceName) async* {
  yield await ref.watch(AccountProviders.account(serviceName).future);
});

class SubscribeAccountHandler extends CommandHandler<
    awc.SubscribeAccountRequest,
    awc.Subscription<awc.SubscribeAccountNotification>> {
  SubscribeAccountHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<awc.SubscribeAccountRequest>,
          handle: (command) async {
            command as RPCAuthenticatedCommand<awc.SubscribeAccountRequest>;

            final accountExists = await ref.read(
              AccountProviders.accountExists(command.data.serviceName).future,
            );
            if (!accountExists) {
              return const Result.failure(awc.Failure.unknownAccount);
            }

            return Result.success(
              awc.Subscription(
                id: const Uuid().v4(),
                updates: ref
                    .streamWithCurrentValue(
                      accountUpdateProvider(command.data.serviceName),
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
