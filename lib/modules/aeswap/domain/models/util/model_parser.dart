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

  Future<DexPool> poolListItemToModel(
    GetPoolListResponse getPoolListResponse,
    List<String> tokenVerifiedList,
  ) async {
    final tokens = getPoolListResponse.tokens.split('/');
    final tokensListDatasource = await HiveTokensListDatasource.getInstance();

    var token1Name = '';
    var token1Symbol = '';
    var token1Verified = false;
    var token2Verified = false;
    if (tokens[0] == 'UCO') {
      token1Name = 'Universal Coin';
      token1Symbol = 'UCO';
      token1Verified = true;
    } else {
      final token1 = tokensListDatasource.getToken(
        aedappfm.EndpointUtil.getEnvironnement(),
        tokens[0],
      );
      if (token1 != null) {
        final tokenVerified = await aedappfm.VerifiedTokensRepositoryImpl()
            .isVerifiedToken(token1.address!, tokenVerifiedList);
        token1Name = token1.name;
        token1Symbol = token1.symbol;
        token1Verified = tokenVerified;
      }
    }

    var token2Name = '';
    var token2Symbol = '';
    if (tokens[1] == 'UCO') {
      token2Name = 'Universal Coin';
      token2Symbol = 'UCO';
      token2Verified = true;
    } else {
      final token2 = tokensListDatasource.getToken(
        aedappfm.EndpointUtil.getEnvironnement(),
        tokens[1],
      );
      if (token2 != null) {
        final tokenVerified = await aedappfm.VerifiedTokensRepositoryImpl()
            .isVerifiedToken(token2.address!, tokenVerifiedList);
        token2Name = token2.name;
        token2Symbol = token2.symbol;
        token2Verified = tokenVerified;
      }
    }

    var lpTokenName = '';
    var lpTokenSymbol = '';
    final lpToken = tokensListDatasource.getToken(
      aedappfm.EndpointUtil.getEnvironnement(),
      getPoolListResponse.lpTokenAddress,
    );
    if (lpToken != null) {
      lpTokenName = lpToken.name;
      lpTokenSymbol = lpToken.symbol;
    }

    final dexPair = DexPair(
      token1: DexToken(
        address: tokens[0].toUpperCase(),
        name: token1Name,
        symbol: token1Symbol,
        isVerified: token1Verified,
      ),
      token2: DexToken(
        address: tokens[1].toUpperCase(),
        name: token2Name,
        symbol: token2Symbol,
        isVerified: token2Verified,
      ),
    );

    // Check if favorite in cache
    var _isFavorite = false;
    final poolsListDatasource = await HivePoolsListDatasource.getInstance();
    final isPoolFavorite = poolsListDatasource.getPool(
      aedappfm.EndpointUtil.getEnvironnement(),
      getPoolListResponse.address,
    );
    if (isPoolFavorite != null) {
      _isFavorite = isPoolFavorite.isFavorite!;
    }

    return DexPool(
      poolAddress: getPoolListResponse.address,
      pair: dexPair,
      lpToken: DexToken(
        address: getPoolListResponse.lpTokenAddress.toUpperCase(),
        name: lpTokenName,
        symbol: lpTokenSymbol,
        isLpToken: true,
      ),
      lpTokenInUserBalance: false,
      isFavorite: _isFavorite,
    );
  }

  Future<DexFarm> farmListToModel(
    GetFarmListResponse getFarmListResponse,
    DexPool pool,
  ) async {
    final adressesToSearch = <String>[getFarmListResponse.lpTokenAddress];
    if (getFarmListResponse.rewardTokenAddress != 'UCO') {
      adressesToSearch.add(getFarmListResponse.rewardTokenAddress);
    }

    final tokenResultMap = await aedappfm.sl
        .get<archethic.ApiService>()
        .getToken(adressesToSearch);
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
      if (getFarmListResponse.rewardTokenAddress == 'UCO') {
        rewardToken = const DexToken(name: 'UCO', symbol: 'UCO');
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
    String farmGenesisAddress,
    GetFarmInfosResponse getFarmInfosResponse,
    DexPool pool,
    String userGenesisAddress, {
    DexFarm? dexFarmInput,
  }) async {
    var remainingReward = 0.0;
    if (getFarmInfosResponse.remainingReward == null) {
      final transactionChainMap = await aedappfm.sl
          .get<archethic.ApiService>()
          .getTransactionChain({farmGenesisAddress: ''});
      if (transactionChainMap[farmGenesisAddress] != null &&
          transactionChainMap[farmGenesisAddress]!.isNotEmpty) {
        final tx = transactionChainMap[farmGenesisAddress]!.first;

        for (final txInput in tx.inputs) {
          if (txInput.from != tx.address!.address &&
              (txInput.type == 'UCO' &&
                      getFarmInfosResponse.rewardToken == 'UCO' ||
                  txInput.type != 'UCO' &&
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
      aedappfm.sl.get<archethic.ApiService>(),
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
      final tokenResultMap = await aedappfm.sl
          .get<archethic.ApiService>()
          .getToken(adressesToSearch);
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

    if (getFarmInfosResponse.rewardToken == 'UCO') {
      rewardToken = const DexToken(name: 'UCO', symbol: 'UCO');
      dexFarm = dexFarm.copyWith(rewardToken: rewardToken);
    } else {
      final adressesToSearch = <String>[getFarmInfosResponse.rewardToken];
      final tokenResultMap = await aedappfm.sl
          .get<archethic.ApiService>()
          .getToken(adressesToSearch);

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
    String farmGenesisAddress,
    GetFarmLockFarmInfosResponse getFarmLockInfosResponse,
    DexPool pool,
    String userGenesisAddress, {
    DexFarmLock? dexFarmLockInput,
  }) async {
    final farmLockFactory = FarmLockFactory(
      farmGenesisAddress,
      aedappfm.sl.get<archethic.ApiService>(),
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
      final tokenResultMap = await aedappfm.sl
          .get<archethic.ApiService>()
          .getToken(adressesToSearch);
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

    if (getFarmLockInfosResponse.rewardToken == 'UCO') {
      rewardToken = const DexToken(name: 'UCO', symbol: 'UCO');
      dexFarmLock = dexFarmLock.copyWith(rewardToken: rewardToken);
    } else {
      final adressesToSearch = <String>[getFarmLockInfosResponse.rewardToken];
      final tokenResultMap = await aedappfm.sl
          .get<archethic.ApiService>()
          .getToken(adressesToSearch);

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
