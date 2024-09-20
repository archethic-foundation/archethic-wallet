// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_pool_infos_response.freezed.dart';
part 'get_pool_infos_response.g.dart';

@freezed
class GetPoolInfosResponse with _$GetPoolInfosResponse {
  const factory GetPoolInfosResponse({
    required Token token1,
    required Token token2,
    @JsonKey(name: 'lp_token') required LPToken lpToken,
    required double fee,
    @JsonKey(name: 'protocol_fee') required double protocolFee,
    required Stats stats,
  }) = _GetPoolInfosResponse;

  factory GetPoolInfosResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPoolInfosResponseFromJson(json);
}

@freezed
class Token with _$Token {
  const factory Token({
    required String address,
    required double reserve,
  }) = _Token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}

@freezed
class LPToken with _$LPToken {
  const factory LPToken({
    required String address,
    required double supply,
  }) = _LPToken;

  factory LPToken.fromJson(Map<String, dynamic> json) =>
      _$LPTokenFromJson(json);
}

@freezed
class Stats with _$Stats {
  const factory Stats({
    @JsonKey(name: 'token1_total_fee') required double token1TotalFee,
    @JsonKey(name: 'token1_total_protocol_fee')
    required double token1TotalProtocolFee,
    @JsonKey(name: 'token1_total_volume') required double token1TotalVolume,
    @JsonKey(name: 'token2_total_fee') required double token2TotalFee,
    @JsonKey(name: 'token2_total_protocol_fee')
    required double token2TotalProtocolFee,
    @JsonKey(name: 'token2_total_volume') required double token2TotalVolume,
  }) = _Stats;

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);
}
