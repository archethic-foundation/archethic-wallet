part of 'authentication.dart';

@freezed
class AutoLockState with _$AutoLockState {
  const factory AutoLockState({
    /// After that date, application should lock when displayed
    DateTime? lockDate,
  }) = _AutoLockState;

  const AutoLockState._();

  bool get shouldLock {
    if (lockDate == null) return false;
    return DateTime.now().isAfter(lockDate!);
  }
}

@Riverpod(keepAlive: true)
class AutoLockNotifier extends AsyncNotifier<AutoLockState> {
  @override
  Future<AutoLockState> build() async {
    final autoLockOption = ref.watch(
      AuthenticationProviders.settings.select((settings) => settings.lock),
    );

    if (autoLockOption == UnlockOption.no) {
      return const AutoLockState();
    }

    final lockDate = await ref
        .watch(AuthenticationProviders._authenticationRepository)
        .getAutoLockTriggerDate();
    return AutoLockState(
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
      state = const AsyncValue.data(AutoLockState());
      return;
    }

    final lockDuration =
        ref.read(AuthenticationProviders.settings).lockTimeout.duration;
    final newAutoLockDate = DateTime.now().add(lockDuration);
    await ref
        .read(AuthenticationProviders._authenticationRepository)
        .setAutoLockTriggerDate(newAutoLockDate);
    state = AsyncValue.data(
      loadedState.copyWith(lockDate: newAutoLockDate),
    );
  }

  Future<void> unscheduleAutolock() async {
    await ref
        .read(AuthenticationProviders._authenticationRepository)
        .removeAutoLockTriggerDate();
    state = const AsyncValue.data(AutoLockState());
  }
}

/// The [AutoLockGuard] widget visibility
/// Set to [AutoLockMaskVisiblity.visible] when the app is coming to foreground
/// while checking if authentication is necessary.
typedef AutoLockMaskVisibilityProvider = StateProvider<AutoLockMaskVisibility>;

enum AutoLockMaskVisibility {
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
        AuthenticationProviders.autoLockMaskVisibility,
        (_, next) => next == AutoLockMaskVisibility.hidden,
      );
}
