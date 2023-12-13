import 'dart:async';
import 'dart:developer';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/authenticate/lock_screen.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lit_starfield/lit_starfield.dart';
import 'package:synchronized/synchronized.dart';

/// Handles navigation to the lock screen
mixin LockGuardMixin {
  /// Displays lock screen (with the timer) if
  /// application should be locked (too much authentication failures).
  ///
  /// This must be called when check is needed.
  Future<void> showLockCountdownScreenIfNeeded(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final shouldLock = await ref.read(
      AuthenticationProviders.isLockCountdownRunning.future,
    );
    if (shouldLock) {
      context.go(
        AppLockScreen.routerPage,
      );
    }
  }
}

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
  static final _forceAuthenticationLock = Lock();
  RestartableTimer? timer;

  static const _logName = 'AuthenticationGuard-Widget';

  @override
  void initState() {
    log(
      'Init state',
      name: _logName,
    );

    WidgetsBinding.instance.addObserver(this);
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => _forceAuthentIfNeeded(),
    );

    super.initState();
  }

  @override
  void dispose() {
    if (timer != null) timer!.cancel();
    WidgetsBinding.instance.removeObserver(this);
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
        _forceAuthentIfNeeded();

        break;
      case AppLifecycleState.inactive:
        _showLockMask();
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
      _forceAuthent,
    );
  }

  void _showLockMask() {
    log(
      'Show lock mask',
      name: _logName,
    );
    if (ref.read(AuthenticationProviders.startupMaskVisibility) ==
        StartupMaskVisibility.visible) return;
    _LockMask.show(context);
    ref.read(AuthenticationProviders.startupMaskVisibility.notifier).state =
        StartupMaskVisibility.visible;
  }

  void _hideLockMask() {
    log(
      'Hide lock mask',
      name: _logName,
    );
    _LockMask.hide(context);
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

  Future<void> _forceAuthentIfNeeded() async {
    final value = await ref.read(
      AuthenticationProviders.authenticationGuard.future,
    );

    final lockDate = value.lockDate;

    if (lockDate == null) {
      _hideLockMask();
      return;
    }

    final durationBeforeLock = lockDate.difference(DateTime.now());
    log(
      'duration before lock : $durationBeforeLock',
      name: _logName,
    );
    if (durationBeforeLock <= Duration.zero) {
      await _forceAuthent();
      return;
    }
    _hideLockMask();
  }

  Future<void> _forceAuthent() async {
    if (_forceAuthenticationLock.inLock) {
      return;
    }

    await _forceAuthenticationLock.synchronized(() async {
      _showLockMask();
      await AuthFactory.forceAuthenticate(
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
      _hideLockMask();
    });
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
        onKey: (_, __) {
          onInput();
          return KeyEventResult.ignored;
        },
        child: Listener(
          onPointerDown: (_) => onInput(),
          child: child,
        ),
      );
}

class _LockMask extends ConsumerWidget {
  const _LockMask();
  static const routeName = 'LockMask';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ArchethicTheme.backgroundWelcome,
                  ),
                  fit: MediaQuery.of(context).size.width >= 400
                      ? BoxFit.fitWidth
                      : BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          const LitStarfieldContainer(
            backgroundDecoration: BoxDecoration(
              color: Colors.transparent,
            ),
          ),
          Image.asset(
            '${ArchethicTheme.assetsFolder}logo_crystal.png',
            width: 200,
          ),
        ],
      ),
    );
  }

  static void show(BuildContext context) {
    log('Show', name: routeName);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const _LockMask(),
        settings: const RouteSettings(name: routeName),
      ),
    );
  }

  static void hide(BuildContext context) {
    log('Hide', name: routeName);
    Navigator.of(context).popUntil(
      (route) => route.settings.name != routeName,
    );
  }
}
