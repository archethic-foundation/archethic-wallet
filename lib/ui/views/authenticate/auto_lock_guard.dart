import 'dart:developer';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      await Navigator.of(context).pushNamed(
        '/lock_screen_transition',
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

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    SchedulerBinding.instance.addPostFrameCallback(
      (_) => _forceAuthentIfNeeded(context, ref),
    );

    super.initState();
  }

  @override
  void dispose() {
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
        _LockMask.show(context);
        ref.read(AuthenticationProviders.startupMaskVisibility.notifier).state =
            StartupMaskVisibility.visible;

        break;
      case AppLifecycleState.paused:
        ref
            .read(AuthenticationProviders.startupAuthentication.notifier)
            .scheduleAutolock();
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

  @override
  Widget build(BuildContext context) => widget.child;

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
    });
  }
}

class _LockMask extends ConsumerWidget {
  const _LockMask();
  static const routeName = 'LockMask';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SizedBox.expand(
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ArchethicTheme.backgroundSmall,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
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
