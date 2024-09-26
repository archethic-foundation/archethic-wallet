/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/farm_lock_duration_type.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class FarmLockLevelUpFormState with _$FarmLockLevelUpFormState {
  const factory FarmLockLevelUpFormState({
    @Default(ProcessStep.form) ProcessStep processStep,
    @Default(false) bool resumeProcess,
    @Default(0) int currentStep,
    DexPool? pool,
    DexFarmLock? farmLock,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool farmLockLevelUpOk,
    @Default(0.0) double amount,
    double? aprEstimation,
    @Default(FarmLockDepositDurationType.threeYears)
    FarmLockDepositDurationType farmLockLevelUpDuration,
    @Default(0.0) double lpTokenBalance,
    Transaction? transactionFarmLockLevelUp,
    @Default({}) Map<String, int> filterAvailableLevels,
    @Default('') String level,
    Failure? failure,
    @Default(0.0) double feesEstimatedUCO,
    double? finalAmount,
    DateTime? consentDateTime,
    String? depositId,
    String? currentLevel,
  }) = _FarmLockLevelUpFormState;
  const FarmLockLevelUpFormState._();

  bool get isControlsOk => failure == null && amount > 0;
}
