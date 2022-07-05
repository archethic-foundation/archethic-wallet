// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_keychain.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppKeychainAdapter extends TypeAdapter<AppKeychain> {
  @override
  final int typeId = 3;

  @override
  AppKeychain read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppKeychain(
      address: fields[0] as String?,
      seed: fields[1] as String?,
      accounts: (fields[2] as List?)?.cast<Account>(),
    );
  }

  @override
  void write(BinaryWriter writer, AppKeychain obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.seed)
      ..writeByte(2)
      ..write(obj.accounts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppKeychainAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
