import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/repositories/notifications_repository.dart';
import 'package:aewallet/infrastructure/repositories/notifications_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
NotificationsRepository _notificationRepository(Ref ref) =>
    NotificationsRepositoryImpl(
      networksSetting: ref.watch(
        SettingsProviders.settings.select((value) => value.network),
      ),
    );

Future<void> _keepPushSettingsUpToDateWorker(WidgetRef ref) async {
  ref.listen(LanguageProviders.selectedLocale, (previous, next) async {
    await ref
        .read(NotificationProviders.repository)
        .updatePushSettings(locale: next.languageCode);
  });
}

abstract class NotificationProviders {
  static final repository = _notificationRepositoryProvider;
  static const keepPushSettingsUpToDateWorker = _keepPushSettingsUpToDateWorker;
}
