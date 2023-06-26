import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/repositories/notifications_repository.dart';
import 'package:aewallet/infrastructure/repositories/notifications_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
NotificationsRepository _notificationRepository(Ref ref) =>
    NotificationsRepositoryImpl(
      networksSetting: ref.watch(
        SettingsProviders.settings.select((value) => value.network),
      ),
    );

abstract class NotificationProviders {
  static final repository = _notificationRepositoryProvider;
}
