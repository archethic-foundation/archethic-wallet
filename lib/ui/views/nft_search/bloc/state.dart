import 'package:aewallet/model/blockchain/token_information.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class NftSearchBarFormState with _$NftSearchBarFormState {
  const factory NftSearchBarFormState({
    @Default('') String searchCriteria,
    @Default(false) bool loading,
    @Default('') String error,
    TokenInformation? tokenInformation,
  }) = _NftSearchBarFormState;
  const NftSearchBarFormState._();

  bool get isControlsOk =>
      error == '' && loading == false && tokenInformation != null;
}
