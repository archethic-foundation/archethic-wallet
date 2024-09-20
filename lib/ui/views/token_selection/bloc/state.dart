/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class TokenSelectionFormState with _$TokenSelectionFormState {
  const factory TokenSelectionFormState({
    @Default('') String searchText,
    List<DexToken>? result,
  }) = _TokenSelectionFormState;
  const TokenSelectionFormState._();

  bool get isAddress => Address(address: searchText).isValid();
}
