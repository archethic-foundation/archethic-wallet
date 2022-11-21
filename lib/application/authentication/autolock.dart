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

    final autoLockOption = ref.watch(
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
        .watch(AuthenticationProviders._authenticationRepository)
        .setAutoLockTriggerDate(newAutoLockDate);
    state = AsyncValue.data(
      loadedState.copyWith(lockDate: newAutoLockDate),
    );
  }

  Future<void> unscheduleAutolock() async {
    await ref
        .watch(AuthenticationProviders._authenticationRepository)
        .removeAutoLockTriggerDate();
    state = const AsyncValue.data(AutoLockState());
  }
}
