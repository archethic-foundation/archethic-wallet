// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_farm_list_response.freezed.dart';
part 'get_farm_list_response.g.dart';

@freezed
class GetFarmListResponse with _$GetFarmListResponse {
  const factory GetFarmListResponse({
    @JsonKey(name: 'lp_token_address') required String lpTokenAddress,
    @JsonKey(name: 'start_date') required int startDate,
    @JsonKey(name: 'end_date') required int endDate,
    @JsonKey(name: 'reward_token') required String rewardTokenAddress,
    @JsonKey(name: 'type') int? type,
    required String address,
  }) = _GetFarmListResponse;

  factory GetFarmListResponse.fromJson(Map<String, dynamic> json) =>
      _$GetFarmListResponseFromJson(json);
}
