import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_pool_list_response.freezed.dart';
part 'get_pool_list_response.g.dart';

@freezed
class GetPoolListResponse with _$GetPoolListResponse {
  const factory GetPoolListResponse({
    required String address,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'lp_token_address') required String lpTokenAddress,
    required String tokens,
  }) = _GetPoolListResponse;

  factory GetPoolListResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPoolListResponseFromJson(json);
}
