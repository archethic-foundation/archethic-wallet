import 'dart:developer';
import 'dart:ui';

import 'package:aewallet/domain/repositories/settings.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_get_endpoint_result.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:json_rpc_2/json_rpc_2.dart';

Function getEndpointWebsocketHandlerBuilder() => (Parameters params) async {
      const LOG_NAME = 'RPC Server : GetEndpointHandler';

      log('Received GetEndpoint', name: LOG_NAME);

      final settingsRepository = sl.get<SettingsRepositoryInterface>();

      final settings = await settingsRepository.getSettings(const Locale('en'));

      final endpointUrl = settings.network.getLink();

      return RpcGetEndpointResult(endpointUrl: endpointUrl);
    };
