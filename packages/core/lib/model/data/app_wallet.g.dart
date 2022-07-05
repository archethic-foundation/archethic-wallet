// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_wallet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppWalletAdapter extends TypeAdapter<AppWallet> {
  @override
  final int typeId = 4;

  @override
  AppWallet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppWallet(
      seed: fields[0] as String?,
      appKeychain: fields[1] as AppKeychain?,
    );
  }

  @override
  void write(BinaryWriter writer, AppWallet obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.seed)
      ..writeByte(1)
      ..write(obj.appKeychain);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppWalletAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
