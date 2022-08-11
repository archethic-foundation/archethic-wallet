// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountTokenAdapter extends TypeAdapter<AccountToken> {
  @override
  final int typeId = 8;

  @override
  AccountToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountToken(
      tokenInformations: fields[7] as TokenInformations?,
      amount: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, AccountToken obj) {
    writer
      ..writeByte(2)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(7)
      ..write(obj.tokenInformations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountTokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
