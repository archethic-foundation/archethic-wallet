import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/settings.dart';
import 'package:aewallet/domain/rpc/command_dispatcher.dart';
import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/domain/rpc/commands/get_endpoint.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter/material.dart';

class GetEndpointHandler extends CommandHandler {
  GetEndpointHandler()
      : super(
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
        );
}
