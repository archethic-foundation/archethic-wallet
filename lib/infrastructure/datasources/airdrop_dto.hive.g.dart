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
      isFarming: fields[0] as bool,
      isMailFilled: fields[1] as bool,
      currentStep: fields[2] as int?,
      personalMultiplier: fields[3] as int?,
      currentAirdropValue: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, AirdropHiveDto obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.isFarming)
      ..writeByte(1)
      ..write(obj.isMailFilled)
      ..writeByte(2)
      ..write(obj.currentStep)
      ..writeByte(3)
      ..write(obj.personalMultiplier)
      ..writeByte(4)
      ..write(obj.currentAirdropValue);
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
