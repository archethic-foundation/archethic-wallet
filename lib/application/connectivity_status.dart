import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus { notDetermined, isConnected, isDisconnected }

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  ConnectivityStatusNotifier() : super(ConnectivityStatus.isConnected) {
    if (state == ConnectivityStatus.isConnected) {
      lastResult = ConnectivityStatus.isConnected;
    } else {
      lastResult = ConnectivityStatus.isDisconnected;
    }
    lastResult = ConnectivityStatus.notDetermined;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
        case ConnectivityResult.ethernet:
        case ConnectivityResult.bluetooth:
        case ConnectivityResult.vpn:
          newState = ConnectivityStatus.isConnected;
          break;
        case ConnectivityResult.none:
          newState = ConnectivityStatus.isDisconnected;
          break;
      }
      if (newState != lastResult) {
        state = newState!;
        lastResult = newState;
      }
    });
  }
  StreamController<ConnectivityResult> controller =
      StreamController<ConnectivityResult>();

  ConnectivityStatus? lastResult;
  ConnectivityStatus? newState;
}

final connectivityStatusProviders = StateNotifierProvider((ref) {
  return ConnectivityStatusNotifier();
});
