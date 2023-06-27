// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talk.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TalkAdapter extends TypeAdapter<_$_Talk> {
  @override
  final int typeId = 12;

  @override
  _$_Talk read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Talk(
      address: fields[0] as String,
      name: fields[1] as String?,
      membersPubKeys: (fields[2] as List).cast<String>(),
      adminsPubKeys: (fields[3] as List).cast<String>(),
      creationDate: fields[4] as DateTime,
      lastMessage: fields[5] as TalkMessage?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Talk obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.creationDate)
      ..writeByte(5)
      ..write(obj.lastMessage)
      ..writeByte(2)
      ..write(obj.membersPubKeys)
      ..writeByte(3)
      ..write(obj.adminsPubKeys);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TalkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
