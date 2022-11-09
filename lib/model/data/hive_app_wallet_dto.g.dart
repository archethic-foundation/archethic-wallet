// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_app_wallet_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveAppWalletDTOAdapter extends TypeAdapter<HiveAppWalletDTO> {
  @override
  final int typeId = 4;

  @override
  HiveAppWalletDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveAppWalletDTO(
      appKeychain: fields[1] as AppKeychain,
    );
  }

  @override
  void write(BinaryWriter writer, HiveAppWalletDTO obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.appKeychain);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveAppWalletDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
