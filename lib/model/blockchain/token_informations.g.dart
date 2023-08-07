// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_informations.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenInformationsAdapter extends TypeAdapter<TokenInformations> {
  @override
  final int typeId = 9;

  @override
  TokenInformations read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TokenInformations(
      address: fields[0] as String?,
      name: fields[1] as String?,
      id: fields[10] as String?,
      supply: fields[9] as double?,
      type: fields[3] as String?,
      symbol: fields[4] as String?,
      tokenProperties: (fields[12] as Map?)?.cast<String, dynamic>(),
      tokenCollection: (fields[14] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          ?.toList(),
      aeip: (fields[13] as List?)?.cast<int>(),
      decimals: fields[15] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TokenInformations obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.symbol)
      ..writeByte(9)
      ..write(obj.supply)
      ..writeByte(10)
      ..write(obj.id)
      ..writeByte(12)
      ..write(obj.tokenProperties)
      ..writeByte(13)
      ..write(obj.aeip)
      ..writeByte(14)
      ..write(obj.tokenCollection)
      ..writeByte(15)
      ..write(obj.decimals);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenInformationsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
