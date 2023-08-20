import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:typed_data';

import 'package:aewallet/model/blockchain/keychain_secured_infos.dart';
import 'package:aewallet/model/blockchain/token_informations.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/keychain_service_keypair.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
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

@riverpod
Future<(List<AccountToken>, List<AccountToken>)> _getNFTList(
  _GetNFTListRef ref,
  String address,
  String name,
  KeychainSecuredInfos keychainSecuredInfos,
) async {
  return ref
      .watch(_nftRepositoryProvider)
      .getNFTList(address, name, keychainSecuredInfos);
}

class NFTRepository {
  Future<TokenInformations?> getNFT(
    String address,
    KeychainServiceKeyPair keychainServiceKeyPair,
  ) async {
    final tokenMap = await sl.get<AppService>().getToken(
      [address],
    );

    if (tokenMap.isEmpty ||
        tokenMap[address] == null ||
        tokenMap[address]!.type != 'non-fungible') {
      return null;
    }

    final token = tokenMap[address]!;

    final tokenWithoutFile = {...token.properties}
      ..removeWhere((key, value) => key == 'content');

    if (token.ownerships != null && token.ownerships!.isNotEmpty) {
      tokenWithoutFile.addAll(
        _tokenPropertiesDecryptedSecret(
          keypair: keychainServiceKeyPair,
          ownerships: token.ownerships!,
        ),
      );
    }
    final tokenInformations = TokenInformations(
      address: address,
      name: token.name,
      id: token.id,
      type: token.type,
      decimals: token.decimals,
      supply: fromBigInt(token.supply).toDouble(),
      symbol: token.symbol,
      tokenProperties: tokenWithoutFile,
      tokenCollection: token.collection,
    );
    return tokenInformations;
  }

  Future<(List<AccountToken>, List<AccountToken>)> getNFTList(
    String address,
    String name,
    KeychainSecuredInfos keychainSecuredInfos,
  ) async {
    final balanceMap = await sl.get<ApiService>().fetchBalance([address]);
    final balance = balanceMap[address];
    final nftList = <AccountToken>[];
    final nftCollectionList = <AccountToken>[];

    final tokenAddressList = <String>[];
    if (balance == null) {
      return (<AccountToken>[], <AccountToken>[]);
    }

    for (final tokenBalance in balance.token) {
      if (tokenBalance.address != null) {
        tokenAddressList.add(tokenBalance.address!);
      }
    }

    final tokenMap = await sl.get<ApiService>().getToken(
          tokenAddressList.toSet().toList(),
        );

    // TODO(reddwarf03): temporaly section -> need https://github.com/archethic-foundation/archethic-node/issues/714

    final secretMap = await sl.get<ApiService>().getTransaction(
          tokenAddressList.toSet().toList(),
          request:
              'data { ownerships { authorizedPublicKeys { encryptedSecretKey, publicKey } secret }  }',
        );

    final nftCollectionMap = <String, dynamic>{};
    for (final tokenBalance in balance.token) {
      final token = tokenMap[tokenBalance.address];
      if (token != null && token.type == 'non-fungible') {
        if (secretMap[tokenBalance.address] != null &&
            secretMap[tokenBalance.address]!.data != null &&
            secretMap[tokenBalance.address]!.data!.ownerships.isNotEmpty) {
          token.properties.addAll(
            _tokenPropertiesDecryptedSecret(
              keypair: keychainSecuredInfos.services[name]!.keyPair!,
              ownerships: secretMap[tokenBalance.address]!.data!.ownerships,
            ),
          );
        }

        final collectionWithTokenId = <Map<String, dynamic>>[];
        var numTokenId = 1;
        for (final collection in token.collection) {
          collection['id'] = numTokenId.toString();
          numTokenId++;
          collectionWithTokenId.add(collection);
        }

        final tokenInformations = TokenInformations(
          address: tokenBalance.address,
          name: token.name,
          id: token.id,
          aeip: token.aeip,
          type: token.type,
          supply: fromBigInt(token.supply).toDouble(),
          symbol: token.symbol,
          decimals: token.decimals,
          tokenCollection: collectionWithTokenId,
          tokenProperties: token.properties,
        );

        if (tokenInformations.tokenCollection != null &&
            tokenInformations.tokenCollection!.isNotEmpty) {
          final accountNFT = AccountToken(
            tokenInformations: tokenInformations,
            amount: fromBigInt(tokenBalance.amount).toDouble(),
          );
          nftCollectionMap[tokenInformations.address!] = accountNFT;
        } else {
          final accountNFTCollection = AccountToken(
            tokenInformations: tokenInformations,
            amount: fromBigInt(tokenBalance.amount).toDouble(),
          );
          nftList.add(accountNFTCollection);
        }
      }
    }
    nftList.sort(
      (a, b) =>
          a.tokenInformations!.name!.compareTo(b.tokenInformations!.name!),
    );
    nftCollectionMap.forEach((key, value) {
      nftCollectionList.add(value);
    });

    nftCollectionList.sort(
      (a, b) =>
          a.tokenInformations!.name!.compareTo(b.tokenInformations!.name!),
    );
    return (nftList, nftCollectionList);
  }

  Map<String, dynamic> _tokenPropertiesDecryptedSecret({
    required KeychainServiceKeyPair keypair,
    required List<Ownership> ownerships,
  }) {
    final propertiesDecrypted = <String, dynamic>{};
    for (final ownership in ownerships) {
      final authorizedPublicKey = ownership.authorizedPublicKeys.firstWhere(
        (AuthorizedKey authKey) =>
            authKey.publicKey!.toUpperCase() ==
            uint8ListToHex(Uint8List.fromList(keypair.publicKey)).toUpperCase(),
        orElse: AuthorizedKey.new,
      );
      if (authorizedPublicKey.encryptedSecretKey != null) {
        final aesKey = ecDecrypt(
          authorizedPublicKey.encryptedSecretKey,
          Uint8List.fromList(keypair.privateKey),
        );
        final decryptedSecret = aesDecrypt(ownership.secret, aesKey);
        try {
          propertiesDecrypted.addAll(json.decode(utf8.decode(decryptedSecret)));
        } catch (e) {
          dev.log('Decryption error $e');
        }
      }
    }
    return propertiesDecrypted;
  }
}

abstract class NFTProviders {
  static const getNFT = _getNFTProvider;
  static const getNFTList = _getNFTListProvider;
}
