// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user_infos_response.freezed.dart';
part 'get_user_infos_response.g.dart';

@freezed
class GetUserInfosResponse with _$GetUserInfosResponse {
  const factory GetUserInfosResponse({
    @JsonKey(name: 'deposited_amount') required double depositedAmount,
    @JsonKey(name: 'reward_amount') required double rewardAmount,
  }) = _GetUserInfosResponse;

  factory GetUserInfosResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserInfosResponseFromJson(json);
}
