/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_config.freezed.dart';
part 'dex_config.g.dart';

@freezed
class DexConfig with _$DexConfig {
  const factory DexConfig({
    @Default('') String name,
    @Default('') String routerGenesisAddress,
    @Default('') String factoryGenesisAddress,
  }) = _DexConfig;

  const DexConfig._();

  factory DexConfig.fromJson(Map<String, dynamic> json) =>
      _$DexConfigFromJson(json);
}
