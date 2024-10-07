// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_token.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DexTokenHiveAdapter extends TypeAdapter<DexTokenHive> {
  @override
  final int typeId = 104;

  @override
  DexTokenHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DexTokenHive(
      name: fields[0] as String,
      address: fields[1] as String?,
      icon: fields[2] as String?,
      symbol: fields[3] as String,
      balance: fields[4] as double,
      verified: fields[7] as bool,
      isLpToken: fields[8] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, DexTokenHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.symbol)
      ..writeByte(4)
      ..write(obj.balance)
      ..writeByte(7)
      ..write(obj.verified)
      ..writeByte(8)
      ..write(obj.isLpToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DexTokenHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
