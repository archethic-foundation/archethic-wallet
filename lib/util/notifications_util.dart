/// SPDX-License-Identifier: AGPL-3.0-or-later

// Package imports:
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationsUtil {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description',
            importance: Importance.max),
        iOS: IOSNotificationDetails(),
        macOS: MacOSNotificationDetails());
  }

  static Future init() async {
    const android = AndroidInitializationSettings('@drawable/ic_stat');
    const iOS = IOSInitializationSettings();
    const macOS = MacOSInitializationSettings();
    const settings =
        InitializationSettings(android: android, iOS: iOS, macOS: macOS);
    await _notifications.initialize(settings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);
}
