/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class TokenDetailFormState with _$TokenDetailFormState {
  const factory TokenDetailFormState() = _TokenDetailFormState;
  const TokenDetailFormState._();
}
