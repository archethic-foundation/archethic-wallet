import 'package:aewallet/model/data/appdb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class TalkMessage with _$TalkMessage {
  const TalkMessage._();

  @HiveType(typeId: HiveTypeIds.talkMessage)
  const factory TalkMessage({
    @HiveField(0) required String senderPublicKey,
    @HiveField(1) required String content,
    @HiveField(2) required DateTime date,
    @HiveField(3) required String address,
  }) = _TalkMessage;
}
