import 'package:aewallet/model/data/settings.dart';
import 'package:aewallet/model/device_lock_timeout.dart';
import 'package:aewallet/model/device_unlock_option.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _localSettingsRepositoryProvider = Provider<Preferences>(
  (ref) => throw UnimplementedError(),
);

abstract class SettingsProviders {
  static final localSettingsRepository = _localSettingsRepositoryProvider;

  static final settings =
      StateNotifierProvider.autoDispose<SettingsNotifier, Settings>(
    (ref) {
      final preferences = ref.read(_localSettingsRepositoryProvider);

      return SettingsNotifier(
        preferences,
        preferences.toModel(),
      );
    },
  );
}

class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier(this.preferences, super.state);

  final Preferences preferences;

  Future<void> setLockApp(UnlockOption lockApp) async {
    await preferences.setLock(lockApp == UnlockOption.yes);
    state = state.copyWith(lock: lockApp);
  }

  // Future<void> setAuthMethod(AuthMethod method) async {
  //   await preferences.setAuthMethod(AuthenticationMethod(method));
  //   state = state.copyWith(authenticationMethod: method);
  // }

  Future<void> setLockTimeout(LockTimeoutOption lockTimeoutOption) async {
    await preferences.setLockTimeout(LockTimeoutSetting(lockTimeoutOption));
    state = state.copyWith(lockTimeout: lockTimeoutOption);
  }

  // Future<void> setPinPadShuffle(bool pinPadShuffle) async {
  //   await preferences.setPinPadShuffle(pinPadShuffle);
  //   state = state.copyWith(pinPadShuffle: pinPadShuffle);
  // }

  Future<void> setShowBalances(bool showBalances) async {
    await preferences.setShowBalances(showBalances);
    state = state.copyWith(showBalances: showBalances);
  }

  Future<void> setShowBlog(bool showBlog) async {
    await preferences.setShowBlog(showBlog);
    state = state.copyWith(showBlog: showBlog);
  }

  Future<void> setShowPriceChart(bool showPriceChart) async {
    await preferences.setShowPriceChart(showPriceChart);
    state = state.copyWith(showPriceChart: showPriceChart);
  }

  Future<void> setActiveNotifications(bool activeNotifications) async {
    await preferences.setActiveNotifications(activeNotifications);
    state = state.copyWith(activeNotifications: activeNotifications);
  }

  Future<void> setActiveVibrations(bool activeVibrations) async {
    await preferences.setActiveVibrations(activeVibrations);
    state = state.copyWith(activeVibrations: activeVibrations);
  }
}
