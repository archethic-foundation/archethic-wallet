import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:aewallet/infrastructure/rpc/dto/request_origin.dart';
import 'package:aewallet/infrastructure/rpc/dto/rpc_command_handler.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

class RPCSubscribeCurrentAccountCommandHandler extends RPCSubscriptionHandler<
    awc.SubscribeCurrentAccountRequest, awc.Account> {
  @override
  RPCCommand<awc.SubscribeCurrentAccountRequest> commandToModel(
    awc.Request dto,
  ) =>
      RPCCommand(
        origin: dto.origin.toModel,
        data: const awc.SubscribeCurrentAccountRequest(),
      );

  @override
  Map<String, dynamic> notificationFromModel(covariant awc.Account? model) {
    final modelNotNull = model ??
        const awc.Account(
          genesisAddress: '',
          name: '',
        );
    return {
      'name': _getShortName(modelNotNull.name),
      'genesisAddress': modelNotNull.genesisAddress,
    };
  }

  String _getShortName(String name) {
    var result = name;
    if (name.startsWith('archethic-wallet-')) {
      result = result.replaceFirst('archethic-wallet-', '');
    }
    if (name.startsWith('aeweb-')) {
      result = result.replaceFirst('aeweb-', '');
    }

    return Uri.decodeFull(
      result,
    );
  }
}
