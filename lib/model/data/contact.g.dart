// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactAdapter extends TypeAdapter<Contact> {
  @override
  final int typeId = 0;

  @override
  Contact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contact(
      name: fields[0] as String,
      address: fields[1] as String,
      type: fields[4] as String,
      publicKey: fields[5] == null ? '' : fields[5] as String,
      genesisAddress: fields[8] as String?,
      balance: fields[7] as AccountBalance?,
      favorite: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Contact obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.publicKey)
      ..writeByte(6)
      ..write(obj.favorite)
      ..writeByte(7)
      ..write(obj.balance)
      ..writeByte(8)
      ..write(obj.genesisAddress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
