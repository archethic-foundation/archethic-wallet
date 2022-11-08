/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/model/data/account_balance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum AddTokenProcessStep { form, confirmation }

@freezed
class AddTokenFormState with _$AddTokenFormState {
  const factory AddTokenFormState({
    required String seed,
    @Default(AddTokenProcessStep.form) AddTokenProcessStep addTokenProcessStep,
    required AsyncValue<double> feeEstimation,
    required AccountBalance accountBalance,
    @Default('') String name,
    @Default('') String symbol,
    @Default(0.0) double initialSupply,
    @Default('') String errorNameText,
    @Default('') String errorSymbolText,
    @Default('') String errorInitialSupplyText,
    @Default('') String errorAmountText,
  }) = _AddTokenFormState;
  const AddTokenFormState._();

  bool get isControlsOk =>
      errorNameText == '' &&
      errorSymbolText == '' &&
      errorInitialSupplyText == '' &&
      errorAmountText == '';

  bool get canAddToken =>
      feeEstimation.value != null && feeEstimation.value! > 0;

  double get feeEstimationOrZero => feeEstimation.valueOrNull ?? 0;

  String symbolFees(BuildContext context) => AccountBalance.cryptoCurrencyLabel;
}
