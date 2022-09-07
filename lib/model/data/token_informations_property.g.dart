// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_informations_property.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenInformationsPropertyAdapter
    extends TypeAdapter<TokenInformationsProperty> {
  @override
  final int typeId = 10;

  @override
  TokenInformationsProperty read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TokenInformationsProperty(
      name: fields[0] as String?,
      value: fields[1] as String?,
      decryptedValueBase64: (fields[2] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, TokenInformationsProperty obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.decryptedValueBase64);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenInformationsPropertyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
