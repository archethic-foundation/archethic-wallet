import 'package:aewallet/model/data/access_recipient.dart';
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
    @HiveField(2) required List<AccessRecipient> members,
    @HiveField(3) required List<AccessRecipient> admins,
    @HiveField(4) required DateTime creationDate,
    @HiveField(5) TalkMessage? lastMessage,
  }) = _Talk;

  DateTime get updateDate => lastMessage?.date ?? creationDate;

  String get displayName {
    if (name != null && name!.isNotEmpty) return name!;
    return members.first.name;
  }

  const Talk._();
}
