// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_recipient.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PubKeyAccessRecipientAdapter extends TypeAdapter<_$AccessPublicKeyImpl> {
  @override
  final int typeId = 13;

  @override
  _$AccessPublicKeyImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$AccessPublicKeyImpl(
      publicKey: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$AccessPublicKeyImpl obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.publicKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PubKeyAccessRecipientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContactAccessRecipientAdapter extends TypeAdapter<_$AccessContactImpl> {
  @override
  final int typeId = 14;

  @override
  _$AccessContactImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$AccessContactImpl(
      contact: fields[0] as Contact,
    );
  }

  @override
  void write(BinaryWriter writer, _$AccessContactImpl obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.contact);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactAccessRecipientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
