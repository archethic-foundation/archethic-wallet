import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus { isConnected, isDisconnected }

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  ConnectivityStatusNotifier() : super(ConnectivityStatus.isDisconnected) {
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        final newState = result.toConnectivityStatus;
        if (newState != state) {
          state = newState;
        }
      },
    );
  }
  StreamController<ConnectivityResult> controller =
      StreamController<ConnectivityResult>();
}

extension _ConnectivityResultExt on ConnectivityResult {
  ConnectivityStatus get toConnectivityStatus {
    if (Platform.isLinux) {
      return ConnectivityStatus.isConnected;
    }
    switch (this) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.other:
      case ConnectivityResult.vpn:
        return ConnectivityStatus.isConnected;
      case ConnectivityResult.none:
        return ConnectivityStatus.isDisconnected;
    }
  }
}

final connectivityStatusProviders =
    StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>(
  (ref) => ConnectivityStatusNotifier(),
  name: 'connectivityStatusProvider',
);
