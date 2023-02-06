import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';
part 'failure.g.dart';

@freezed
class DeeplinkRpcFailure with _$DeeplinkRpcFailure implements Exception {
  const factory DeeplinkRpcFailure({
    required int code,
    String? message,
    dynamic data,
  }) = _DeeplinkRpcFailure;

  const DeeplinkRpcFailure._();

  factory DeeplinkRpcFailure.fromJson(Map<String, dynamic> json) =>
      _$DeeplinkRpcFailureFromJson(json);

  static const kInvalidRequest = -32600;
  static const kServerError = -32000;
}
