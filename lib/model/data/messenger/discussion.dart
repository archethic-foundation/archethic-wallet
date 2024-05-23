import 'package:aewallet/infrastructure/datasources/appdb.hive.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'discussion.freezed.dart';
part 'discussion.g.dart';

@freezed
class Discussion with _$Discussion {
  @HiveType(typeId: HiveTypeIds.discussion)
  const factory Discussion({
    @HiveField(0) required String address,
    @HiveField(1) String? name,
    @HiveField(2) required List<String> membersPubKeys,
    @HiveField(3) required List<String> adminsPubKeys,
    @HiveField(4) required DateTime creationDate,
    @HiveField(5) DiscussionMessage? lastMessage,
  }) = _Discussion;
  const Discussion._();

  DateTime get updateDate => lastMessage?.date ?? creationDate;
}
