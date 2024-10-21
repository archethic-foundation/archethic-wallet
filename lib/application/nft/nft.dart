import 'package:aewallet/application/api_service.dart';
import 'package:aewallet/application/app_service.dart';
import 'package:aewallet/infrastructure/repositories/nft/nft.repository.dart';
import 'package:aewallet/model/blockchain/keychain_secured_infos.dart';
import 'package:aewallet/model/blockchain/token_information.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/keychain_service_keypair.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nft.g.dart';

@riverpod
NFTRepositoryImpl _nftRepository(_NftRepositoryRef ref) => NFTRepositoryImpl();

@riverpod
Future<TokenInformation?> _getNFTInfo(
  _GetNFTInfoRef ref,
  String address,
  KeychainServiceKeyPair keychainServiceKeyPair,
) async {
  final appService = ref.watch(appServiceProvider);
  return ref
      .watch(_nftRepositoryProvider)
      .getNFTInfo(address, keychainServiceKeyPair, appService);
}

@riverpod
Future<bool> _isAccountOwner(
  _IsAccountOwnerRef ref,
  String accountAddress,
  String tokenAddress,
  String tokenId,
) async {
  final apiService = ref.watch(apiServiceProvider);
  return ref.watch(_nftRepositoryProvider).isAccountOwner(
        accountAddress,
        tokenAddress,
        tokenId,
        apiService,
      );
}

@riverpod
Future<(List<AccountToken>, List<AccountToken>)> _getNFTList(
  _GetNFTListRef ref,
  String address,
  String nameAccount,
  KeychainSecuredInfos keychainSecuredInfos,
) async {
  final appService = ref.watch(appServiceProvider);
  final apiService = ref.watch(apiServiceProvider);
  return ref.watch(_nftRepositoryProvider).getNFTList(
        address,
        nameAccount,
        keychainSecuredInfos,
        appService,
        apiService,
      );
}

abstract class NFTProviders {
  static const getNFTInfo = _getNFTInfoProvider;
  static const getNFTList = _getNFTListProvider;
  static const isAccountOwner = _isAccountOwnerProvider;
}
