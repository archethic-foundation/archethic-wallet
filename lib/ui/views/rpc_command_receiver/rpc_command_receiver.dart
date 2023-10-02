import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/add_service/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/get_accounts/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/get_current_account/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/get_endpoint/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/get_services_from_keychain/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/keychain_derive_address/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/keychain_derive_keypair/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/open_session_challenge/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/open_session_handshake/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/refresh_current_account/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/send_transaction/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/sign_transactions/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/sub_account/command_handler.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/sub_current_account/command_handler.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RPCCommandReceiver extends ConsumerStatefulWidget {
  const RPCCommandReceiver({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RPCCommandReceiverState();
}

class _RPCCommandReceiverState extends ConsumerState<RPCCommandReceiver> {
  @override
  void initState() {
    sl.get<CommandBus>()
      ..clear()
      ..addGuard((command) async {
        if (ref.read(SessionProviders.session).isLoggedOut) {
          return awc.Failure.connectivity;
        }
        return null;
      })
      ..addHandler(
        SendTransactionHandler(
          context: context,
        ),
      )
      ..addHandler(
        GetEndpointHandler(),
      )
      ..addHandler(
        RefreshCurrentAccountHandler(ref: ref),
      )
      ..addHandler(
        GetCurrentAccountCommandHandler(ref: ref),
      )
      ..addHandler(
        GetAccountsCommandHandler(),
      )
      ..addHandler(
        SubscribeAccountHandler(ref: ref),
      )
      ..addHandler(
        SubscribeCurrentAccountHandler(ref: ref),
      )
      ..addHandler(
        AddServiceHandler(context: context, ref: ref),
      )
      ..addHandler(
        GetServicesFromKeychainCommandHandler(ref: ref),
      )
      ..addHandler(
        KeychainDeriveKeypairCommandHandler(ref: ref),
      )
      ..addHandler(
        KeychainDeriveAddressCommandHandler(ref: ref),
      )
      ..addHandler(
        SignTransactionsCommandHandler(context: context, ref: ref),
      )
      ..addHandler(
        OpenSessionHandshakeHandler(ref: ref),
      )
      ..addHandler(
        OpenSessionChallengeHandler(context: context, ref: ref),
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
