import 'package:aewallet/model/data/messenger/talk.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'discussion_search_bar_state.freezed.dart';

@freezed
class DiscussionSearchBarState with _$DiscussionSearchBarState {
  const factory DiscussionSearchBarState({
    @Default('') String searchCriteria,
    @Default(false) bool loading,
    @Default('') String error,
    Talk? talk,
  }) = _DiscussionSearchBarState;
  const DiscussionSearchBarState._();

  bool get isControlsOk => error == '' && loading == false && talk != null;
}
