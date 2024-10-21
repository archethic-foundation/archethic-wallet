import 'package:aewallet/model/blockchain/keychain_secured_infos.dart';
import 'package:aewallet/model/blockchain/token_information.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/keychain_service_keypair.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

abstract class NFTRepository {
  Future<bool> isAccountOwner(
    String accountAddress,
    String tokenAddress,
    String tokenId,
    ApiService apiService,
  );

  Future<TokenInformation?> getNFTInfo(
    String address,
    KeychainServiceKeyPair keychainServiceKeyPair,
    AppService appService,
  );

  Future<(List<AccountToken>, List<AccountToken>)> getNFTList(
    String address,
    String nameAccount,
    KeychainSecuredInfos keychainSecuredInfos,
    AppService appService,
    ApiService apiService,
  );
}
