import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/utils.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/subscribe_current_account.dart';
import 'package:aewallet/domain/rpc/subscription.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final accountUpdateProvider = StreamProvider.autoDispose((ref) async* {
  yield await ref.watch(AccountProviders.selectedAccount.future);
});

class SubscribeCurrentAccountHandler extends CommandHandler {
  SubscribeCurrentAccountHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<RPCSubscribeCurrentAccountCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCSubscribeCurrentAccountCommandData>;

            return Result.success(
              RPCSubscription(
                id: const Uuid().v4(),
                updates: ref.streamWithCurrentValue(
                  accountUpdateProvider,
                ),
              ),
            );
          },
        );
}
