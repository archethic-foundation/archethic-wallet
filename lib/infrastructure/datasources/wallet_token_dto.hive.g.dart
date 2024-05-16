// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_token_dto.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletTokenHiveDtoAdapter extends TypeAdapter<WalletTokenHiveDto> {
  @override
  final int typeId = 19;

  @override
  WalletTokenHiveDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletTokenHiveDto(
      address: fields[0] as String?,
      genesis: fields[1] as String?,
      name: fields[2] as String?,
      id: fields[3] as String?,
      supply: fields[4] as int?,
      type: fields[5] as String?,
      decimals: fields[6] as int?,
      symbol: fields[7] as String?,
      properties: (fields[8] as Map).cast<String, dynamic>(),
      collection: (fields[9] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      aeip: (fields[10] as List?)?.cast<int>(),
      ownerships: (fields[11] as List?)?.cast<WalletTokenOwnershipHiveDto>(),
    );
  }

  @override
  void write(BinaryWriter writer, WalletTokenHiveDto obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.genesis)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.supply)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.decimals)
      ..writeByte(7)
      ..write(obj.symbol)
      ..writeByte(8)
      ..write(obj.properties)
      ..writeByte(9)
      ..write(obj.collection)
      ..writeByte(10)
      ..write(obj.aeip)
      ..writeByte(11)
      ..write(obj.ownerships);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletTokenHiveDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WalletTokenOwnershipHiveDtoAdapter
    extends TypeAdapter<WalletTokenOwnershipHiveDto> {
  @override
  final int typeId = 20;

  @override
  WalletTokenOwnershipHiveDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletTokenOwnershipHiveDto(
      authorizedPublicKeys:
          (fields[0] as List).cast<WalletTokenOwnershipAuthorizedKeyHiveDto>(),
      secret: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WalletTokenOwnershipHiveDto obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.authorizedPublicKeys)
      ..writeByte(1)
      ..write(obj.secret);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletTokenOwnershipHiveDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WalletTokenOwnershipAuthorizedKeyHiveDtoAdapter
    extends TypeAdapter<WalletTokenOwnershipAuthorizedKeyHiveDto> {
  @override
  final int typeId = 21;

  @override
  WalletTokenOwnershipAuthorizedKeyHiveDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletTokenOwnershipAuthorizedKeyHiveDto(
      publicKey: fields[0] as String?,
      encryptedSecretKey: fields[1] as String?,
    );
  }

  @override
  void write(
      BinaryWriter writer, WalletTokenOwnershipAuthorizedKeyHiveDto obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.publicKey)
      ..writeByte(1)
      ..write(obj.encryptedSecretKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletTokenOwnershipAuthorizedKeyHiveDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
