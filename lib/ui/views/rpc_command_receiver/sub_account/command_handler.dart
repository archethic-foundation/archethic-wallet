import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/utils.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/subscribe_account.dart';
import 'package:aewallet/domain/rpc/subscription.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class SubscribeAccountHandler extends CommandHandler {
  SubscribeAccountHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<RPCSubscribeAccountCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCSubscribeAccountCommandData>;

            return Result.success(
              RPCSubscription(
                id: const Uuid().v4(),
                updates: ref.stream(
                  AccountProviders.account(command.data.accountName).future,
                ),
              ),
            );
          },
        );
}
