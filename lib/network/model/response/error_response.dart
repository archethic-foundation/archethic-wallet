// @dart=2.9

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  ErrorResponse({String error}) {
    error = error;
  }

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  @JsonKey(name: 'error')
  String error;

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
