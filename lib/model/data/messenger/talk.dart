import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'talk.freezed.dart';
part 'talk.g.dart';

@freezed
class Talk with _$Talk {
  @HiveType(typeId: HiveTypeIds.talk)
  const factory Talk({
    @HiveField(0) required String address,
    @HiveField(1) String? name,
    @HiveField(2) required List<String> membersPubKeys,
    @HiveField(3) required List<String> adminsPubKeys,
    @HiveField(4) required DateTime creationDate,
    @HiveField(5) TalkMessage? lastMessage,
  }) = _Talk;
  const Talk._();

  DateTime get updateDate => lastMessage?.date ?? creationDate;
}
