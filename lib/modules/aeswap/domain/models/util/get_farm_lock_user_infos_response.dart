// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_farm_lock_user_infos_response.freezed.dart';
part 'get_farm_lock_user_infos_response.g.dart';

@freezed
class GetFarmLockUserInfosResponse with _$GetFarmLockUserInfosResponse {
  const factory GetFarmLockUserInfosResponse({
    required List<Map<int, UserInfos>> userInfos,
  }) = _GetFarmLockUserInfosResponse;

  factory GetFarmLockUserInfosResponse.fromJson(Map<String, dynamic> json) =>
      _$GetFarmLockUserInfosResponseFromJson(json);
}

@freezed
class UserInfos with _$UserInfos {
  const factory UserInfos({
    required String id,
    required double amount,
    @JsonKey(name: 'reward_amount') required double rewardAmount,
    int? start,
    int? end,
    required String level,
  }) = _UserInfos;

  factory UserInfos.fromJson(Map<String, dynamic> json) =>
      _$UserInfosFromJson(json);
}
