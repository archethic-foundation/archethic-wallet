import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:typed_data';

import 'package:aewallet/model/blockchain/keychain_secured_infos.dart';
import 'package:aewallet/model/blockchain/token_information.dart';
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

class NFTRepository {
  Future<bool> isAccountOwner(
    String accountAddress,
    String tokenAddress,
    String tokenId,
  ) async {
    final accountLastAddressMap =
        await sl.get<ApiService>().getLastTransaction([accountAddress]);
    var accounLastAddress = '';
    if (accountLastAddressMap[accountAddress] == null ||
        accountLastAddressMap[accountAddress]!.address == null ||
        accountLastAddressMap[accountAddress]!.address!.address == null) {
      accounLastAddress = accountAddress;
    } else {
      accounLastAddress =
          accountLastAddressMap[accountAddress]!.address!.address!;
    }

    final accountLastInputsMap =
        await sl.get<ApiService>().getTransactionInputs(
      [accounLastAddress],
      request: 'amount, from, tokenAddress, spent, timestamp, type, tokenId',
    );

    if (accountLastInputsMap[accounLastAddress] == null) {
      return false;
    }

    final _tokenId = int.tryParse(tokenId);

    final accountLastInputs = accountLastInputsMap[accounLastAddress];
    for (final input in accountLastInputs!) {
      if (_tokenId == null) {
        if (input.tokenAddress == tokenAddress) {
          return true;
        }
      } else {
        if (input.tokenAddress == tokenAddress && input.tokenId == _tokenId) {
          return true;
        }
      }
    }

    return false;
  }

  Future<TokenInformation?> getNFTInfo(
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

    final tokenProperties = {...token.properties};

    if (token.ownerships != null && token.ownerships!.isNotEmpty) {
      tokenProperties.addAll(
        _tokenPropertiesDecryptedSecret(
          keypair: keychainServiceKeyPair,
          ownerships: token.ownerships!,
        ),
      );
    }
    final tokenInformation = TokenInformation(
      address: address,
      name: token.name,
      id: token.id,
      type: token.type,
      decimals: token.decimals,
      supply: fromBigInt(token.supply).toDouble(),
      symbol: token.symbol,
      tokenProperties: tokenProperties,
      tokenCollection: token.collection,
    );
    return tokenInformation;
  }

  Future<(List<AccountToken>, List<AccountToken>)> getNFTList(
    String address,
    String nameAccount,
    KeychainSecuredInfos keychainSecuredInfos,
  ) async {
    final balanceMap = await sl.get<ApiService>().fetchBalance([address]);
    final balance = balanceMap[address];
    final nftList = <AccountToken>[];
    final nftCollectionList = <AccountToken>[];

    final tokenAddressList = <String>[];
    if (balance == null) {
      return (nftList, nftCollectionList);
    }

    for (final tokenBalance in balance.token) {
      if (tokenBalance.address != null) {
        tokenAddressList.add(tokenBalance.address!);
      }
    }

    final tokenMap = await sl.get<AppService>().getToken(
          tokenAddressList.toSet().toList(),
        );

    // TODO(reddwarf03): temporaly section -> need https://github.com/archethic-foundation/archethic-node/issues/714

    final secretMap = await sl.get<ApiService>().getTransaction(
          tokenAddressList.toSet().toList(),
          request:
              'data { ownerships { authorizedPublicKeys { encryptedSecretKey, publicKey } secret }  }',
        );

    for (final tokenBalance in balance.token) {
      final token = tokenMap[tokenBalance.address];

      if (token == null || token.type != 'non-fungible') {
        continue;
      }

      final newProperties = {...token.properties};

      if (secretMap[tokenBalance.address] != null &&
          secretMap[tokenBalance.address]!.data != null &&
          secretMap[tokenBalance.address]!.data!.ownerships.isNotEmpty) {
        newProperties.addAll(
          _tokenPropertiesDecryptedSecret(
            keypair: keychainSecuredInfos.services[nameAccount]!.keyPair!,
            ownerships: secretMap[tokenBalance.address]!.data!.ownerships,
          ),
        );
      }

      final collectionWithTokenId = <Map<String, dynamic>>[];
      var numTokenId = 1;
      for (final collection in token.collection) {
        final nftCollection = balance.token
            .where((element) => element.address == tokenBalance.address);
        if (nftCollection.any((element) => element.tokenId == numTokenId)) {
          collection['id'] = numTokenId.toString();
          collectionWithTokenId.add(collection);
        }

        numTokenId++;
      }

      final tokenInformation = TokenInformation(
        address: tokenBalance.address,
        name: token.name,
        id: token.id,
        aeip: token.aeip,
        type: token.type,
        supply: fromBigInt(token.supply).toDouble(),
        symbol: token.symbol,
        decimals: token.decimals,
        tokenCollection: collectionWithTokenId,
        tokenProperties: newProperties,
      );

      final accountToken = AccountToken(
        tokenInformation: tokenInformation,
        amount: fromBigInt(tokenBalance.amount).toDouble(),
      );

      if (tokenInformation.tokenCollection != null &&
          tokenInformation.tokenCollection!.isNotEmpty) {
        nftCollectionList.add(accountToken);
      } else {
        nftList.add(accountToken);
      }
    }
    nftList.sort(
      (a, b) => a.tokenInformation!.name!.compareTo(b.tokenInformation!.name!),
    );
    nftCollectionList.sort(
      (a, b) => a.tokenInformation!.name!.compareTo(b.tokenInformation!.name!),
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
  static const getNFTInfo = _getNFTInfoProvider;
  static const getNFTList = _getNFTListProvider;
  static const isAccountOwner = _isAccountOwnerProvider;
}
