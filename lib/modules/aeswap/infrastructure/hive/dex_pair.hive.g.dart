// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_pair.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DexPairHiveAdapter extends TypeAdapter<DexPairHive> {
  @override
  final int typeId = 102;

  @override
  DexPairHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DexPairHive(
      token1: fields[0] as DexTokenHive,
      token2: fields[1] as DexTokenHive,
    );
  }

  @override
  void write(BinaryWriter writer, DexPairHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.token1)
      ..writeByte(1)
      ..write(obj.token2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DexPairHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
