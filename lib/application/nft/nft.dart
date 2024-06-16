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
  return ref
      .watch(_nftRepositoryProvider)
      .getNFTInfo(address, keychainServiceKeyPair);
}

@riverpod
Future<bool> _isAccountOwner(
  _IsAccountOwnerRef ref,
  String accountAddress,
  String tokenAddress,
  String tokenId,
) async {
  return ref
      .watch(_nftRepositoryProvider)
      .isAccountOwner(accountAddress, tokenAddress, tokenId);
}

@riverpod
Future<(List<AccountToken>, List<AccountToken>)> _getNFTList(
  _GetNFTListRef ref,
  String address,
  String nameAccount,
  KeychainSecuredInfos keychainSecuredInfos,
) async {
  return ref
      .watch(_nftRepositoryProvider)
      .getNFTList(address, nameAccount, keychainSecuredInfos);
}

abstract class NFTProviders {
  static const getNFTInfo = _getNFTInfoProvider;
  static const getNFTList = _getNFTListProvider;
  static const isAccountOwner = _isAccountOwnerProvider;
}
