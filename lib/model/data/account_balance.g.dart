// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_balance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountBalanceImplAdapter extends TypeAdapter<_$AccountBalanceImpl> {
  @override
  final int typeId = 5;

  @override
  _$AccountBalanceImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$AccountBalanceImpl(
      tokensFungiblesNb: fields[5] == null ? 0 : fields[5] as int,
      nftNb: fields[6] == null ? 0 : fields[6] as int,
      totalUSD: fields[7] == null ? 0 : fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, _$AccountBalanceImpl obj) {
    writer
      ..writeByte(3)
      ..writeByte(5)
      ..write(obj.tokensFungiblesNb)
      ..writeByte(6)
      ..write(obj.nftNb)
      ..writeByte(7)
      ..write(obj.totalUSD);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountBalanceImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountBalanceImpl _$$AccountBalanceImplFromJson(Map<String, dynamic> json) =>
    _$AccountBalanceImpl(
      tokensFungiblesNb: (json['tokensFungiblesNb'] as num?)?.toInt() ?? 0,
      nftNb: (json['nftNb'] as num?)?.toInt() ?? 0,
      totalUSD: (json['totalUSD'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$AccountBalanceImplToJson(
        _$AccountBalanceImpl instance) =>
    <String, dynamic>{
      'tokensFungiblesNb': instance.tokensFungiblesNb,
      'nftNb': instance.nftNb,
      'totalUSD': instance.totalUSD,
    };
