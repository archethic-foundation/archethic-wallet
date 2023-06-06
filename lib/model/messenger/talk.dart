import 'package:aewallet/model/data/appdb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
part 'talk.freezed.dart';
part 'talk.g.dart';

@freezed
class Talk with _$Talk {
  const Talk._();
  @HiveType(typeId: HiveTypeIds.talk)
  const factory Talk({
    @HiveField(0) required String address,
    @HiveField(1) required String name,
  }) = _Talk;
}
