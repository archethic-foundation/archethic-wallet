// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_manager_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CacheItemHiveAdapter extends TypeAdapter<CacheItemHive> {
  @override
  final int typeId = 17;

  @override
  CacheItemHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CacheItemHive(
      fields[0] as dynamic,
      ttl: fields[3] as int,
    )..createdAt = fields[1] as DateTime;
  }

  @override
  void write(BinaryWriter writer, CacheItemHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.ttl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheItemHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
