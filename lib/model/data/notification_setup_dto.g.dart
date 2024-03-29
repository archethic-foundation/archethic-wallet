// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_setup_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationsSetupImplAdapter
    extends TypeAdapter<_$NotificationsSetupImpl> {
  @override
  final int typeId = 16;

  @override
  _$NotificationsSetupImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$NotificationsSetupImpl(
      listenedAddresses:
          fields[0] == null ? [] : (fields[0] as List).cast<String>(),
      lastFcmToken: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$NotificationsSetupImpl obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.lastFcmToken)
      ..writeByte(0)
      ..write(obj.listenedAddresses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationsSetupImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
