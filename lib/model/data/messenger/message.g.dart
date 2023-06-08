// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TalkMessageAdapter extends TypeAdapter<_$_TalkMessage> {
  @override
  final int typeId = 15;

  @override
  _$_TalkMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_TalkMessage(
      senderPublicKey: fields[0] as String,
      content: fields[1] as String,
      date: fields[2] as DateTime,
      address: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_TalkMessage obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.senderPublicKey)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TalkMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
