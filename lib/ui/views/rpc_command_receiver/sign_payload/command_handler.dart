import 'package:aewallet/application/api_service.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/window_util_desktop.dart'
    if (dart.library.js) 'package:aewallet/ui/util/window_util_web.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/sign_payload/layouts/sign_payload_confirmation_form.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

const slippage = 1.01;

class SignPayloadsCommandHandler extends CommandHandler {
  SignPayloadsCommandHandler({
    required BuildContext context,
    required WidgetRef ref,
  }) : super(
          canHandle: (command) => command is RPCCommand<awc.SignPayloadRequest>,
          handle: (command) async {
            final logger = Logger('RPCHandler - SignPayloads');
            command as RPCCommand<awc.SignPayloadRequest>;

            final signedPayloadsList = <awc.SignPayloadsResultDetail>[];
            final serviceName = command.data.serviceName;
            final pathSuffix = command.data.pathSuffix;
            final description = command.data.description;

            final seed =
                ref.read(sessionNotifierProvider).loggedIn!.wallet.seed;

            final apiService = ref.watch(apiServiceProvider);
            final keychain = await apiService.getKeychain(seed);

            var addressGenesis = '';
            try {
              addressGenesis = archethic.uint8ListToHex(
                keychain.deriveAddress(
                  serviceName,
                  pathSuffix: pathSuffix,
                ),
              );
            } catch (e) {
              return const Result.failure(
                awc.Failure.serviceNotFound,
              );
            }

            final indexMap = await apiService.getTransactionIndex(
              [addressGenesis],
            );

            var index = indexMap[addressGenesis] ?? 0;

            await WindowUtil().showFirst();

            final confirmation = await showDialog<bool>(
              useSafeArea: false,
              useRootNavigator: false,
              context: context,
              builder: (context) => Dialog.fullscreen(
                child: DecoratedBox(
                  decoration: ArchethicTheme.getDecorationSheet(),
                  child: SignPayloadConfirmationForm(
                    command,
                    description,
                  ),
                ),
              ),
            );

            if (confirmation == null || confirmation == false) {
              return const Result.failure(
                awc.Failure.userRejected,
              );
            }

            final keypair = keychain.deriveKeypair(
              serviceName,
              index: index,
              pathSuffix: pathSuffix,
            );

            logger.info(
              'Service pubkey : ${archethic.uint8ListToHex(keypair.publicKey!)}',
            );
            for (final rpcSignPayloadCommandData in command.data.payloads) {
              final payload = rpcSignPayloadCommandData.payload;
              final isHexa = rpcSignPayloadCommandData.isHexa;

              final signedPayload = archethic.sign(
                payload,
                keypair.privateKey,
                isDataHexa: isHexa,
              );

              final rpcSignPayloadResultDetailData =
                  awc.SignPayloadsResultDetail(
                signedPayload: archethic.uint8ListToHex(signedPayload),
              );

              signedPayloadsList.add(rpcSignPayloadResultDetailData);
              index++;
            }

            return Result.success(
              awc.SignPayloadsResult(signedPayloads: signedPayloadsList),
            );
          },
        );
}
