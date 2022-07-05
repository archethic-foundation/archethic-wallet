import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:core/localization.dart';
import 'package:flutter/material.dart';

/// SPDX-License-Identifier: AGPL-3.0-or-later

class NotificationIconWidget extends StatefulWidget {
  final _NotificationIconWidgetState abs = _NotificationIconWidgetState();
  void refresh() {
    abs.refresh();
  }

  @override
  _NotificationIconWidgetState createState() => abs;
}

class _NotificationIconWidgetState extends State<NotificationIconWidget> {
  @override
  Widget build(BuildContext context) {
    return StateContainer.of(context).activeNotifications
        ? IconButton(
            icon: Icon(Icons.notifications_active_outlined),
            onPressed: () async {
              StateContainer.of(context).activeNotifications = false;
              if (StateContainer.of(context).timerCheckTransactionInputs !=
                  null) {
                StateContainer.of(context)
                    .timerCheckTransactionInputs!
                    .cancel();
              }
              final Preferences preferences = await Preferences.getInstance();
              preferences.setActiveNotifications(false);
              StateContainer.of(context).notificationIconWidget.refresh();
            })
        : IconButton(
            icon: Icon(Icons.notifications_off_outlined),
            onPressed: () async {
              StateContainer.of(context).activeNotifications = true;

              if (StateContainer.of(context).timerCheckTransactionInputs !=
                  null) {
                StateContainer.of(context)
                    .timerCheckTransactionInputs!
                    .cancel();
              }
              StateContainer.of(context).checkTransactionInputs(
                  AppLocalization.of(context)!.transactionInputNotification);
              final Preferences preferences = await Preferences.getInstance();
              preferences.setActiveNotifications(true);
              StateContainer.of(context).notificationIconWidget.refresh();
            });
  }

  void refresh() {
    setState(() {});
  }
}
