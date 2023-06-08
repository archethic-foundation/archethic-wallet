import 'package:aewallet/model/data/access_recipient.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'talk.freezed.dart';
part 'talk.g.dart';

@freezed
class Talk with _$Talk {
  @HiveType(typeId: HiveTypeIds.talk)
  const factory Talk({
    @HiveField(0) required String address,
    @HiveField(1) required String name,
    @HiveField(2) required List<AccessRecipient> members,
    @HiveField(3) required List<AccessRecipient> admins,
  }) = _Talk;

  const Talk._();
}
