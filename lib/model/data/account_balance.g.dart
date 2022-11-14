// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_balance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountBalanceAdapter extends TypeAdapter<AccountBalance> {
  @override
  final int typeId = 5;

  @override
  AccountBalance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountBalance(
      nativeTokenValue: fields[0] as double,
      nativeTokenName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AccountBalance obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.nativeTokenValue)
      ..writeByte(1)
      ..write(obj.nativeTokenName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountBalanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
