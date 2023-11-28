part of 'authentication.dart';

typedef LastInteractionDateValue = ({
  /// Last user interaction date.
  /// [null] when no interaction ever.
  DateTime? date,

  /// Has the value ever changed since
  /// application is in foreground ?
  bool isStartupValue,
});

class LastInteractionDateNotifier
    extends AsyncNotifier<LastInteractionDateValue> {
  static const _logName = 'AuthenticationGuard-LastInteractionDateProvider';

  @override
  FutureOr<LastInteractionDateValue> build() async {
    return (
      date: await ref
          .watch(AuthenticationProviders._authenticationRepository)
          .getLastInteractionDate(),
      isStartupValue: true,
    );
  }

  void updateLastInteractionDate() {
    state = AsyncValue.data(
      (
        date: DateTime.now(),
        isStartupValue: false,
      ),
    );
  }

  Future<void> persist() async {
    final date = state.value?.date;
    if (date == null) return;

    await ref
        .read(AuthenticationProviders._authenticationRepository)
        .setLastInteractionDate(date);
    log('persist $date', name: _logName);
    state = AsyncValue.data(
      (
        date: date,
        isStartupValue: true,
      ),
    );
  }

  Future<void> clear() async {
    log('clear storage', name: _logName);

    await ref
        .read(AuthenticationProviders._authenticationRepository)
        .removeLastInteractionDate();

    state = const AsyncValue.data(
      (
        date: null,
        isStartupValue: false,
      ),
    );
  }
}

final _lastInteractionDateNotifierProvider = AsyncNotifierProvider<
    LastInteractionDateNotifier, LastInteractionDateValue>(
  LastInteractionDateNotifier.new,
  name: LastInteractionDateNotifier._logName,
);

@freezed
class AuthenticationGuardState with _$AuthenticationGuardState {
  const factory AuthenticationGuardState({
    /// Date at which the application should be locked
    /// [null] when application should not be locked
    required DateTime? lockDate,

    /// [true] when a timer should be set to
    /// lock application during use.
    required bool timerEnabled,
  }) = _AuthenticationGuardState;

  const AuthenticationGuardState._();
}

@Riverpod(keepAlive: true)
class AuthenticationGuardNotifier
    extends AsyncNotifier<AuthenticationGuardState> {
  static const logName = 'AuthenticationGuard-Provider';
  RestartableTimer? timer;

  @override
  Future<AuthenticationGuardState> build() async {
    final autoLockOption = ref.watch(
      AuthenticationProviders.settings.select((settings) => settings.lock),
    );

    if (autoLockOption == UnlockOption.no) {
      return const AuthenticationGuardState(
        lockDate: null,
        timerEnabled: false,
      );
    }

    final lockTimeout = ref.watch(
      AuthenticationProviders.settings.select(
        (settings) => settings.lockTimeout.duration,
      ),
    );

    return AuthenticationGuardState(
      lockDate: await _lockDate,
      timerEnabled: lockTimeout > Duration.zero,
    );
  }

  Future<DateTime?> get _lockDate async {
    final lastInteractionDate = await ref.watch(
      _lastInteractionDateNotifierProvider.future,
    );

    final lockTimeout = ref.watch(
      AuthenticationProviders.settings.select(
        (settings) => settings.lockTimeout.duration,
      ),
    );

    /// Lock without delay only applies to application startup.
    /// That lock won't be applied otherwise because it would
    /// constantly lock screen.
    if (!lastInteractionDate.isStartupValue && lockTimeout == Duration.zero) {
      return null;
    }

    final date = lastInteractionDate.date;
    if (date != null) return date.add(lockTimeout);

    /// When application is just starting, and
    /// no lastInteractionDate is set, force
    /// lockDate to now.
    ///
    /// In that case, we might assume that application
    /// has been killed before saving [lastInteractionDate]
    if (lastInteractionDate.isStartupValue) return DateTime.now();

    return null;
  }

  Future<void> scheduleNextStartupAutolock() async {
    log(
      'Schedule next startup Autolock',
      name: logName,
    );

    final loadedState = state.valueOrNull;
    if (loadedState == null) return;

    final lastInteractionDateNotifier = ref
        .read(_lastInteractionDateNotifierProvider.notifier)
      ..updateLastInteractionDate();
    await lastInteractionDateNotifier.persist();
  }

  Future<void> scheduleAutolock() async {
    log(
      'Schedule Autolock',
      name: logName,
    );

    final loadedState = state.valueOrNull;
    if (loadedState == null) return;

    ref
        .read(_lastInteractionDateNotifierProvider.notifier)
        .updateLastInteractionDate();
  }

  Future<void> unscheduleAutolock() async {
    log(
      'Unschedule Autolock',
      name: logName,
    );
    await ref.read(_lastInteractionDateNotifierProvider.notifier).clear();
  }
}

/// The AutoLockGuard widget visibility
/// Set to [StartupMaskVisibility.visible] when the app is coming to foreground
/// while checking if authentication is necessary.
typedef StartupMaskVisibilityProvider = StateProvider<StartupMaskVisibility>;

enum StartupMaskVisibility {
  hidden,
  visible,
}

extension AutoLockMaskVisibilityProviderExt on WidgetRef {
  /// Ensures the AutoLockMask screen is dismissed.
  ///
  /// This is extremely important to wait for AutoLockMask to be dismissed
  /// when Navigating after any operation that changes the application state :
  ///   - biometrics verification
  ///   - screen capture
  ///   - camera usage
  ///   - ...
  Future<void> ensuresAutolockMaskHidden() async => waitUntil(
        AuthenticationProviders.startupMaskVisibility,
        (_, next) => next == StartupMaskVisibility.hidden,
      );
}
