import 'package:aewallet/infrastructure/datasources/appdb.hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'message.freezed.dart';
part 'message.g.dart';

class DiscussionMessageConverter
    implements JsonConverter<DiscussionMessage, Map<String, dynamic>> {
  const DiscussionMessageConverter();

  @override
  DiscussionMessage fromJson(Map<String, dynamic> json) {
    return DiscussionMessage(
      senderGenesisPublicKey: json['senderGenesisPublicKey'] as String,
      content: json['content'] as String,
      date: json['date'] as DateTime,
      address: json['address'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson(DiscussionMessage discussionMessage) {
    return {
      'senderGenesisPublicKey': discussionMessage.senderGenesisPublicKey,
      'content': discussionMessage.content,
      'date': discussionMessage.date,
      'address': discussionMessage.address,
    };
  }
}

@freezed
@DiscussionMessageConverter()
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
