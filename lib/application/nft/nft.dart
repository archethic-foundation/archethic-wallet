import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/model/keychain_service_keypair.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nft.g.dart';

@riverpod
NFTRepository _nftRepository(_NftRepositoryRef ref) => NFTRepository();

@riverpod
Future<TokenInformations?> _getNFT(
  _GetNFTRef ref,
  String address,
  KeychainServiceKeyPair keychainServiceKeyPair,
) async {
  return ref
      .watch(_nftRepositoryProvider)
      .getNFT(address, keychainServiceKeyPair);
}

class NFTRepository {
  Future<TokenInformations?> getNFT(
    String address,
    KeychainServiceKeyPair keychainServiceKeyPair,
  ) async {
    final tokenInformations =
        await sl.get<AppService>().getNFT(address, keychainServiceKeyPair);
    return tokenInformations;
  }
}

abstract class NFTProviders {
  static final getNFT = _getNFTProvider;
}
