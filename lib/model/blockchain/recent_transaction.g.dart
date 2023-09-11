// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentTransactionAdapter extends TypeAdapter<RecentTransaction> {
  @override
  final int typeId = 6;

  @override
  RecentTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentTransaction(
      address: fields[0] as String?,
      typeTx: fields[1] as int?,
      amount: fields[2] as double?,
      recipient: fields[3] as String?,
      from: fields[6] as String?,
      fee: fields[5] as double?,
      content: fields[9] as String?,
      timestamp: fields[4] as int?,
      type: fields[10] as String?,
      decryptedSecret: (fields[14] as List?)?.cast<String>(),
    )
      ..tokenInformation = fields[11] as TokenInformation?
      ..contactInformation = fields[12] as Contact?;
  }

  @override
  void write(BinaryWriter writer, RecentTransaction obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.typeTx)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.recipient)
      ..writeByte(4)
      ..write(obj.timestamp)
      ..writeByte(5)
      ..write(obj.fee)
      ..writeByte(6)
      ..write(obj.from)
      ..writeByte(9)
      ..write(obj.content)
      ..writeByte(10)
      ..write(obj.type)
      ..writeByte(11)
      ..write(obj.tokenInformation)
      ..writeByte(12)
      ..write(obj.contactInformation)
      ..writeByte(14)
      ..write(obj.decryptedSecret);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
