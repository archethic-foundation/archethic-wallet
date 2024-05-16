import 'package:aewallet/model/data/appdb.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:hive/hive.dart';

part 'wallet_token_dto.hive.g.dart';

@HiveType(typeId: HiveTypeIds.walletToken)
class WalletTokenHiveDto extends HiveObject {
  WalletTokenHiveDto({
    required this.address,
    required this.genesis,
    required this.name,
    required this.id,
    required this.supply,
    required this.type,
    required this.decimals,
    required this.symbol,
    required this.properties,
    required this.collection,
    required this.aeip,
    required this.ownerships,
  });

  factory WalletTokenHiveDto.fromModel(Token token) {
    return WalletTokenHiveDto(
      address: token.address,
      genesis: token.genesis,
      name: token.name,
      id: token.id,
      supply: token.supply,
      type: token.type,
      decimals: token.decimals,
      symbol: token.symbol,
      properties: token.properties,
      collection: token.collection,
      aeip: token.aeip,
      ownerships:
          token.ownerships?.map(WalletTokenOwnershipHiveDto.fromModel).toList(),
    );
  }

  @HiveField(0)
  String? address;

  @HiveField(1)
  String? genesis;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? id;

  @HiveField(4)
  int? supply;

  @HiveField(5)
  String? type;

  @HiveField(6)
  int? decimals;

  @HiveField(7)
  String? symbol;

  @HiveField(8)
  Map<String, dynamic> properties;

  @HiveField(9)
  List<Map<String, dynamic>> collection;

  @HiveField(10)
  List<int>? aeip;

  @HiveField(11)
  List<WalletTokenOwnershipHiveDto>? ownerships;

  Token toModel() {
    return Token(
      address: address,
      genesis: genesis,
      name: name,
      id: id,
      supply: supply,
      type: type,
      decimals: decimals,
      symbol: symbol,
      properties: properties,
      collection: collection,
      aeip: aeip,
      ownerships:
          ownerships?.map((ownershipHive) => ownershipHive.toModel()).toList(),
    );
  }
}

extension WalletTokenHiveConversionExt on Token {
  WalletTokenHiveDto toHive() => WalletTokenHiveDto(
        address: address,
        genesis: genesis,
        name: name,
        id: id,
        supply: supply,
        type: type,
        decimals: decimals,
        symbol: symbol,
        properties: properties,
        collection: collection,
        aeip: aeip,
        ownerships:
            ownerships?.map(WalletTokenOwnershipHiveDto.fromModel).toList(),
      );
}

@HiveType(typeId: HiveTypeIds.walletTokenOwnership)
class WalletTokenOwnershipHiveDto extends HiveObject {
  WalletTokenOwnershipHiveDto({
    required this.authorizedPublicKeys,
    required this.secret,
  });
  factory WalletTokenOwnershipHiveDto.fromModel(Ownership ownership) {
    return WalletTokenOwnershipHiveDto(
      authorizedPublicKeys: ownership.authorizedPublicKeys
          .map(WalletTokenOwnershipAuthorizedKeyHiveDto.fromModel)
          .toList(),
      secret: ownership.secret,
    );
  }

  @HiveField(0)
  List<WalletTokenOwnershipAuthorizedKeyHiveDto> authorizedPublicKeys;

  @HiveField(1)
  String? secret;
  Ownership toModel() {
    return Ownership(
      authorizedPublicKeys:
          authorizedPublicKeys.map((keyHive) => keyHive.toModel()).toList(),
      secret: secret,
    );
  }
}

extension WalletTokenOwnershipHiveConversionExt on Ownership {
  WalletTokenOwnershipHiveDto toHive() => WalletTokenOwnershipHiveDto(
        authorizedPublicKeys: authorizedPublicKeys
            .map(WalletTokenOwnershipAuthorizedKeyHiveDto.fromModel)
            .toList(),
        secret: secret,
      );
}

@HiveType(typeId: HiveTypeIds.walletTokenOwnershipAuthorizedKey)
class WalletTokenOwnershipAuthorizedKeyHiveDto extends HiveObject {
  WalletTokenOwnershipAuthorizedKeyHiveDto({
    required this.publicKey,
    required this.encryptedSecretKey,
  });

  factory WalletTokenOwnershipAuthorizedKeyHiveDto.fromModel(
    AuthorizedKey authorizedPublicKey,
  ) {
    return WalletTokenOwnershipAuthorizedKeyHiveDto(
      publicKey: authorizedPublicKey.publicKey,
      encryptedSecretKey: authorizedPublicKey.encryptedSecretKey,
    );
  }

  @HiveField(0)
  String? publicKey;

  @HiveField(1)
  String? encryptedSecretKey;

  AuthorizedKey toModel() {
    return AuthorizedKey(
      publicKey: publicKey,
      encryptedSecretKey: encryptedSecretKey,
    );
  }
}

extension WalletTokenOwnershipAuthorizedKeyHiveConversionExt on AuthorizedKey {
  WalletTokenOwnershipAuthorizedKeyHiveDto toHive() =>
      WalletTokenOwnershipAuthorizedKeyHiveDto(
        publicKey: publicKey,
        encryptedSecretKey: encryptedSecretKey,
      );
}
