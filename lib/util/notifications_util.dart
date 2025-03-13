/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsUtil {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final StreamController<String?> _notificationsController =
      StreamController<String?>.broadcast();
  static Stream<String?> get onNotifications => _notificationsController.stream;

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
      macOS: DarwinNotificationDetails(),
    );
  }

  static Future init() async {
    const android = AndroidInitializationSettings('@drawable/ic_notification');
    const iOS = DarwinInitializationSettings();
    const macOS = DarwinInitializationSettings();
    const linux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    const settings = InitializationSettings(
      android: android,
      iOS: iOS,
      macOS: macOS,
      linux: linux,
    );
    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) async {
        _notificationsController.add(response.payload);
      },
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );
}
