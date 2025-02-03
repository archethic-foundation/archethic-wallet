// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airdrop_dto.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AirdropHiveDtoAdapter extends TypeAdapter<AirdropHiveDto> {
  @override
  final int typeId = 23;

  @override
  AirdropHiveDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AirdropHiveDto(
      personalLPAmount: fields[0] as double,
      personalLPFlexibleAmount: fields[3] as double,
      isMailFilled: fields[1] as bool,
      isMailConfirmed: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AirdropHiveDto obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.personalLPAmount)
      ..writeByte(1)
      ..write(obj.isMailFilled)
      ..writeByte(2)
      ..write(obj.isMailConfirmed)
      ..writeByte(3)
      ..write(obj.personalLPFlexibleAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AirdropHiveDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
