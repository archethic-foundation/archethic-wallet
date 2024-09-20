// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_farm_lock_farm_infos_response.freezed.dart';
part 'get_farm_lock_farm_infos_response.g.dart';

@freezed
class GetFarmLockFarmInfosResponse with _$GetFarmLockFarmInfosResponse {
  const factory GetFarmLockFarmInfosResponse({
    @JsonKey(name: 'available_levels')
    required Map<String, int> availableLevels,
    @JsonKey(name: 'start_date') required int startDate,
    @JsonKey(name: 'end_date') required int endDate,
    @JsonKey(name: 'lp_token_address') required String lpTokenAddress,
    @JsonKey(name: 'remaining_rewards') required double remainingRewards,
    @JsonKey(name: 'reward_token') required String rewardToken,
    @JsonKey(name: 'rewards_distributed') required double rewardsDistributed,
    @JsonKey(name: 'lp_tokens_deposited') required double lpTokensDeposited,
    required Map<String, Stats> stats,
  }) = _GetFarmLockFarmInfosResponse;

  factory GetFarmLockFarmInfosResponse.fromJson(Map<String, dynamic> json) =>
      _$GetFarmLockFarmInfosResponseFromJson(json);
}

@freezed
class Stats with _$Stats {
  const factory Stats({
    @JsonKey(name: 'deposits_count') required int depositsCount,
    @JsonKey(name: 'lp_tokens_deposited') required double lpTokensDeposited,
    @JsonKey(name: 'remaining_rewards')
    required List<RemainingRewards> remainingRewards,
    required double weight,
  }) = _Stats;

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);
}

@freezed
class RemainingRewards with _$RemainingRewards {
  const factory RemainingRewards({
    @JsonKey(name: 'remaining_rewards') required double rewards,
    required int start,
    required int end,
  }) = _RemainingRewards;

  factory RemainingRewards.fromJson(Map<String, dynamic> json) =>
      _$RemainingRewardsFromJson(json);
}
