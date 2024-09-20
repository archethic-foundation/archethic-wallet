import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_farm_lock_user_infos.freezed.dart';
part 'dex_farm_lock_user_infos.g.dart';

@freezed
class DexFarmLockUserInfos with _$DexFarmLockUserInfos {
  const factory DexFarmLockUserInfos({
    @Default('') String id,
    @Default(0.0) double amount,
    @Default(0.0) double rewardAmount,
    int? start,
    int? end,
    @Default('') String level,
    @Default(0.0) double apr,
  }) = _DexFarmLockUserInfos;
  const DexFarmLockUserInfos._();

  factory DexFarmLockUserInfos.fromJson(Map<String, dynamic> json) =>
      _$DexFarmLockUserInfosFromJson(json);
}
