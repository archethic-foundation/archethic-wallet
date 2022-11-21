import 'package:aewallet/model/data/account_balance.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum AddAccountProcessStep { form, confirmation }

@freezed
class AddAccountFormState with _$AddAccountFormState {
  const factory AddAccountFormState({
    required String seed,
    @Default(AddAccountProcessStep.form)
        AddAccountProcessStep addAccountProcessStep,
    @Default('') String name,
    @Default('') String errorText,
  }) = _AddAccountFormState;
  const AddAccountFormState._();

  bool get isControlsOk => errorText == '';

  bool get canAddAccount => isControlsOk;

  String symbolFees(BuildContext context) => AccountBalance.cryptoCurrencyLabel;
}
