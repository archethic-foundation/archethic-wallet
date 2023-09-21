import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/repositories/notifications_repository.dart';
import 'package:aewallet/infrastructure/repositories/notifications_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
NotificationsRepository _notificationRepository(
  _NotificationRepositoryRef ref,
) =>
    NotificationsRepositoryImpl(
      networksSetting: ref.watch(
        SettingsProviders.settings.select((value) => value.network),
      ),
    );

@riverpod
Stream<TxSentEvent> _txSentEvents(
  _TxSentEventsRef ref,
  String txChainGenesisAddress,
) =>
    ref.watch(_notificationRepositoryProvider).events.where(
          (event) =>
              event.listenAddress.toUpperCase() ==
              txChainGenesisAddress.toUpperCase(),
        );

Future<void> _keepPushSettingsUpToDateWorker(
  WidgetRef ref,
) async {
  final locale = ref.watch(
    LanguageProviders.selectedLocale.select((value) => value.languageCode),
  );
  await ref.watch(_notificationRepositoryProvider).updatePushSettings(
        locale: locale,
      );
}

abstract class NotificationProviders {
  static final repository = _notificationRepositoryProvider;
  static const keepPushSettingsUpToDateWorker = _keepPushSettingsUpToDateWorker;
  static const txSentEvents = _txSentEventsProvider;
}
