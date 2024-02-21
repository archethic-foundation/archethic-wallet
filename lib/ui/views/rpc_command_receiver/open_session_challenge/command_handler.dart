import 'dart:io';

import 'package:aewallet/application/rpc_session/provider.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/open_session_challenge/layouts/validate_session_form.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

class OpenSessionChallengeHandler extends CommandHandler<
    awc.OpenSessionChallengeRequest, awc.OpenSessionChallengeResponse> {
  OpenSessionChallengeHandler({
    required BuildContext context,
    required WidgetRef ref,
  }) : super(
          canHandle: (command) =>
              command is RPCCommand<awc.OpenSessionChallengeRequest>,
          handle: (command) async {
            command as RPCCommand<awc.OpenSessionChallengeRequest>;

            final session = await ref
                .read(RPCSessionProviders.sessionsService)
                .findOpeningSession(command.data.sessionId);

            if (session == null) {
              return const Result.failure(awc.Failure.invalidSession);
            }

            if (!kIsWeb &&
                (Platform.isLinux || Platform.isMacOS || Platform.isWindows)) {
              await windowManager.show();
            }

            final didUserValidateChallenge = await showDialog<bool>(
              useSafeArea: false,
              context: context,
              builder: (context) => Dialog.fullscreen(
                child: DecoratedBox(
                  decoration: ArchethicTheme.getDecorationSheet(),
                  child: ValidateSessionForm(
                    origin: command.data.origin,
                    challenge: command.data.challenge,
                  ),
                ),
              ),
            );

            if (didUserValidateChallenge == null ||
                didUserValidateChallenge != true) {
              ref
                  .read(RPCSessionProviders.sessionsService)
                  .invalidateSession(sessionId: command.data.sessionId);
              return const Result.failure(
                awc.Failure.userRejected,
              );
            }

            final validatedSession = await ref
                .read(RPCSessionProviders.sessionsService)
                .validateSession(
                  sessionId: command.data.sessionId,
                  origin: command.data.origin,
                );

            return Result.success(
              awc.OpenSessionChallengeResponse(
                createdAt: validatedSession.createdAt,
                sessionId: validatedSession.sessionId,
              ),
            );
          },
        );
}
