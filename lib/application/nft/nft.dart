import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nft.g.dart';

@Riverpod(keepAlive: true)
NFTRepository _nftRepository(_NftRepositoryRef ref) => NFTRepository();

@Riverpod(keepAlive: true)
Future<TokenInformations?> _getNFT(
  _GetNFTRef ref,
  String address,
  String seed,
  String name,
) async {
  return ref.watch(_nftRepositoryProvider).getNFT(address, seed, name);
}

class NFTRepository {
  Future<TokenInformations?> getNFT(
    String address,
    String seed,
    String name,
  ) async {
    final tokenInformations =
        await sl.get<AppService>().getNFT(address, seed, name);
    return tokenInformations;
  }
}

abstract class NFTProviders {
  static final getNFT = _getNFTProvider;
}
