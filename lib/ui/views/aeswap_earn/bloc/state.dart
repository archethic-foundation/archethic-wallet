/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class EarnFormState with _$EarnFormState {
  const factory EarnFormState({
    DexPool? pool,
    DexFarmLock? farmLock,
    @Default(0.0) double lpTokenBalance,
    @Default(0.0) double farmedTokensCapital,
    @Default(0.0) double farmedTokensCapitalInFiat,
    @Default(0.0) double farmedTokensRewards,
    @Default(0.0) double farmedTokensRewardsInFiat,
  }) = _EarnFormState;
  const EarnFormState._();

  double get farmedTokensInFiat =>
      farmedTokensCapitalInFiat + farmedTokensRewardsInFiat;
}
