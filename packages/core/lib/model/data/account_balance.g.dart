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
      nativeTokenValue: fields[0] as double?,
      nativeTokenName: fields[1] as String?,
      fiatCurrencyValue: fields[2] as double?,
      fiatCurrencyCode: fields[3] as String?,
      tokenPrice: fields[4] as Price?,
    );
  }

  @override
  void write(BinaryWriter writer, AccountBalance obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.nativeTokenValue)
      ..writeByte(1)
      ..write(obj.nativeTokenName)
      ..writeByte(2)
      ..write(obj.fiatCurrencyValue)
      ..writeByte(3)
      ..write(obj.fiatCurrencyCode)
      ..writeByte(4)
      ..write(obj.tokenPrice);
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
