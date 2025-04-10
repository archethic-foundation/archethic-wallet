import 'package:aewallet/infrastructure/datasources/appdb.hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'notification_setup_dto.freezed.dart';
part 'notification_setup_dto.g.dart';

@freezed
class NotificationsSetup with _$NotificationsSetup {
  @HiveType(typeId: HiveTypeIds.notificationsSetup)
  const factory NotificationsSetup({
    @HiveField(0, defaultValue: []) required List<String> listenedAddresses,
    @HiveField(1) String? lastFcmToken,
  }) = _NotificationsSetup;
  const NotificationsSetup._();
}
