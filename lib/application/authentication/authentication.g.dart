// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authenticationRepositoryHash() =>
    r'b630377593d057ef93c30f51effb5524980151b1';

/// See also [_authenticationRepository].
@ProviderFor(_authenticationRepository)
final _authenticationRepositoryProvider =
    Provider<AuthenticationRepositoryInterface>.internal(
  _authenticationRepository,
  name: r'_authenticationRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authenticationRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _AuthenticationRepositoryRef
    = ProviderRef<AuthenticationRepositoryInterface>;
String _$isLockCountdownRunningHash() =>
    r'163c697c12971cf530cd89420c054b1408c2314f';

/// See also [_isLockCountdownRunning].
@ProviderFor(_isLockCountdownRunning)
final _isLockCountdownRunningProvider = FutureProvider<bool>.internal(
  _isLockCountdownRunning,
  name: r'_isLockCountdownRunningProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isLockCountdownRunningHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _IsLockCountdownRunningRef = FutureProviderRef<bool>;
String _$lockCountdownHash() => r'd68cdb54ca24255c83a97738a64b623887a940cf';

/// See also [_lockCountdown].
@ProviderFor(_lockCountdown)
final _lockCountdownProvider = StreamProvider<Duration>.internal(
  _lockCountdown,
  name: r'_lockCountdownProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lockCountdownHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _LockCountdownRef = StreamProviderRef<Duration>;
String _$vaultLockedHash() => r'874d9cd95389e04cda4578dfbf1889615c135ce0';

/// See also [_vaultLocked].
@ProviderFor(_vaultLocked)
final _vaultLockedProvider = Provider<bool>.internal(
  _vaultLocked,
  name: r'_vaultLockedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$vaultLockedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _VaultLockedRef = ProviderRef<bool>;
String _$lastInteractionDateNotifierHash() =>
    r'fdd8f1f1e47205aaf7128fa16ff9045fb92af836';

/// See also [_LastInteractionDateNotifier].
@ProviderFor(_LastInteractionDateNotifier)
final _lastInteractionDateNotifierProvider = AsyncNotifierProvider<
    _LastInteractionDateNotifier, LastInteractionDateValue>.internal(
  _LastInteractionDateNotifier.new,
  name: r'_lastInteractionDateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lastInteractionDateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LastInteractionDateNotifier = AsyncNotifier<LastInteractionDateValue>;
String _$authenticationGuardNotifierHash() =>
    r'616630e7a9523db11e6d83faee4d7adb9a60a8cf';

/// See also [_AuthenticationGuardNotifier].
@ProviderFor(_AuthenticationGuardNotifier)
final _authenticationGuardNotifierProvider = AsyncNotifierProvider<
    _AuthenticationGuardNotifier, AuthenticationGuardState>.internal(
  _AuthenticationGuardNotifier.new,
  name: r'_authenticationGuardNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authenticationGuardNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthenticationGuardNotifier = AsyncNotifier<AuthenticationGuardState>;
String _$passwordAuthenticationNotifierHash() =>
    r'02c3614561a3b1e763942a19d0a7260e45d3575f';

/// See also [_PasswordAuthenticationNotifier].
@ProviderFor(_PasswordAuthenticationNotifier)
final _passwordAuthenticationNotifierProvider =
    AutoDisposeAsyncNotifierProvider<_PasswordAuthenticationNotifier,
        PasswordAuthenticationState>.internal(
  _PasswordAuthenticationNotifier.new,
  name: r'_passwordAuthenticationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$passwordAuthenticationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PasswordAuthenticationNotifier
    = AutoDisposeAsyncNotifier<PasswordAuthenticationState>;
String _$pinAuthenticationNotifierHash() =>
    r'37c4f01866b8251255cd2eb0edec55b048cac8d9';

/// See also [_PinAuthenticationNotifier].
@ProviderFor(_PinAuthenticationNotifier)
final _pinAuthenticationNotifierProvider = AutoDisposeAsyncNotifierProvider<
    _PinAuthenticationNotifier, PinAuthenticationState>.internal(
  _PinAuthenticationNotifier.new,
  name: r'_pinAuthenticationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pinAuthenticationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PinAuthenticationNotifier
    = AutoDisposeAsyncNotifier<PinAuthenticationState>;
String _$authenticationSettingsNotifierHash() =>
    r'9600bc25df6d98026447385e1cf6fc8fb56eb3df';

/// See also [_AuthenticationSettingsNotifier].
@ProviderFor(_AuthenticationSettingsNotifier)
final _authenticationSettingsNotifierProvider = NotifierProvider<
    _AuthenticationSettingsNotifier, AuthenticationSettings>.internal(
  _AuthenticationSettingsNotifier.new,
  name: r'_authenticationSettingsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authenticationSettingsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthenticationSettingsNotifier = Notifier<AuthenticationSettings>;
String _$yubikeyAuthenticationNotifierHash() =>
    r'45e719fee62ae10d5856a26608b5284c374bc510';

/// See also [_YubikeyAuthenticationNotifier].
@ProviderFor(_YubikeyAuthenticationNotifier)
final _yubikeyAuthenticationNotifierProvider = AutoDisposeAsyncNotifierProvider<
    _YubikeyAuthenticationNotifier, YubikeyAuthenticationState>.internal(
  _YubikeyAuthenticationNotifier.new,
  name: r'_yubikeyAuthenticationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$yubikeyAuthenticationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$YubikeyAuthenticationNotifier
    = AutoDisposeAsyncNotifier<YubikeyAuthenticationState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
