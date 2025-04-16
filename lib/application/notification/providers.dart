import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/domain/repositories/notifications_repository.dart';
import 'package:aewallet/infrastructure/repositories/notifications_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
NotificationsRepository _notificationRepository(
  Ref ref,
) =>
    NotificationsRepositoryImpl();

@riverpod
Stream<TxSentEvent> _txSentEvents(
  Ref ref,
  String txChainGenesisAddress,
) =>
    ref.watch(_notificationRepositoryProvider).events.where(
          (event) =>
              event.txChainGenesisAddress.toUpperCase() ==
              txChainGenesisAddress.toUpperCase(),
        );

@riverpod
Future<void> _keepPushSettingsUpToDateWorker(Ref ref) async {
  final locale = ref.watch(
    LanguageProviders.selectedLocale.select((value) => value.languageCode),
  );
  await ref.watch(_notificationRepositoryProvider).updatePushSettings(
        locale: locale,
      );
}

abstract class NotificationProviders {
  static final repository = _notificationRepositoryProvider;
  static final keepPushSettingsUpToDateWorker =
      _keepPushSettingsUpToDateWorkerProvider;
  static const txSentEvents = _txSentEventsProvider;
}
