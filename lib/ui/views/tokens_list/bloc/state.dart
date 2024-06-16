/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum AddTokenProcessStep { form, confirmation }

@freezed
class TokensListFormState with _$TokensListFormState {
  const factory TokensListFormState({
    required AsyncValue<List<AEToken>?> tokensToDisplay,
    String? cancelToken,
    @Default('') String searchCriteria,
  }) = _TokensListFormState;
  const TokensListFormState._();
}
