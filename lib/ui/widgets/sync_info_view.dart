// @dart=2.9

import 'dart:async';

import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:uniris_mobile_wallet/bus/events.dart';
import 'package:uniris_mobile_wallet/styles.dart';

class SyncInfoView extends StatefulWidget {
  const SyncInfoView({Key key}) : super(key: key);

  @override
  _SyncInfoViewState createState() => _SyncInfoViewState();
}

class _SyncInfoViewState extends State<SyncInfoView> {
  bool connected;
  String serverName = "";

  // Subscriptions
  StreamSubscription<ConnStatusEvent> _connStatusEventSub;

  @override
  void initState() {
    _registerBus();
    super.initState();
  }

  void _registerBus() {
    _connStatusEventSub =
        EventTaxiImpl.singleton().registerTo<ConnStatusEvent>().listen((event) {
      setState(() {
        serverName = event.server;
        if (event.status == ConnectionStatus.CONNECTED) {
          connected = true;
        } else {
          connected = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  void _destroyBus() {
    if (_connStatusEventSub != null) {
      _connStatusEventSub.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildChild();
  }

  Widget _buildChild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(serverName, style: AppStyles.textStyleTiny(context)),
        connected == null || connected == false
            ? Icon(Icons.signal_cellular_alt_rounded, color: Colors.red)
            : Icon(Icons.signal_cellular_alt_rounded, color: Colors.green),
      ],
    );
  }
}
