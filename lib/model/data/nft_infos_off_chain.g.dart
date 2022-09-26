// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_infos_off_chain.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NftInfosOffChainAdapter extends TypeAdapter<NftInfosOffChain> {
  @override
  final int typeId = 11;

  @override
  NftInfosOffChain read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NftInfosOffChain(
      id: fields[0] as String?,
      categoryNftIndex: fields[3] as int?,
      favorite: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, NftInfosOffChain obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.categoryNftIndex)
      ..writeByte(4)
      ..write(obj.favorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NftInfosOffChainAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
