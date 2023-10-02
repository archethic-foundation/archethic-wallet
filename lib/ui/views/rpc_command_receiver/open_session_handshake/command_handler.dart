import 'package:aewallet/application/rpc_session/provider.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as aelib;
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OpenSessionHandshakeHandler extends CommandHandler<
    awc.OpenSessionHandshakeRequest, awc.OpenSessionHandshakeResponse> {
  OpenSessionHandshakeHandler({
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<awc.OpenSessionHandshakeRequest>,
          handle: (command) async {
            // command as RPCCommand<awc.OpenSessionHandshakeRequest>;

            final newSession =
                ref.read(RPCSessionProviders.sessionsService).startSession();

            return Result.success(
              awc.OpenSessionHandshakeResponse(
                sessionId: newSession.sessionId,
                aesKey: aelib.uint8ListToHex(
                  aelib.ecEncrypt(
                    aelib.uint8ListToHex(newSession.aesKey),
                    command.data.pubKey,
                  ),
                ),
              ),
            );
          },
        );
}
