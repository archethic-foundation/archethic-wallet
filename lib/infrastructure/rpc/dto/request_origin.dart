import 'package:aewallet/domain/rpc/commands/command.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

extension RequestOriginToModel on awc.RequestOrigin {
  RPCCommandOrigin get toModel => RPCCommandOrigin(name: name);
}
