import 'package:freezed_annotation/freezed_annotation.dart';

part 'ae_discussion.freezed.dart';
part 'ae_discussion.g.dart';

@freezed
class AEDiscussion with _$AEDiscussion {
  const factory AEDiscussion({
    @Default('') final String discussionName,
    @Default('') final String address,
    @Default([]) final List<String> usersPubKey,
    @Default([]) final List<String> adminPublicKey,
    @Default(0) final int timestampLastUpdate,
  }) = _AEDiscussion;
  const AEDiscussion._();

  factory AEDiscussion.fromJson(Map<String, dynamic> json) =>
      _$AEDiscussionFromJson(json);
}
