/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';
part 'state.g.dart';

class ArchethicOracleUCOJsonConverter
    extends JsonConverter<ArchethicOracleUCO, Map<String, dynamic>> {
  const ArchethicOracleUCOJsonConverter();

  @override
  ArchethicOracleUCO fromJson(Map<String, dynamic> json) {
    return ArchethicOracleUCO.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ArchethicOracleUCO object) => object.toJson();
}

@freezed
class ArchethicOracleUCO with _$ArchethicOracleUCO {
  const factory ArchethicOracleUCO({
    @Default(0) int timestamp,
    @Default(0) double eur,
    @Default(0) double usd,
  }) = _ArchethicOracleUCO;

  factory ArchethicOracleUCO.fromJson(Map<String, dynamic> json) =>
      _$ArchethicOracleUCOFromJson(json);
}
