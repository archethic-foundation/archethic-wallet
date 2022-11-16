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
      tokensFungiblesNb: fields[5] == null ? 0 : fields[5] as int,
      nftNb: fields[6] == null ? 0 : fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AccountBalance obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nativeTokenValue)
      ..writeByte(1)
      ..write(obj.nativeTokenName)
      ..writeByte(5)
      ..write(obj.tokensFungiblesNb)
      ..writeByte(6)
      ..write(obj.nftNb);
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
