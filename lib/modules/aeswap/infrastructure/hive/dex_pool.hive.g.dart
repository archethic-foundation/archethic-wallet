// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_pool.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DexPoolHiveAdapter extends TypeAdapter<DexPoolHive> {
  @override
  final int typeId = 105;

  @override
  DexPoolHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DexPoolHive(
      poolAddress: fields[0] as String,
      lpToken: fields[1] as DexTokenHive,
      pair: fields[2] as DexPairHive,
      lpTokenInUserBalance: fields[3] as bool,
      isFavorite: fields[5] as bool?,
      details: fields[4] as DexPoolInfosHive?,
    );
  }

  @override
  void write(BinaryWriter writer, DexPoolHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.poolAddress)
      ..writeByte(1)
      ..write(obj.lpToken)
      ..writeByte(2)
      ..write(obj.pair)
      ..writeByte(3)
      ..write(obj.lpTokenInUserBalance)
      ..writeByte(4)
      ..write(obj.details)
      ..writeByte(5)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DexPoolHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DexPoolInfosHiveAdapter extends TypeAdapter<DexPoolInfosHive> {
  @override
  final int typeId = 106;

  @override
  DexPoolInfosHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DexPoolInfosHive(
      fees: fields[1] as double,
      tvl: fields[14] as double?,
      protocolFees: fields[9] as double,
      ratioToken1Token2: fields[2] as double,
      ratioToken2Token1: fields[3] as double,
      token1TotalFee: fields[4] as double?,
      token1TotalVolume: fields[5] as double?,
      token2TotalFee: fields[6] as double?,
      token2TotalVolume: fields[7] as double?,
      token1TotalVolume24h: fields[10] as double?,
      token2TotalVolume24h: fields[11] as double?,
      token1TotalVolume7d: fields[19] as double?,
      token2TotalVolume7d: fields[20] as double?,
      token1TotalFee24h: fields[12] as double?,
      token2TotalFee24h: fields[13] as double?,
      fee24h: fields[15] as double?,
      feeAllTime: fields[16] as double?,
      volume24h: fields[17] as double?,
      volume7d: fields[21] as double?,
      volumeAllTime: fields[18] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, DexPoolInfosHive obj) {
    writer
      ..writeByte(20)
      ..writeByte(1)
      ..write(obj.fees)
      ..writeByte(2)
      ..write(obj.ratioToken1Token2)
      ..writeByte(3)
      ..write(obj.ratioToken2Token1)
      ..writeByte(4)
      ..write(obj.token1TotalFee)
      ..writeByte(5)
      ..write(obj.token1TotalVolume)
      ..writeByte(6)
      ..write(obj.token2TotalFee)
      ..writeByte(7)
      ..write(obj.token2TotalVolume)
      ..writeByte(9)
      ..write(obj.protocolFees)
      ..writeByte(10)
      ..write(obj.token1TotalVolume24h)
      ..writeByte(11)
      ..write(obj.token2TotalVolume24h)
      ..writeByte(12)
      ..write(obj.token1TotalFee24h)
      ..writeByte(13)
      ..write(obj.token2TotalFee24h)
      ..writeByte(14)
      ..write(obj.tvl)
      ..writeByte(15)
      ..write(obj.fee24h)
      ..writeByte(16)
      ..write(obj.feeAllTime)
      ..writeByte(17)
      ..write(obj.volume24h)
      ..writeByte(18)
      ..write(obj.volumeAllTime)
      ..writeByte(19)
      ..write(obj.token1TotalVolume7d)
      ..writeByte(20)
      ..write(obj.token2TotalVolume7d)
      ..writeByte(21)
      ..write(obj.volume7d);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DexPoolInfosHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
