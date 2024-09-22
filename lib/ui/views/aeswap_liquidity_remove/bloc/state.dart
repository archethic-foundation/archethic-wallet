/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class LiquidityRemoveFormState with _$LiquidityRemoveFormState {
  const factory LiquidityRemoveFormState({
    @Default(ProcessStep.form) ProcessStep processStep,
    @Default(false) bool resumeProcess,
    @Default(0) int currentStep,
    DexPool? pool,
    @Default(false) bool isProcessInProgress,
    @Default(false) bool liquidityRemoveOk,
    DexToken? token1,
    DexToken? token2,
    DexToken? lpToken,
    @Default(0.0) double lpTokenBalance,
    @Default(0.0) double lpTokenAmount,
    @Default(0.0) double token1AmountGetBack,
    @Default(0.0) double token2AmountGetBack,
    @Default(0.0) double networkFees,
    @Default(0.0) double token1Balance,
    @Default(0.0) double token2Balance,
    Transaction? transactionRemoveLiquidity,
    double? finalAmountToken1,
    double? finalAmountToken2,
    double? finalAmountLPToken,
    Failure? failure,
    @Default(false) bool calculationInProgress,
    DateTime? consentDateTime,
  }) = _LiquidityRemoveFormState;
  const LiquidityRemoveFormState._();

  bool get isControlsOk =>
      failure == null &&
      lpTokenBalance > 0 &&
      lpTokenAmount > 0 &&
      token1AmountGetBack > 0 &&
      token2AmountGetBack > 0 &&
      calculationInProgress == false;
}
