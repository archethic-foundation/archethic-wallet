// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_farm_infos_response.freezed.dart';
part 'get_farm_infos_response.g.dart';

@freezed
class GetFarmInfosResponse with _$GetFarmInfosResponse {
  const factory GetFarmInfosResponse({
    @JsonKey(name: 'lp_token_address') required String lpTokenAddress,
    @JsonKey(name: 'reward_token') required String rewardToken,
    @JsonKey(name: 'start_date') required int startDate,
    @JsonKey(name: 'end_date') required int endDate,
    @JsonKey(name: 'remaining_reward') double? remainingReward,
    @JsonKey(name: 'lp_token_deposited') required double lpTokenDeposited,
    @JsonKey(name: 'nb_deposit') required int nbDeposit,
    required Stats stats,
  }) = _GetFarmInfosResponse;

  factory GetFarmInfosResponse.fromJson(Map<String, dynamic> json) =>
      _$GetFarmInfosResponseFromJson(json);
}

@freezed
class Stats with _$Stats {
  const factory Stats({
    @JsonKey(name: 'reward_distributed') required double rewardDistributed,
  }) = _Stats;

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);
}
