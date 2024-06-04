import 'dart:async';
import 'dart:developer';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/infrastructure/datasources/vault/vault.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/authenticate/lock_overlay.mixin.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:lit_starfield/lit_starfield.dart';

part 'countdown_lock_screen.dart';
part 'lock_mask_screen.dart';

/// Listens to app state changes and schedules autoLock
/// accordingly.
/// Checks if lock is required on startup.
///
/// An hiding overlay is displayed as soon as the app becomes [AppLifecycleState.inactive].
/// Overlay is dismissed after checking if user authentication is necessary.
/// This behavior ensures the sensible content's hiding before unlocking.
class AutoLockGuard extends ConsumerStatefulWidget {
  const AutoLockGuard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AutoLockGuardState();
}

class _AutoLockGuardState extends ConsumerState<AutoLockGuard>
    with WidgetsBindingObserver {
  RestartableTimer? timer;

  static const _logName = 'AuthenticationGuard-Widget';

  @override
  void initState() {
    super.initState();
    log(
      'Init state',
      name: _logName,
    );

    WidgetsBinding.instance.addObserver(this);

    Vault.instance()
      ..passphraseDelegate = _forceAuthent
      ..shouldBeLocked = _shouldBeLocked;
  }

  @override
  void dispose() {
    if (timer != null) timer!.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _hideMask();
    Vault.instance()
      ..passphraseDelegate = null
      ..shouldBeLocked = null;

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log(
      'AppLifecycleState : $state',
      name: _logName,
    );
    switch (state) {
      case AppLifecycleState.resumed:
        _hideMask();
        Future.sync(() async {
          final vault = Vault.instance();
          await vault.applyAutolock();
          await vault.ensureVaultIsUnlocked();
        });

        break;
      case AppLifecycleState.inactive:
        _showMask();
        ref
            .read(AuthenticationProviders.authenticationGuard.notifier)
            .scheduleNextStartupAutolock();
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  void _unscheduleLock() {
    log('Unschedule lock', name: _logName);

    timer?.cancel();
    timer = null;
  }

  void _scheduleLock(Duration durationBeforeLock) {
    log('Schedule lock in $durationBeforeLock', name: _logName);
    timer?.cancel();
    timer = RestartableTimer(
      durationBeforeLock,
      () async {
        final vault = Vault.instance();
        await vault.lock();
        await vault.ensureVaultIsUnlocked();
      },
    );
  }

  void _showMask() {
    log(
      'Show lock mask',
      name: _logName,
    );
    if (ref.read(AuthenticationProviders.startupMaskVisibility) ==
        StartupMaskVisibility.visible) return;
    LockMaskOverlay.instance().show(context);
    ref.read(AuthenticationProviders.startupMaskVisibility.notifier).state =
        StartupMaskVisibility.visible;
  }

  void _hideMask() {
    log(
      'Hide lock mask',
      name: _logName,
    );
    LockMaskOverlay.instance().hide();
    ref.read(AuthenticationProviders.startupMaskVisibility.notifier).state =
        StartupMaskVisibility.hidden;
  }

  void _updateLockTimer() {
    final value = ref
        .watch(
          AuthenticationProviders.authenticationGuard,
        )
        .valueOrNull;
    final lockDate = value?.lockDate;

    if (value == null || lockDate == null) {
      _unscheduleLock();
      return;
    }

    final durationBeforeLock = lockDate.difference(DateTime.now());
    if (value.timerEnabled && durationBeforeLock > Duration.zero) {
      _scheduleLock(durationBeforeLock);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateLockTimer();

    return InputListener(
      onInput: () {
        ref
            .read(
              AuthenticationProviders.authenticationGuard.notifier,
            )
            .scheduleAutolock();
      },
      child: widget.child,
    );
  }

  Future<bool> _shouldBeLocked() async {
    log('Check if vault should be locked', name: _logName);
    final value = await ref.read(
      AuthenticationProviders.authenticationGuard.future,
    );

    final lockDate = value.lockDate;
    final authentRequired = lockDate != null;

    if (!authentRequired) {
      return false;
    }

    final durationBeforeLock = lockDate.difference(DateTime.now());
    log(
      'Duration before lock : $durationBeforeLock',
      name: _logName,
    );
    return durationBeforeLock <= Duration.zero;
  }

  static Completer<String>? _forceAuthenticationCompleter;
  Future<String> _forceAuthent() async {
    log(
      'Force authent',
      name: _logName,
    );

    if (_forceAuthenticationCompleter != null) {
      log(
        '... authent already running.',
        name: _logName,
      );

      return _forceAuthenticationCompleter!.future;
    }

    _forceAuthenticationCompleter = Completer<String>();
    try {
      final key = await AuthFactory.forceAuthenticate(
        context,
        ref,
        authMethod: ref.read(
          AuthenticationProviders.settings.select(
            (authSettings) => AuthenticationMethod(
              authSettings.authenticationMethod,
            ),
          ),
        ),
        canCancel: false,
      );

      ref
          .read(AuthenticationProviders.authenticationGuard.notifier)
          .scheduleAutolock();
      _hideMask();

      _forceAuthenticationCompleter?.complete(key);
      _forceAuthenticationCompleter = null;
    } catch (e) {
      _forceAuthenticationCompleter?.completeError(e);
      _forceAuthenticationCompleter = null;
    }

    return _forceAuthenticationCompleter!.future;
  }
}

class InputListener extends StatelessWidget {
  const InputListener({
    super.key,
    required this.onInput,
    required this.child,
  });

  final VoidCallback onInput;
  final Widget child;
  @override
  Widget build(BuildContext context) => Focus(
        onKeyEvent: (_, __) {
          onInput();
          return KeyEventResult.ignored;
        },
        child: Listener(
          onPointerDown: (_) => onInput(),
          onPointerMove: (_) => onInput(),
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              onInput();
              return true;
            },
            child: child,
          ),
        ),
      );
}
