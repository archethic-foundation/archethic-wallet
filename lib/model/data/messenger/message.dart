import 'package:aewallet/model/data/appdb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class DiscussionMessage with _$DiscussionMessage {
  @HiveType(typeId: HiveTypeIds.discussionMessage)
  const factory DiscussionMessage({
    @HiveField(0) required String senderGenesisPublicKey,
    @HiveField(1) required String content,
    @HiveField(2) required DateTime date,
    @HiveField(3) required String address,
  }) = _DiscussionMessage;
  const DiscussionMessage._();
}
