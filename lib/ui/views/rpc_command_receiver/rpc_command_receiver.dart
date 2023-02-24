import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/settings.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/get_endpoint.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/send_transaction/command_handler.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RPCCommandReceiver extends ConsumerWidget {
  RPCCommandReceiver({
    super.key,
    required this.child,
  });

  static const logName = 'CommandHandler';
  final Widget child;

  final commandDispatcher = sl.get<CommandDispatcher>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    commandDispatcher
      ..addHandler(
        SendTransactionHandler(context: context, ref: ref),
      )
      ..addHandler(
        CommandHandler(
          canHandle: (command) =>
              command is RPCCommand<RPCGetEndpointCommandData>,
          handle: (command) async {
            command as RPCCommand<RPCGetEndpointCommandData>;
            final settingsRepository = sl.get<SettingsRepositoryInterface>();

            final settings =
                await settingsRepository.getSettings(const Locale('en'));

            final endpointUrl = settings.network.getLink();

            return Result.success(
              RPCGetEndpointResultData(endpoint: endpointUrl),
            );
          },
        ),
      );
    return child;
  }
}
