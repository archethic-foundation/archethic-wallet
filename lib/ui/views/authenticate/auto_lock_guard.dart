import 'dart:developer';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/device_lock_timeout.dart';
import 'package:aewallet/model/device_unlock_option.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    final authentication = ref.read(AuthenticationProviders.settings);
    if (authentication.lock == UnlockOption.yes &&
        authentication.lockTimeout != LockTimeoutOption.zero) {
      timer = RestartableTimer(
        authentication.lockTimeout.duration,
        onInactivityTimeout,
      );
    }

    SchedulerBinding.instance.addPostFrameCallback(
      (_) => _forceAuthentIfNeeded(context, ref),
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
    switch (state) {
      case AppLifecycleState.resumed:
        _forceAuthentIfNeeded(context, ref);
        break;
      case AppLifecycleState.inactive:
        if (ref.read(AuthenticationProviders.startupMaskVisibility) ==
            StartupMaskVisibility.visible) return;
        _showLockMask();

        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        ref
            .read(AuthenticationProviders.startupAuthentication.notifier)
            .scheduleAutolock();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  void _showLockMask() {
    _LockMask.show(context, () => _forceAuthentIfNeeded(context, ref));
    ref.read(AuthenticationProviders.startupMaskVisibility.notifier).state =
        StartupMaskVisibility.visible;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (details) {
        _forceAuthentIfNeeded(context, ref);
        if (timer != null) timer!.reset();
      },
      child: widget.child,
    );
  }

  Future<void> onInactivityTimeout() async {
    if (ref.read(AuthenticationProviders.startupMaskVisibility) ==
        StartupMaskVisibility.visible) return;
    _showLockMask();
  }

  Future<void> _forceAuthentIfNeeded(
    BuildContext context,
    WidgetRef ref,
  ) async {
    if (_forceAuthenticationLock.inLock) {
      return;
    }

    await _forceAuthenticationLock.synchronized(() async {
      final shouldLockOnStartup = await ref.read(
        AuthenticationProviders.shouldAuthentOnStartup.future,
      );

      if (shouldLockOnStartup) {
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
      }
      await ref
          .read(AuthenticationProviders.startupAuthentication.notifier)
          .unscheduleAutolock();

      _LockMask.hide(context);
      ref.read(AuthenticationProviders.startupMaskVisibility.notifier).state =
          StartupMaskVisibility.hidden;
      if (timer != null) timer!.reset();
    });
  }
}

class _LockMask extends ConsumerWidget {
  const _LockMask({required this.onMaskTapCallback});
  final Future<void> Function() onMaskTapCallback;
  static const routeName = 'LockMask';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        await onMaskTapCallback();
      },
      child: WillPopScope(
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
      ),
    );
  }

  static void show(
      BuildContext context, Future<void> Function() onMaskTapCallback) {
    log('Show', name: routeName);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _LockMask(onMaskTapCallback: onMaskTapCallback),
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
