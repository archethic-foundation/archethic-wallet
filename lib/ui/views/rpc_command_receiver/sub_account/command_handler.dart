import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/utils.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/failure.dart';
import 'package:aewallet/domain/rpc/commands/subscribe_account.dart';
import 'package:aewallet/domain/rpc/subscription.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final accountUpdateProvider = StreamProvider.autoDispose
    .family<Account?, String>((ref, serviceName) async* {
  yield await ref.watch(AccountProviders.account(serviceName).future);
});

class SubscribeAccountHandler extends CommandHandler {
  SubscribeAccountHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<RPCSubscribeAccountCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCSubscribeAccountCommandData>;

            final accountExists = await ref.read(
              AccountProviders.accountExists(command.data.serviceName).future,
            );
            if (!accountExists) {
              return Result.failure(RPCFailure.unknownAccount());
            }

            return Result.success(
              RPCSubscription(
                id: const Uuid().v4(),
                updates: ref.streamWithCurrentValue(
                  accountUpdateProvider(command.data.serviceName),
                ),
              ),
            );
          },
        );
}
