import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/settings.dart';
import 'package:aewallet/domain/rpc/command.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/material.dart';

class GetEndpointHandler
    extends CommandHandler<awc.GetEndpointRequest, awc.GetEndpointResult> {
  GetEndpointHandler()
      : super(
          canHandle: (command) => command is RPCCommand<awc.GetEndpointRequest>,
          handle: (command) async {
            command as RPCCommand<awc.GetEndpointRequest>;
            final settingsRepository = sl.get<SettingsRepositoryInterface>();

            final settings =
                await settingsRepository.getSettings(const Locale('en'));

            final endpointUrl = settings.network.getLink();

            return Result.success(
              awc.GetEndpointResult(endpointUrl: endpointUrl),
            );
          },
        );
}
