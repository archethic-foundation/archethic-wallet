import 'package:aewallet/model/blockchain/keychain_secured_infos.dart';
import 'package:aewallet/model/blockchain/token_information.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/keychain_service_keypair.dart';

abstract class NFTRepository {
  Future<bool> isAccountOwner(
    String accountAddress,
    String tokenAddress,
    String tokenId,
  );

  Future<TokenInformation?> getNFTInfo(
    String address,
    KeychainServiceKeyPair keychainServiceKeyPair,
  );

  Future<(List<AccountToken>, List<AccountToken>)> getNFTList(
    String address,
    String nameAccount,
    KeychainSecuredInfos keychainSecuredInfos,
  );
}
