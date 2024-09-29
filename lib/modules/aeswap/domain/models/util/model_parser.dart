import 'package:aewallet/modules/aeswap/application/farm/farm_factory.dart';
import 'package:aewallet/modules/aeswap/application/farm/farm_lock_factory.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock_stats.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock_stats_rewards_allocated.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock_user_infos.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pair.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool_infos.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_farm_infos_response.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_farm_list_response.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_farm_lock_farm_infos_response.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_farm_lock_user_infos_response.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_pool_infos_response.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_pool_list_response.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/pools_list.hive.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/tokens_list.hive.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

mixin ModelParser {
  archethic.Token tokenModelToSDK(
    DexToken token,
  ) {
    return archethic.Token(
      name: token.name,
      genesis: token.address,
      symbol: token.symbol,
    );
  }

  DexToken tokenSDKToModel(
    archethic.Token token,
    double balance,
  ) {
    return DexToken(
      balance: balance,
      name: token.name ?? '',
      address: token.address ?? '',
      symbol: token.symbol ?? '',
    );
  }

  Future<DexPool> poolInfoToModel(
    DexPool poolInput,
    GetPoolInfosResponse getPoolInfosResponse,
  ) async {
    var ratioToken1Token2 = 0.0;
    var ratioToken2Token1 = 0.0;
    if (getPoolInfosResponse.token1.reserve > 0 &&
        getPoolInfosResponse.token2.reserve > 0) {
      ratioToken1Token2 = getPoolInfosResponse.token2.reserve /
          getPoolInfosResponse.token1.reserve;
      ratioToken2Token1 = getPoolInfosResponse.token1.reserve /
          getPoolInfosResponse.token2.reserve;
    }

    final token1 = poolInput.pair.token1.copyWith(
      reserve: getPoolInfosResponse.token1.reserve,
    );

    final token2 = poolInput.pair.token2.copyWith(
      reserve: getPoolInfosResponse.token2.reserve,
    );

    final dexPair = poolInput.pair.copyWith(
      token1: token1,
      token2: token2,
    );

    final lpToken = poolInput.lpToken.copyWith(
      supply: getPoolInfosResponse.lpToken.supply,
    );

    return poolInput.copyWith(
      pair: dexPair,
      lpToken: lpToken,
      infos: DexPoolInfos(
        fees: getPoolInfosResponse.fee,
        protocolFees: getPoolInfosResponse.protocolFee,
        ratioToken1Token2: ratioToken1Token2,
        ratioToken2Token1: ratioToken2Token1,
        token1TotalFee: getPoolInfosResponse.stats.token1TotalFee,
        token1TotalVolume: getPoolInfosResponse.stats.token1TotalVolume,
        token2TotalFee: getPoolInfosResponse.stats.token2TotalFee,
        token2TotalVolume: getPoolInfosResponse.stats.token2TotalVolume,
      ),
    );
  }

  Future<DexToken> _hiveTokenToModel({
    required aedappfm.Environment environment,
    required aedappfm.VerifiedTokensRepositoryInterface
        verifiedTokensRepository,
    required List<String> tokenVerifiedList,
    required String tokenAddress,
  }) async {
    if (tokenAddress.isUCO) {
      return DexToken.uco();
    }

    final tokensListDatasource = await HiveTokensListDatasource.getInstance();

    final hiveToken = tokensListDatasource.getToken(
      environment,
      tokenAddress,
    );
    if (hiveToken != null) {
      final tokenVerified = verifiedTokensRepository.isVerifiedToken(
        hiveToken.address!,
        tokenVerifiedList,
      );
      return DexToken(
        address: tokenAddress,
        name: hiveToken.name,
        symbol: hiveToken.symbol,
        isVerified: tokenVerified,
      );
    }

    // TODO(Chralu): Wrong idea to act as if we had data about that token
    return DexToken(
      address: tokenAddress,
    );
  }

  Future<DexPool> poolListItemToModel(
    HiveTokensListDatasource localTokensDatasource,
    aedappfm.VerifiedTokensRepositoryInterface verifiedTokensRepository,
    aedappfm.Environment environment,
    GetPoolListResponse getPoolListResponse,
    List<String> tokenVerifiedList,
  ) async {
    final tokens = getPoolListResponse.tokens;

    final token1 = await _hiveTokenToModel(
      environment: environment,
      verifiedTokensRepository: verifiedTokensRepository,
      tokenVerifiedList: tokenVerifiedList,
      tokenAddress: tokens[0],
    );
    final token2 = await _hiveTokenToModel(
      environment: environment,
      verifiedTokensRepository: verifiedTokensRepository,
      tokenVerifiedList: tokenVerifiedList,
      tokenAddress: tokens[1],
    );

    final hiveLpToken = localTokensDatasource.getToken(
      environment,
      getPoolListResponse.lpTokenAddress,
    );
    final lpToken = DexToken(
      address: getPoolListResponse.lpTokenAddress.toUpperCase(),
      name: hiveLpToken?.name ?? '',
      symbol: hiveLpToken?.symbol ?? '',
      isLpToken: true,
    );

    // Check if favorite in cache
    final poolsListDatasource = await HivePoolsListDatasource.getInstance();
    final isPoolFavorite = poolsListDatasource.containsPool(
      environment.name,
      getPoolListResponse.address,
    );

    return DexPool(
      poolAddress: getPoolListResponse.address,
      pair: DexPair(
        token1: token1,
        token2: token2,
      ),
      lpToken: lpToken,
      lpTokenInUserBalance: false,
      isFavorite: isPoolFavorite,
    );
  }

  Future<DexFarm> farmListToModel(
    archethic.ApiService apiService,
    GetFarmListResponse getFarmListResponse,
    DexPool pool,
  ) async {
    final adressesToSearch = <String>[getFarmListResponse.lpTokenAddress];
    if (getFarmListResponse.rewardTokenAddress.isNotUCO) {
      adressesToSearch.add(getFarmListResponse.rewardTokenAddress);
    }

    final tokenResultMap = await apiService.getToken(adressesToSearch);
    DexToken? lpToken;
    if (tokenResultMap[getFarmListResponse.lpTokenAddress] != null) {
      lpToken = DexToken(
        address: getFarmListResponse.lpTokenAddress.toUpperCase(),
        name: tokenResultMap[getFarmListResponse.lpTokenAddress]!.name!,
        symbol: tokenResultMap[getFarmListResponse.lpTokenAddress]!.symbol!,
        isLpToken: true,
      );
    }

    DexToken? rewardToken;
    if (tokenResultMap[getFarmListResponse.rewardTokenAddress] != null) {
      rewardToken = DexToken(
        address: getFarmListResponse.rewardTokenAddress.toUpperCase(),
        name: tokenResultMap[getFarmListResponse.rewardTokenAddress]!.name!,
        symbol: tokenResultMap[getFarmListResponse.rewardTokenAddress]!.symbol!,
      );
    } else {
      if (getFarmListResponse.rewardTokenAddress.isUCO) {
        rewardToken = DexToken.uco();
      }
    }
    return DexFarm(
      startDate: DateTime.fromMillisecondsSinceEpoch(
        getFarmListResponse.startDate * 1000,
      ),
      endDate: DateTime.fromMillisecondsSinceEpoch(
        getFarmListResponse.endDate * 1000,
      ),
      farmAddress: getFarmListResponse.address,
      rewardToken: rewardToken,
      lpToken: lpToken,
      lpTokenPair: pool.pair,
      poolAddress: pool.poolAddress,
    );
  }

  Future<DexFarm> farmInfosToModel(
    archethic.ApiService apiService,
    String farmGenesisAddress,
    GetFarmInfosResponse getFarmInfosResponse,
    DexPool pool,
    String userGenesisAddress, {
    DexFarm? dexFarmInput,
  }) async {
    var remainingReward = 0.0;
    if (getFarmInfosResponse.remainingReward == null) {
      final transactionChainMap =
          await apiService.getTransactionChain({farmGenesisAddress: ''});
      if (transactionChainMap[farmGenesisAddress] != null &&
          transactionChainMap[farmGenesisAddress]!.isNotEmpty) {
        final tx = transactionChainMap[farmGenesisAddress]!.first;

        for (final txInput in tx.inputs) {
          if (txInput.from != tx.address!.address &&
              (txInput.type?.isUCO == true &&
                      getFarmInfosResponse.rewardToken.isUCO ||
                  txInput.type?.isNotUCO == true &&
                      getFarmInfosResponse.rewardToken ==
                          txInput.tokenAddress)) {
            remainingReward = archethic.fromBigInt(txInput.amount).toDouble();
          }
        }
      }
    } else {
      remainingReward = getFarmInfosResponse.remainingReward!;
    }

    final farmFactory = FarmFactory(
      farmGenesisAddress,
      apiService,
    );

    var depositedAmount = 0.0;
    var rewardAmount = 0.0;
    final farmInfosResult = await farmFactory.getUserInfos(userGenesisAddress);
    farmInfosResult.map(
      success: (farmInfosResultSuccess) {
        depositedAmount = farmInfosResultSuccess.depositedAmount;
        rewardAmount = farmInfosResultSuccess.rewardAmount;
      },
      failure: (failure) {},
    );

    DexFarm? dexFarm = DexFarm(
      lpTokenDeposited: getFarmInfosResponse.lpTokenDeposited,
      nbDeposit: getFarmInfosResponse.nbDeposit,
      remainingReward: remainingReward,
      rewardAmount: rewardAmount,
      depositedAmount: depositedAmount,
      startDate: DateTime.fromMillisecondsSinceEpoch(
        getFarmInfosResponse.startDate * 1000,
      ),
      endDate: DateTime.fromMillisecondsSinceEpoch(
        getFarmInfosResponse.endDate * 1000,
      ),
      farmAddress: farmGenesisAddress,
      poolAddress: pool.poolAddress,
      lpTokenPair: pool.pair,
      statsRewardDistributed: getFarmInfosResponse.stats.rewardDistributed,
    );
    if (dexFarmInput == null || dexFarmInput.lpToken == null) {
      final adressesToSearch = <String>[getFarmInfosResponse.lpTokenAddress];
      final tokenResultMap = await apiService.getToken(adressesToSearch);
      DexToken? lpToken;
      if (tokenResultMap[getFarmInfosResponse.lpTokenAddress] != null) {
        lpToken = DexToken(
          address: getFarmInfosResponse.lpTokenAddress.toUpperCase(),
          name: tokenResultMap[getFarmInfosResponse.lpTokenAddress]!.name!,
          symbol: tokenResultMap[getFarmInfosResponse.lpTokenAddress]!.symbol!,
          isLpToken: true,
        );
        dexFarm = dexFarm.copyWith(lpToken: lpToken);
      }
    } else {
      dexFarm = dexFarm.copyWith(lpToken: dexFarmInput.lpToken);
    }

    DexToken? rewardToken;

    if (getFarmInfosResponse.rewardToken.isUCO) {
      rewardToken = DexToken.uco();
      dexFarm = dexFarm.copyWith(rewardToken: rewardToken);
    } else {
      final adressesToSearch = <String>[getFarmInfosResponse.rewardToken];
      final tokenResultMap = await apiService.getToken(adressesToSearch);

      if (tokenResultMap[getFarmInfosResponse.rewardToken] != null) {
        rewardToken = DexToken(
          address: getFarmInfosResponse.rewardToken.toUpperCase(),
          name: tokenResultMap[getFarmInfosResponse.rewardToken]!.name!,
          symbol: tokenResultMap[getFarmInfosResponse.rewardToken]!.symbol!,
        );
        dexFarm = dexFarm.copyWith(rewardToken: rewardToken);
      }
    }

    return dexFarm;
  }

  Future<DexFarmLock> farmLockInfosToModel(
    archethic.ApiService apiService,
    String farmGenesisAddress,
    GetFarmLockFarmInfosResponse getFarmLockInfosResponse,
    DexPool pool,
    String userGenesisAddress, {
    DexFarmLock? dexFarmLockInput,
  }) async {
    final farmLockFactory = FarmLockFactory(
      farmGenesisAddress,
      apiService,
    );

    final farmUserInfosResult =
        await farmLockFactory.getUserInfos(userGenesisAddress);

    final userInfosMap = <String, DexFarmLockUserInfos>{};
    for (final userInfos in farmUserInfosResult) {
      final userInfosResponse = UserInfos.fromJson(userInfos!);

      userInfosMap[userInfosResponse.id] = DexFarmLockUserInfos(
        amount: userInfosResponse.amount,
        end: userInfosResponse.end,
        start: userInfosResponse.start,
        level: userInfosResponse.level,
        rewardAmount: userInfosResponse.rewardAmount,
        id: userInfosResponse.id,
      );
    }

    final availableLevelsMap = <String, int>{};
    getFarmLockInfosResponse.availableLevels.forEach((level, duration) {
      availableLevelsMap[level] = duration;
    });

    final dexFarmLockStatsMap = <String, DexFarmLockStats>{};
    getFarmLockInfosResponse.stats.forEach((level, stats) {
      final dexFarmLockStatsRewardsAllocatedList =
          <DexFarmLockStatsRemainingRewards>[];
      for (final remainingRewards in stats.remainingRewards) {
        dexFarmLockStatsRewardsAllocatedList.add(
          DexFarmLockStatsRemainingRewards(
            startPeriod: remainingRewards.start,
            endPeriod: remainingRewards.end,
            rewardsAllocated: remainingRewards.rewards,
          ),
        );
      }

      dexFarmLockStatsMap[level] = DexFarmLockStats(
        depositsCount: stats.depositsCount,
        lpTokensDeposited: stats.lpTokensDeposited,
        remainingRewards: dexFarmLockStatsRewardsAllocatedList,
        weight: stats.weight,
      );
    });

    DexFarmLock? dexFarmLock = DexFarmLock(
      stats: dexFarmLockStatsMap,
      availableLevels: availableLevelsMap,
      remainingReward: getFarmLockInfosResponse.remainingRewards,
      userInfos: userInfosMap,
      startDate: DateTime.fromMillisecondsSinceEpoch(
        getFarmLockInfosResponse.startDate * 1000,
      ),
      endDate: DateTime.fromMillisecondsSinceEpoch(
        getFarmLockInfosResponse.endDate * 1000,
      ),
      farmAddress: farmGenesisAddress,
      poolAddress: pool.poolAddress,
      lpTokenPair: pool.pair,
      lpTokensDeposited: getFarmLockInfosResponse.lpTokensDeposited,
      rewardDistributed: getFarmLockInfosResponse.rewardsDistributed,
    );
    if (dexFarmLockInput == null || dexFarmLockInput.lpToken == null) {
      final adressesToSearch = <String>[
        getFarmLockInfosResponse.lpTokenAddress,
      ];
      final tokenResultMap = await apiService.getToken(adressesToSearch);
      DexToken? lpToken;
      if (tokenResultMap[getFarmLockInfosResponse.lpTokenAddress] != null) {
        lpToken = DexToken(
          address: getFarmLockInfosResponse.lpTokenAddress.toUpperCase(),
          name: tokenResultMap[getFarmLockInfosResponse.lpTokenAddress]!.name!,
          symbol:
              tokenResultMap[getFarmLockInfosResponse.lpTokenAddress]!.symbol!,
          isLpToken: true,
        );
        dexFarmLock = dexFarmLock.copyWith(lpToken: lpToken);
      }
    } else {
      dexFarmLock = dexFarmLock.copyWith(lpToken: dexFarmLockInput.lpToken);
    }

    DexToken? rewardToken;

    if (getFarmLockInfosResponse.rewardToken.isUCO) {
      rewardToken = DexToken.uco();
      dexFarmLock = dexFarmLock.copyWith(rewardToken: rewardToken);
    } else {
      final adressesToSearch = <String>[getFarmLockInfosResponse.rewardToken];
      final tokenResultMap = await apiService.getToken(adressesToSearch);

      if (tokenResultMap[getFarmLockInfosResponse.rewardToken] != null) {
        rewardToken = DexToken(
          address: getFarmLockInfosResponse.rewardToken.toUpperCase(),
          name: tokenResultMap[getFarmLockInfosResponse.rewardToken]!.name!,
          symbol: tokenResultMap[getFarmLockInfosResponse.rewardToken]!.symbol!,
        );
        dexFarmLock = dexFarmLock.copyWith(rewardToken: rewardToken);
      }
    }

    return dexFarmLock;
  }
}
