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
  static final _logger =
      Logger('AuthenticationGuard-LastInteractionDateProvider');

  @override
  FutureOr<LastInteractionDateValue> build() async {
    return (
      date: await ref
          .watch(AuthenticationProviders.authenticationRepository)
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
        .read(AuthenticationProviders.authenticationRepository)
        .setLastInteractionDate(date);
    _logger.info('persist $date');
    state = AsyncValue.data(
      (
        date: date,
        isStartupValue: true,
      ),
    );
  }

  Future<void> clear() async {
    _logger.fine('clear storage');

    await ref
        .read(AuthenticationProviders.authenticationRepository)
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
  name: LastInteractionDateNotifier._logger.name,
);

final _vaultLockedProvider = Provider<bool>(
  (ref) {
    Vault.instance().isLocked.addListener(ref.invalidateSelf);
    ref.onDispose(
      () {
        Vault.instance().isLocked.removeListener(ref.invalidateSelf);
      },
    );
    return Vault.instance().isLocked.value;
  },
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

    /// [true] if application is locked
    required bool isLocked,
  }) = _AuthenticationGuardState;

  const AuthenticationGuardState._();
}

@Riverpod(keepAlive: true)
class AuthenticationGuardNotifier
    extends AsyncNotifier<AuthenticationGuardState> {
  static final _logger = Logger('AuthenticationGuard-Provider');

  @override
  Future<AuthenticationGuardState> build() async {
    final lockTimeoutOption = ref.watch(
      AuthenticationProviders.settings.select(
        (settings) => settings.lockTimeout,
      ),
    );

    final isLocked = ref.watch(_vaultLockedProvider);

    if (lockTimeoutOption == LockTimeoutOption.disabled) {
      return AuthenticationGuardState(
        lockDate: null,
        timerEnabled: false,
        isLocked: isLocked,
      );
    }

    return AuthenticationGuardState(
      lockDate: await _lockDate,
      timerEnabled: lockTimeoutOption.duration > Duration.zero,
      isLocked: isLocked,
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

  Future<void> lock() async {
    final vault = Vault.instance();
    await vault.lock();
    await vault.ensureVaultIsUnlocked();
  }

  /// Asks for user input to unlock
  /// the Vault if required.
  Future<void> unlock() async {
    final vault = Vault.instance();
    await vault.applyAutolock();
    await vault.ensureVaultIsUnlocked();
  }

  Future<void> scheduleNextStartupAutolock() async {
    _logger.info(
      'Schedule next startup Autolock',
    );

    final loadedState = state.valueOrNull;
    if (loadedState == null) return;

    final lastInteractionDateNotifier = ref
        .read(_lastInteractionDateNotifierProvider.notifier)
      ..updateLastInteractionDate();
    await lastInteractionDateNotifier.persist();
  }

  void scheduleAutolock() {
    _logger.info(
      'Schedule Autolock',
    );

    final loadedState = state.valueOrNull;
    if (loadedState == null) return;

    ref
        .read(_lastInteractionDateNotifierProvider.notifier)
        .updateLastInteractionDate();
  }

  Future<void> unscheduleAutolock() async {
    _logger.info(
      'Unschedule Autolock',
    );
    await ref.read(_lastInteractionDateNotifierProvider.notifier).clear();
  }
}
