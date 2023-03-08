import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/add_service/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/get_accounts/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/get_endpoint/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/send_transaction/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/sub_account/command_handler.dart';
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
        GetEndpointHandler(),
      )
      ..addHandler(
        GetAccountsCommandHandler(),
      )
      ..addHandler(
        SubscribeAccountHandler(ref: ref),
      )
      ..addHandler(
        AddServicenHandler(context: context, ref: ref),
      );
    return child;
  }
}
