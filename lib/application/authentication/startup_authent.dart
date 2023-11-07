part of 'authentication.dart';

@freezed
class StartupAuthentState with _$StartupAuthentState {
  const factory StartupAuthentState({
    /// [false] when lock has not been unscheduled on purpose
    /// [true] otherwise.
    ///
    /// When application is killed by OS or user,
    /// [lockDate] might be not set.
    /// In that case, we want to force show the lockscreen.
    ///
    /// [lockUnscheduled] is useful to discrimate case where
    ///  - lock has been unscheduled on user action
    ///  - lock is just not scheduled because of application savage kill
    required bool lockUnscheduled,

    /// After that date, application should lock when displayed
    DateTime? lockDate,
  }) = _StartupAuthentState;

  const StartupAuthentState._();

  bool get shouldLock {
    if (lockDate == null) return lockUnscheduled == false;
    return DateTime.now().isAfter(lockDate!);
  }
}

@Riverpod(keepAlive: true)
class StartupAuthentNotifier extends AsyncNotifier<StartupAuthentState> {
  static const logName = 'StartupAuthentNotifier';

  @override
  Future<StartupAuthentState> build() async {
    final autoLockOption = ref.watch(
      AuthenticationProviders.settings.select((settings) => settings.lock),
    );

    if (autoLockOption == UnlockOption.no) {
      return const StartupAuthentState(lockUnscheduled: false);
    }

    final lockDate = await ref
        .watch(AuthenticationProviders._authenticationRepository)
        .getAutoLockTriggerDate();
    return StartupAuthentState(
      lockUnscheduled: false,
      lockDate: lockDate,
    );
  }

  Future<void> scheduleAutolock() async {
    final loadedState = state.valueOrNull;
    if (loadedState == null) return;

    final autoLockOption = ref.read(
      AuthenticationProviders.settings.select((settings) => settings.lock),
    );

    if (autoLockOption == UnlockOption.no) {
      state = const AsyncValue.data(
        StartupAuthentState(lockUnscheduled: false),
      );
      return;
    }

    final lockDuration =
        ref.read(AuthenticationProviders.settings).lockTimeout.duration;
    final newAutoLockDate = DateTime.now().add(lockDuration);
    log(
      'Schedule Autolock : ${DateFormat().format(newAutoLockDate)}',
      name: logName,
    );
    await ref
        .read(AuthenticationProviders._authenticationRepository)
        .setAutoLockTriggerDate(newAutoLockDate);
    state = AsyncValue.data(
      loadedState.copyWith(lockDate: newAutoLockDate),
    );
  }

  Future<void> unscheduleAutolock() async {
    log(
      'Unschedule Autolock',
      name: logName,
    );
    await ref
        .read(AuthenticationProviders._authenticationRepository)
        .removeAutoLockTriggerDate();
    state = const AsyncValue.data(
      StartupAuthentState(lockUnscheduled: true),
    );
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
