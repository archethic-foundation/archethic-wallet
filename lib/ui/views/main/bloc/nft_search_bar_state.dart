import 'package:aewallet/model/blockchain/token_informations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nft_search_bar_state.freezed.dart';

@freezed
class NftSearchBarState with _$NftSearchBarState {
  const factory NftSearchBarState({
    @Default('') String searchCriteria,
    @Default(false) bool loading,
    @Default('') String error,
    TokenInformations? tokenInformations,
  }) = _NftSearchBarState;
  const NftSearchBarState._();

  bool get isControlsOk =>
      error == '' && loading == false && tokenInformations != null;
}
