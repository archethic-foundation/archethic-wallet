import 'package:aewallet/infrastructure/datasources/appdb.hive.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'discussion.freezed.dart';
part 'discussion.g.dart';

class DiscussionConverter
    implements JsonConverter<Discussion, Map<String, dynamic>> {
  const DiscussionConverter();

  @override
  Discussion fromJson(Map<String, dynamic> json) {
    return Discussion(
      address: json['address'] as String,
      name: json['name'] as String?,
      membersPubKeys: json['membersPubKeys'] as List<String>,
      adminsPubKeys: json['adminsPubKeys'] as List<String>,
      creationDate:
          DateTime.fromMillisecondsSinceEpoch(json['creationDate'] as int),
      lastMessage: json['lastMessage'] as DiscussionMessage?,
    );
  }

  @override
  Map<String, dynamic> toJson(Discussion discussion) {
    return {
      'address': discussion.address,
      'name': discussion.name,
      'membersPubKeys': discussion.membersPubKeys,
      'adminsPubKeys': discussion.adminsPubKeys,
      'creationDate': discussion.creationDate.millisecondsSinceEpoch,
      'lastMessage': discussion.lastMessage,
    };
  }
}

@freezed
@DiscussionConverter()
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
