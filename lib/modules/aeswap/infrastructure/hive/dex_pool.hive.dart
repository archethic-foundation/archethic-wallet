import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool_infos.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/db_helper.hive.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/dex_pair.hive.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/dex_token.hive.dart';
import 'package:hive/hive.dart';

part 'dex_pool.hive.g.dart';

@HiveType(typeId: HiveTypeIds.dexPool)
class DexPoolHive extends HiveObject {
  DexPoolHive({
    required this.poolAddress,
    required this.lpToken,
    required this.pair,
    required this.lpTokenInUserBalance,
    required this.isFavorite,
    this.details,
  });

  DexPoolHive copyWith({
    DexPoolInfosHive? details,
  }) =>
      DexPoolHive(
        poolAddress: poolAddress,
        lpToken: lpToken,
        pair: pair,
        details: details ?? this.details,
        lpTokenInUserBalance: lpTokenInUserBalance,
        isFavorite: isFavorite,
      );

  @HiveField(0)
  String poolAddress;

  @HiveField(1)
  DexTokenHive lpToken;

  @HiveField(2)
  DexPairHive pair;

  @HiveField(3)
  bool lpTokenInUserBalance;

  @HiveField(4)
  DexPoolInfosHive? details;

  @HiveField(5)
  bool? isFavorite;

  DexPool toDexPool() {
    return DexPool(
      lpTokenInUserBalance: lpTokenInUserBalance,
      isFavorite: isFavorite ?? false,
      poolAddress: poolAddress,
      lpToken: lpToken.toModel(),
      pair: pair.toModel(),
      infos: details?.toModel(),
    );
  }
}

@HiveType(typeId: HiveTypeIds.dexPoolInfos)
class DexPoolInfosHive extends HiveObject {
  DexPoolInfosHive({
    required this.fees,
    required this.tvl,
    required this.protocolFees,
    required this.ratioToken1Token2,
    required this.ratioToken2Token1,
    required this.token1TotalFee,
    required this.token1TotalVolume,
    required this.token2TotalFee,
    required this.token2TotalVolume,
    required this.token1TotalVolume24h,
    required this.token2TotalVolume24h,
    required this.token1TotalVolume7d,
    required this.token2TotalVolume7d,
    required this.token1TotalFee24h,
    required this.token2TotalFee24h,
    required this.fee24h,
    required this.feeAllTime,
    required this.volume24h,
    required this.volume7d,
    required this.volumeAllTime,
  });

  @HiveField(1)
  double fees;

  @HiveField(2)
  double ratioToken1Token2;

  @HiveField(3)
  double ratioToken2Token1;

  @HiveField(4)
  double? token1TotalFee;

  @HiveField(5)
  double? token1TotalVolume;

  @HiveField(6)
  double? token2TotalFee;

  @HiveField(7)
  double? token2TotalVolume;

  // @HiveField(8)
  // double estimatePoolTVLInFiat;

  @HiveField(9)
  double protocolFees;

  @HiveField(10)
  double? token1TotalVolume24h;

  @HiveField(11)
  double? token2TotalVolume24h;

  @HiveField(12)
  double? token1TotalFee24h;

  @HiveField(13)
  double? token2TotalFee24h;

  @HiveField(14)
  double? tvl;

  @HiveField(15)
  double? fee24h;

  @HiveField(16)
  double? feeAllTime;

  @HiveField(17)
  double? volume24h;

  @HiveField(18)
  double? volumeAllTime;

  @HiveField(19)
  double? token1TotalVolume7d;

  @HiveField(20)
  double? token2TotalVolume7d;

  @HiveField(21)
  double? volume7d;

  DexPoolInfos toModel() => DexPoolInfos(
        fees: fees,
        tvl: tvl ?? 0,
        protocolFees: protocolFees,
        ratioToken1Token2: ratioToken1Token2,
        ratioToken2Token1: ratioToken2Token1,
        token1TotalFee: token1TotalFee ?? 0,
        token1TotalVolume: token1TotalVolume ?? 0,
        token2TotalFee: token2TotalFee ?? 0,
        token2TotalVolume: token2TotalVolume ?? 0,
        token1TotalFee24h: token1TotalFee24h ?? 0,
        token1TotalVolume24h: token1TotalVolume24h ?? 0,
        token1TotalVolume7d: token1TotalVolume7d ?? 0,
        token2TotalFee24h: token2TotalFee24h ?? 0,
        token2TotalVolume24h: token2TotalVolume24h ?? 0,
        token2TotalVolume7d: token2TotalVolume7d ?? 0,
        fee24h: fee24h ?? 0,
        feeAllTime: feeAllTime ?? 0,
        volume24h: volume24h ?? 0,
        volume7d: volume7d ?? 0,
        volumeAllTime: volumeAllTime ?? 0,
      );
}

extension DexPoolInfosHiveConversionExt on DexPoolInfos {
  DexPoolInfosHive toHive() => DexPoolInfosHive(
        fees: fees,
        tvl: tvl,
        protocolFees: protocolFees,
        ratioToken1Token2: ratioToken1Token2,
        ratioToken2Token1: ratioToken2Token1,
        token1TotalFee: token1TotalFee,
        token1TotalVolume: token1TotalVolume,
        token2TotalFee: token2TotalFee,
        token2TotalVolume: token2TotalVolume,
        token1TotalFee24h: token1TotalFee24h,
        token1TotalVolume24h: token1TotalVolume24h,
        token1TotalVolume7d: token1TotalVolume7d,
        token2TotalFee24h: token2TotalFee24h,
        token2TotalVolume24h: token2TotalVolume24h,
        token2TotalVolume7d: token2TotalVolume7d,
        fee24h: fee24h,
        feeAllTime: feeAllTime,
        volume24h: volume24h,
        volume7d: volume7d,
        volumeAllTime: volumeAllTime,
      );
}

extension DexPoolHiveConversionExt on DexPool {
  DexPoolHive toHive() => DexPoolHive(
        lpTokenInUserBalance: lpTokenInUserBalance,
        poolAddress: poolAddress,
        lpToken: DexTokenHive.fromModel(lpToken),
        pair: DexPairHive.fromModel(pair),
        details: infos?.toHive(),
        isFavorite: isFavorite,
      );
}
