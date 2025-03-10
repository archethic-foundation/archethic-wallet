import 'package:aewallet/model/data/account.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

extension AccountToRPC on Account {
  awc.Account get toRPC => awc.Account(
        genesisAddress: genesisAddress,
        name: name,
      );
}
