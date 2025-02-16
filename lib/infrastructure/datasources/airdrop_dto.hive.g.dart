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
      personalLPAmount: fields[0] as double?,
      personalLPFlexibleAmount: fields[3] as double?,
      isMailConfirmed: fields[2] as bool?,
      email: fields[4] as String?,
      referralCode: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AirdropHiveDto obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.personalLPAmount)
      ..writeByte(2)
      ..write(obj.isMailConfirmed)
      ..writeByte(3)
      ..write(obj.personalLPFlexibleAmount)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.referralCode);
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
